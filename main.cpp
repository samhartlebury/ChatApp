#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "chatclient.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<ChatClient>("Sam.Chat", 1, 0, "ChatClient");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
