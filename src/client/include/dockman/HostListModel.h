#pragma once

#include <QAbstractListModel>
#include <QVector>
#include <qnamespace.h>

#include "dockman/Host.h"

class HostListModel : public QAbstractListModel
{
        Q_OBJECT

    public:
        HostListModel(QObject *parent = nullptr);

        int rowCount(const QModelIndex &parent = QModelIndex()) const override;
        QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
        QHash<int, QByteArray> roleNames() const override;

        void setHosts(const QVector<Host> &hosts);
        [[nodiscard]] QVector<Host> hosts() const;
        void addHost(const Host &host);

        Q_INVOKABLE bool addHost(const QString &name, const QString &address, const quint16 port);

    signals:
        void hostsChanged();

    private:
        enum Roles {
            IdRole = Qt::UserRole + 1,
            AddressRole,
            PortRole,
            NameRole,
            ConnectedRole,
            LastErrorRole
        };

        struct HostRuntimeState
        {
                bool connected = false;
                QString lastError;
        };
        struct HostItem
        {
                Host host;
                HostRuntimeState state;
        };

        QVector<HostItem> m_hosts;
};
