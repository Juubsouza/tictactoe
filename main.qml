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

    Column {
        id : mainColumn

        anchors.centerIn : parent
        spacing : 10

        property int recHeight : parent.height/4
        property int recWidth : parent.width

        function draw(){
            messageDialog.visible = true;
            messageDialog.text = "It's a draw!";
            gameBoard.gameIsActive = false;
        }

        function playerWon(winner){
            messageDialog.visible = true;
            messageDialog.text = winner+ " won!";
            gameBoard.gameIsActive = false;
        }

        Rectangle {
            width : parent.recWidth
            height : parent.recHeight
            color : "transparent"

            Text {
                anchors.centerIn : parent
                text : "Tic-Tac-Toe"
                font.pointSize: 50
                font.family: "Chilanka"
            }

            Dialog {
                id : messageDialog

                property string text : ""

                anchors.centerIn : parent
                standardButtons : Dialog.Retry
                visible : false
                title : "Game Over"
                closePolicy: "NoAutoClose"
                modal : true
                onAccepted : gameBoard.resetBoard()

                Text {
                    text : messageDialog.text
                }
            }
        }

        Rectangle {
            width : parent.recWidth
            height : parent.recHeight * 2
            color : "transparent"

            GameBoard {
                id : gameBoard

                onS_draw: mainColumn.draw()

                onS_playerWon: mainColumn.playerWon(winner)
            }
        }
    }


}
