#include <QDir>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>
#include <QQuickStyle>
#include <QStandardPaths>

#include "config.h"
#include "dockman/HostListModel.h"
#include "dockman/HostStorage.h"
#include "dockman/Logger.h"

bool createDataDir()
{
    QDir dir(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation));
    if (!dir.mkpath(".")) {
        Log_Error("Failed to create data directory" + dir.path().toStdString());
        return false;
    }

    return true;
}

int main(int argc, char *argv[])
{
    Log_Info(std::string("Dockman version: ") + DOCKMAN_VERSION);

#ifdef __linux__
    qputenv("QT_QPA_PLATFORMTHEME", "flatpak");
#endif

    QQuickStyle::setStyle("Fusion");

    QGuiApplication app(argc, argv);
    app.setApplicationName(QStringLiteral("Dockman"));
    app.setOrganizationName(QStringLiteral("Dockman"));
    app.setOrganizationDomain("dockman.com");

    if (!createDataDir()) {
        return -1;
    }

    QQmlApplicationEngine engine;

    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
        []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);

    const QString HOSTS_FILE =
        QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/hosts.json";

    HostStorage hostStorage(HOSTS_FILE);

    auto hostsModel = new HostListModel(&engine);
    const auto hosts = hostStorage.loadHosts();

    if (hosts.empty() && !hostStorage.lastError().isEmpty()) {
        Log_Warning("Failed to load hosts from file " + hostStorage.storageFile().toStdString() +
                    ": " + hostStorage.lastError().toStdString());
    }

    hostsModel->setHosts(hosts);

    QObject::connect(&app, &QGuiApplication::aboutToQuit, [&hostStorage, hostsModel]() {
        const auto hosts = hostsModel->hosts();
        if (!hostStorage.saveHosts(hosts)) {
            Log_Warning("Failed to save hosts to file " + hostStorage.storageFile().toStdString() +
                        ": " + hostStorage.lastError().toStdString());
        }
    });

    engine.rootContext()->setContextProperty("hostListModel", hostsModel);
    engine.loadFromModule("Dockman.Presentation", "Main");

    return app.exec();
}

