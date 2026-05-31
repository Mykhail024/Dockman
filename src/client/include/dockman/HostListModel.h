#pragma once

#include <QAbstractListModel>
#include <QVector>
#include <qnamespace.h>

#include "dockman/Host.h"

class HostListModel : public QAbstractListModel
{
    public:
        HostListModel(QObject *parent = nullptr);

        int rowCount(const QModelIndex &parent = QModelIndex()) const override;
        QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
        QHash<int, QByteArray> roleNames() const override;

        enum Roles {
            IdRole = Qt::UserRole + 1,
            AddressRole,
            PortRole,
            NameRole,
            ConnectedRole,
            LastErrorRole
        };

    private:
        struct HostListItem
        {
                Host host;

                bool connected = false;
                QString lastError;
        };

        std::vector<HostListItem> m_hosts;
};
