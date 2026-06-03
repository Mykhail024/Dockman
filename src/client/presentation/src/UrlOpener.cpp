#include <QDebug>

#include "dockman/UrlOpener.h"

bool UrlOpener::open(const QString &url)
{
    qDebug() << url;

    return QDesktopServices::openUrl(QUrl(url));
}

UrlOpener *UrlOpener::create(QQmlEngine *engine, QJSEngine *)
{
    static UrlOpener i;
    engine->setObjectOwnership(&i, QQmlEngine::CppOwnership);
    return &i;
}
