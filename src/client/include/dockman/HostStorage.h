#pragma once

#include <QString>

#include "dockman/Host.h"

class HostStorage
{
    public:
        explicit HostStorage(const QString &storageFile);

        [[nodiscard]] QVector<Host> loadHosts();
        [[nodiscard]] bool saveHosts(const QVector<Host> &hosts);

        QString storageFile() const;

        QString lastError() const;

    private:
        QString m_storageFile;
        QString m_lastError;
};
