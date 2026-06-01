#include <QStringLiteral>

#include "dockman/Host.h"
#include "dockman/HostListModel.h"

HostListModel::HostListModel(QObject *parent) : QAbstractListModel(parent) {}

void HostListModel::setHosts(const QVector<Host> &hosts)
{
    emit beginResetModel();

    m_hosts.clear();

    for (const auto &host : hosts) {
        m_hosts.push_back({
            host, {false, ""}
        });
    }

    emit endResetModel();
}

QVector<Host> HostListModel::hosts() const
{
    QVector<Host> hosts;
    hosts.reserve(m_hosts.size());
    for (const auto &host : m_hosts) {
        hosts.push_back(host.host);
    }
    return hosts;
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
        return obj.state.connected;
    case LastErrorRole:
        return obj.state.lastError;
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
