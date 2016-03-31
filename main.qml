import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import Sam.Chat 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Chachums"

    ChatClient {
        id: client

        onConnectionStateChanged: {
            if (connected) {
                loginPage.visible = false;
                chatPage.visible = true;
            } else {
                console.log("connection error...");
            }
        }

        onMessageReceived: {
            messageModel.append({"message": message});
            messageList.incrementCurrentIndex();
        }

        onUserReceived: {
            userModel.clear();
            for (var i in userList)
                userModel.append({"user": userList[i]});
        }
    }

    ListModel {
        id: userModel

        ListElement {
            user: ""
        }
    }

    ListModel {
        id: messageModel

        ListElement {
            message: ""
        }
    }

    Rectangle {
        id: chatPage
        visible: false
        anchors.fill: parent

        RowLayout {
            width: parent.width
            anchors.top: parent.top

            Rectangle {
                id: messageRect
                width: 10
                height: messageText.height + (border.width * 2)
                border.color: "lightblue"
                border.width: 2
                radius: 10
                Layout.fillWidth: true

                TextEdit {
                    id: messageText
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (messageText.focus)
                            messageText.focus = false;
                        else
                            messageText.focus = true;
                    }
                }
            }

            Button {
                id: sendMessage
                text: "Send"
                onClicked: {
                    client.say(messageText.text);
                    messageText.text = "";
                }
            }
        }

        ListView {
            id: messageList

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: sendMessage.height
            width: parent.width / 2
            height: messageModel.count * messageText.height
            model: messageModel
            verticalLayoutDirection: ListView.BottomToTop
            clip: true
            delegate: Label {
                text: message
            }
        }

        ListView {
            id: users

            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: sendMessage.height
            width: parent.width / 2
            height: userModel.count * messageText.height
            model: userModel
            verticalLayoutDirection: ListView.BottomToTop
            layoutDirection: Qt.RightToLeft
            clip: true
            delegate: Label {
                text: user
            }
        }

    }

    Rectangle {
        id: loginPage
        anchors.fill: parent

        ColumnLayout {
            anchors.centerIn: parent

            Label {
                text: "Username"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                width: userName.width > 200 - (border.width * 10) ? userName.width + (border.width * 10) : 200
                anchors.horizontalCenter: parent.horizontalCenter
                height: userName.height + (border.width * 2)
                border.width: 2
                border.color: "lightblue"
                radius: 10

                TextEdit {
                    id: userName
                    anchors.centerIn: parent
                    focus: loginPage.visible
                }
            }

            Button {
                text: "Login"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: client.login(userName.text);
            }
        }
    }
}
