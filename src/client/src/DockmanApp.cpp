#include <QCoreApplication>
#include <QDir>
#include <QQmlContext>
#include <qguiapplication.h>

#include "dockman/DockmanApp.h"
#include "dockman/HostListModel.h"
#include "dockman/HostStorage.h"
#include "dockman/Logger.h"

DockmanApp::DockmanApp(QObject *parent)
    : QObject(parent)
    , m_qmlEngine(new QQmlApplicationEngine(this))
{
    connect(
        m_qmlEngine, &QQmlApplicationEngine::objectCreationFailed, this,
        []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);
}

DockmanApp::~DockmanApp() = default;

bool DockmanApp::init(const QString &appDataPath)
{
    m_hostsStorage.reset(new HostStorage(QDir(appDataPath).filePath("hosts.json")));
    m_hostsModel = new HostListModel(this);

    const auto hosts = m_hostsStorage->loadHosts();
    if (hosts.empty() && !m_hostsStorage->lastError().isEmpty()) {
        Log_Warning("Failed to load hosts from file " +
                    m_hostsStorage->storageFile().toStdString() + ": " +
                    m_hostsStorage->lastError().toStdString());
    } else {
        m_hostsModel->setHosts(hosts);
    }

    connect(QGuiApplication::instance(), &QGuiApplication::aboutToQuit, this,
            &DockmanApp::saveAppData);

    connect(m_hostsModel, &HostListModel::hostsChanged, this, &DockmanApp::saveAppData);

    m_qmlEngine->rootContext()->setContextProperty("hostListModel", m_hostsModel);
    m_qmlEngine->loadFromModule("Dockman.Presentation", "Main");

    return true;
}
void DockmanApp::saveAppData()
{
    const auto hosts = m_hostsModel->hosts();
    if (!m_hostsStorage->saveHosts(hosts)) {
        Log_Warning("Failed to save hosts to file " + m_hostsStorage->storageFile().toStdString() +
                    ": " + m_hostsStorage->lastError().toStdString());
    }
}
