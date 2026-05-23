#pragma once

#include <QDesktopServices>
#include <QObject>
#include <QQmlEngine>
#include <QUrl>

class UrlOpener : public QObject
{
        Q_OBJECT
        QML_ELEMENT
        QML_SINGLETON
    public:
        using QObject::QObject;

        static UrlOpener *create(QQmlEngine *engine, QJSEngine *);

        Q_INVOKABLE static bool open(const QString &url);

    private:
        UrlOpener() {}
};
