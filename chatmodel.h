#ifndef CHATMODEL_H
#define CHATMODEL_H

#include <QObject>

class ChatModel : public QObject
{
    Q_OBJECT
public:
    explicit ChatModel(QObject *parent = 0);

signals:

public slots:
};

#endif // CHATMODEL_H