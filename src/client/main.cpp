#include <QCoreApplication>
#include <QDir>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQuickStyle>
#include <QStandardPaths>

#include "config.h"
#include "dockman/logger.h"

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

    const QUrl url(QStringLiteral("qrc:/Dockman/Presentation/main.qml"));

    QQmlApplicationEngine engine;

    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}

