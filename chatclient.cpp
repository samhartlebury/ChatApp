#include "chatclient.h"

ChatClient::ChatClient(QObject *parent) : QObject(parent)
{
    socket = new QTcpSocket(this);
    connect(socket, SIGNAL(readyRead()), this, SLOT(readyRead()));
    connect(socket, SIGNAL(connected()), this, SLOT(connected()));
}

void ChatClient::login(const QString &userName)
{
   m_userName = userName;
   socket->connectToHost("192.168.1.5", 9999);
}

void ChatClient::say(const QString &message)
{
   socket->write(QString(message + "\n").toUtf8());
}

void ChatClient::readyRead()
{
    // We'll loop over every (complete) line of text that the server has sent us:
    while(socket->canReadLine()) {
        // Here's the line the of text the server sent us (we use UTF-8 so
        // that non-English speakers can chat in their native language)
        QString line = QString::fromUtf8(socket->readLine()).trimmed();

        // These two regular expressions describe the kinds of messages
        // the server can send us:

        //  Normal messges look like this: "username:The message"
        QRegExp messageRegex("^([^:]+):(.*)$");

        // Any message that starts with "/users:" is the server sending us a
        // list of users so we can show that list in our GUI:
        QRegExp usersRegex("^/users:(.*)$");

        // Is this a users message:
        if(usersRegex.indexIn(line) != -1) {
            // If so, udpate our users list on the right:
            QStringList users = usersRegex.cap(1).split(",");

           // foreach(QString user, users)
                //new QListWidgetItem(QPixmap(":/user.png"), user, userListWidget);
        } else if(messageRegex.indexIn(line) != -1) { // Is this a normal chat message:

            // If so, append this message to our chat box:
            QString user = messageRegex.cap(1);
            QString message = messageRegex.cap(2);

            messageList.append("<b>" + user + "</b>: " + message);
            emit messageReceived("<b>" + user + "</b>: " + message);
        }
    }
}

void ChatClient::connected()
{
    emit connectionStateChanged(true);
    socket->write(QString("/me:" + m_userName + "\n").toUtf8());
}
