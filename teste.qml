import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
//import QtQuick.Dialogs 1.2
ApplicationWindow {
    id : appWindow
    visible : true
    width : 600
    height : 600
    color : "#3388FF"

    Rectangle {
        anchors.centerIn : parent
        width : parent.height * .8
        height : parent.height * .8
        color : "green"
    }

    Image {
        width : 50
        height : 50
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        smooth: true
        antialiasing: true
        mipmap: true
        source : 'qrc:/sanji.jpeg'
    }
}
