#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonParseError>
#include <QVector>

#include "config.h"
#include "dockman/HostStorage.h"
#include "dockman/logger.h"

HostStorage::HostStorage(const QString &storageFile) : m_storageFile(storageFile) {}

QVector<Host> HostStorage::loadHosts()
{
    m_lastError.clear();

    QFile file(m_storageFile);
    if (!file.exists()) {
        return {};
    }

    if (!file.open(QIODevice::ReadOnly)) {
        m_lastError = file.errorString();
        return {};
    }

    const QByteArray data = file.readAll();

    QJsonParseError pError;
    const QJsonDocument doc = QJsonDocument::fromJson(data, &pError);
    if (pError.error != QJsonParseError::NoError) {
        m_lastError = pError.errorString();
        return {};
    }

    if (!doc.isObject()) {
        m_lastError = "Root JSON value is not an object";
        return {};
    }

    const QJsonObject root = doc.object();
    const QJsonArray hostsArray = root.value("hosts").toArray();

    QVector<Host> hosts;
    hosts.reserve(hostsArray.size());

    for (const auto &val : hostsArray) {
        if (!val.isObject()) {
            continue;
        }

        const QJsonObject obj = val.toObject();

        Host host;
        host.id = obj.value("id").toString();
        host.name = obj.value("name").toString();
        host.address = obj.value("address").toString();
        host.port = static_cast<quint16>(obj.value("port").toInt());

        hosts.append(host);
    }

    Log_Info("Loaded hosts from " + m_storageFile.toStdString() + " (Config version - " +
             root.value("version").toString().toStdString() + ")");

    return hosts;
}
bool HostStorage::saveHosts(const QVector<Host> &hosts)
{
    m_lastError.clear();

    QJsonArray hostsArray;
    for (const auto &host : hosts) {
        QJsonObject obj;
        obj["id"] = host.id;
        obj["name"] = host.name;
        obj["address"] = host.address;
        obj["port"] = host.port;

        hostsArray.push_back(obj);
    }

    QJsonObject root;
    root["name"] = "Dockman";
    root["version"] = DOCKMAN_VERSION;
    root["hosts"] = hostsArray;

    QJsonDocument doc(root);

    QFile file(m_storageFile);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Truncate)) {
        m_lastError = file.errorString();
        return false;
    }

    const qint64 written = file.write(doc.toJson(QJsonDocument::Indented));
    if (written == -1) {
        m_lastError = file.errorString();
        return false;
    }

    Log_Info("Hosts were successfully saved to " + m_storageFile.toStdString());

    return true;
}

QString HostStorage::storageFile() const { return m_storageFile; }

QString HostStorage::lastError() const { return m_lastError; }
