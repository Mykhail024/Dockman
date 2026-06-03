#pragma once

#include <QObject>
#include <QQmlApplicationEngine>

class HostStorage;
class HostListModel;

class DockmanApp : public QObject
{
        Q_OBJECT
    public:
        DockmanApp(QObject *parent = nullptr);
        ~DockmanApp();

        bool init(const QString &appDataPath);

    public slots:
        void saveAppData();

    private:
        QQmlApplicationEngine *m_qmlEngine;
        std::unique_ptr<HostStorage> m_hostsStorage;
        HostListModel *m_hostsModel;
};
