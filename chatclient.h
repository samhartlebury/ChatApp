#ifndef CHATCLIENT_H
#define CHATCLIENT_H

#include <QObject>
#include <QTcpSocket>

class ChatClient : public QObject
{
    Q_OBJECT
public:
    explicit ChatClient(QObject *parent = 0);

    QStringList messageList;

public slots:
    void login(const QString &userName);
    void say(const QString &message);
    void readyRead();
    void connected();

signals:
    void connectionStateChanged(bool connected);
    void messageReceived(QString message);
    void userReceived(QStringList userList);

private:
    QString m_userName;
    QTcpSocket *socket;
};

#endif // CHATCLIENT_H
