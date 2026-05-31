#include <QStringLiteral>

#include "dockman/Host.h"
#include "dockman/HostListModel.h"

HostListModel::HostListModel(QObject *parent) : QAbstractListModel(parent)
{
#ifndef NDEBUG
    m_hosts = {
        { {.id = "uuid1", .name = "Production Server", .address = "127.0.0.1", .port = 25565},
         true,         "" },
        {{.id = "uuid2", .name = "Development Server", .address = "127.0.0.1", .port = 25566},
         false, "Time out"},
        {    {.id = "uuid3", .name = "Staging Server", .address = "127.0.0.1", .port = 25567},
         true,         "" }
    };
#endif
}

int HostListModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_hosts.size();
}

QVariant HostListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_hosts.size())
        return {};

    const auto &obj = m_hosts[index.row()];

    switch (role) {
    case IdRole:
        return obj.host.id;
    case NameRole:
        return obj.host.name;
    case AddressRole:
        return obj.host.address;
    case PortRole:
        return obj.host.port;
    case ConnectedRole:
        return obj.connected;
    case LastErrorRole:
        return obj.lastError;
    }

    return {};
}

QHash<int, QByteArray> HostListModel::roleNames() const
{
    return {
        {       IdRole,        "id"},
        {     NameRole,      "name"},
        {  AddressRole,   "address"},
        {     PortRole,      "port"},
        {ConnectedRole, "connected"},
        {LastErrorRole, "lastError"}
    };
}
