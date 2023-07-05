import QtQuick 2.15

Rectangle {
    id: gameBoard

    anchors.centerIn: parent
    width: 300
    height: 300

    property var board: [[0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]]

    property bool xTurn: true
    property bool gameIsActive : true;
    property string gameWinner : "";

    signal s_resetGame();
    signal s_playerWon(var winner);
    signal s_draw();

    function resetBoard() {
        board = [[0, 0, 0],
                 [0, 0, 0],
                 [0, 0, 0]];
        xTurn = true;
        s_resetGame();
        gameIsActive = true;
    }

    function checkWin() {
        // Check rows
        for (var i = 0; i < 3; ++i) {
            if (board[i][0] === board[i][1] && board[i][1] === board[i][2] && board[i][0] !== 0)
                return true;
        }
        // Check columns
        for (var j = 0; j < 3; ++j) {
            if (board[0][j] === board[1][j] && board[1][j] === board[2][j] && board[0][j] !== 0)
                return true;
        }
        // Check diagonals
        if ((board[0][0] === board[1][1] && board[1][1] === board[2][2] && board[0][0] !== 0) ||
                (board[0][2] === board[1][1] && board[1][1] === board[2][0] && board[0][2] !== 0))
            return true;

        return false;
    }

    function makeMove(row, col) {
        if (board[row][col] === 0) {
            board[row][col] = xTurn ? 1 : 2;
            xTurn = !xTurn;
        }

        if (checkWin()) {
            var winner = xTurn ? "Sanji" : "Zoro";
            s_playerWon(winner);
        } else {
            var draw = true;
            for (var i = 0; i < 3; ++i) {
                for (var j = 0; j < 3; ++j) {
                    if (board[i][j] === 0) {
                        draw = false;
                        break;
                    }
                }
            }
            if (draw) {
                s_draw();
            }
        }
    }

    Grid {
        columns: 3
        rows: 3
        spacing: 0

        Repeater {
            model : 9
            delegate: Rectangle {
                id : tictactoeCell
                width: 100
                height: 100
                border.color: "black"
                enabled : gameBoard.gameIsActive

                property int rowIndex : indexToRow(index)
                property int columnIndex : indexToColumn(index)
                property string cellText : ""

                function indexToRow(index){
                    if (index === 0 || index === 1 || index === 2)
                        return 0;
                    if (index === 3 || index === 4 || index === 5)
                        return 1;
                    if (index === 6 || index === 7 || index === 8)
                        return 2;
                }

                function indexToColumn(index){
                    if (index === 0 || index === 3 || index === 6)
                        return 0;
                    if (index === 1 || index === 4 || index === 7)
                        return 1;
                    if (index === 2 || index === 5 || index === 8)
                        return 2;
                }

                MouseArea {
                    anchors.fill: parent

                    Connections {
                        target : gameBoard

                        onS_resetGame : {
                            tictactoeCell.enabled = true
                            tictactoeCell.cellText = ""
                        }
                    }

                    onClicked: {
                        if (!gameIsActive)
                            return

                        tictactoeCell.enabled = false
                        gameBoard.makeMove(tictactoeCell.rowIndex, tictactoeCell.columnIndex)
                        tictactoeCell.cellText = (gameBoard.xTurn ? "X" : "O")
                    }

                    Image {
                        width : parent.width
                        height : parent.height * .9
                        anchors.centerIn: parent
                        visible : tictactoeCell.cellText !== ""
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                        antialiasing: true
                        mipmap: true
                        source : (tictactoeCell.cellText == "O" ? 'qrc:/zoro.jpeg' : 'qrc:/sanji.jpeg')
                    }
                }
            }
        }
    }

    Component.onCompleted: resetBoard()
}
