TEMPLATE = app

QT += qml quick network multimedia

CONFIG += c++11

SOURCES += main.cpp \
    chatclient.cpp \
    chatmodel.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    chatclient.h \
    chatmodel.h
