import QtQuick 2.0
import QtQuick.Window 2.0


Rectangle {                 //outer window
    id: rectangle1
    signal qmlSignal()
    width: 320//Screen.width
    height: 260 //Screen.height

    Image {
        id: logo
        source: "logo320x142.PNG"
        //sourceSize.height:80
        width:200; height: 200
        verticalAlignment: Image.AlignTop
        horizontalAlignment: Image.AlignHCenter


        //sourceSize.width: Screen.width;
       /* anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom -(Screen.height -sourceSize.height);*/
        //anchors.margins: 80

        //sourceSize.width : Screen.width < 120 ?

        //width: sourceSize.width + 30
        //fillMode: Image.Tile
        fillMode: Image.PreserveAspectFit

    }

    Component {
        id: comCkl
        Item
        {
            id : clock
            height: parent.parent.height
            width: background.width
            property alias city: cityLabel.text
            property int hours
            property int minutes
            property int seconds
            property real shift
            property bool night: false
            property bool internationalTime: true //Unset for local time

            function timeChanged() {
                var date = new Date;
                hours = internationalTime ? date.getUTCHours() + Math.floor(clock_shift) : date.getHours()
                night = ( hours < 7 || hours > 19 )
                minutes = internationalTime ? date.getUTCMinutes() + ((clock_shift % 1) * 60) : date.getMinutes()
                seconds = date.getUTCSeconds();
            }

            Timer {
                interval: 100; running: true; repeat: true;
                onTriggered: clock.timeChanged()
            }

            Item {
                id : dispclk
                anchors.centerIn: parent
                width: parent.width/10; height: parent.height/2


                Image { id: background; source: "clock.png"; visible: clock.night == false }
                Image { source: "clock-night.png"; visible: clock.night == true }

                Image {
                    //  x: 92.5; y: 27
                    x: parent.x + 2.5
                    y: 27
                    source: "hour.png"
                    transform: Rotation {
                        id: hourRotation
                        origin.x: 7.5; origin.y: 73;
                        angle: (clock.hours * 30) + (clock.minutes * 0.5)
                        Behavior on angle {
                            SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                        }
                    }
                }

                Image {
                    //  x: 93.5; y: 17
                    x: parent.x + 3.5
                    y: 17
                    source: "minute.png"
                    transform: Rotation {
                        id: minuteRotation
                        origin.x: 6.5; origin.y: 83;
                        angle: clock.minutes * 6
                        Behavior on angle {
                            SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                        }
                    }
                }

                Image {
                    // x: 97.5; y: 20
                    x: parent.x + 7.5
                    y: 20
                    source: "second.png"
                    transform: Rotation {
                        id: secondRotation
                        origin.x: 2.5; origin.y: 80;
                        angle: clock.seconds * 6
                        Behavior on angle {
                            SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                        }
                    }
                }

                Image {
                    anchors.centerIn: background; source: "center.png"
                }

                Text {
                    id: cityLabel
                    x: parent.x - cityLabel.width/3
                    anchors.top: background.bottom
                    color: "white"
                    font.family: "Helvetica"
                    font.bold: true; font.pixelSize: 16
                    style: Text.Raised; styleColor: "black"
                    text: cityName

                }
            }

        }

    }

        ListView {
            id: clockview
            flickableDirection: Flickable.AutoFlickDirection
            delegate: comCkl
            anchors.fill: parent
            anchors.bottom: parent.Center
            orientation: ListView.Horizontal
            cacheBuffer: 2000
            snapMode: ListView.SnapOneItem
            highlightRangeMode: ListView.ApplyRange

            model: ListModel {
                //ListElement { cityName: "New York"; clock_shift: -4 }
                ListElement { cityName: "India"; clock_shift: 5.5 }
                //ListElement { cityName: "Oslo"; clock_shift: 1 }
                //ListElement { cityName: "Mumbai"; clock_shift: 5.5 }
            }



        }
        Image {
            width: parent.width / 10
            height: parent.height / 10
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: 10
            source: "arrow.png"
            rotation: 180
            opacity: clockview.atXBeginning ? 0 : 0.5
            Behavior on opacity { NumberAnimation { duration: 500 } }
        }

        Image {
            width: parent.width / 10
            height: parent.height / 10
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 10
            source: "arrow.png"
            opacity: clockview.atXEnd ? 0 : 0.5
            Behavior on opacity { NumberAnimation { duration: 500 } }
        }




    //  Keys.onLeftPressed: console.log("2move left")
    focus: true


    Connections {
        target: receive
        onSendToQml: {
            console.log("Received in QML from C++: " + count)
            Qt.quit();
        }
    }

    Keys.onPressed: {
        console.log(event.key);
        // rectangle1.qmlSignal();
        receive.receiveFromQml(42);
        /*
        if (event.key === Qt.Key_Left) {
            console.log("1move left");
            event.accepted = true;
        }
        */
    }
}
/*
import QtQuick 2.0
import QtQuick.Window 2.0


Rectangle {                 //outer window
    id: rectangle1
    signal qmlSignal()
    width: 740//Screen.width
    height: 500//Screen.height

    Image {
        id: logo

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 7
        sourceSize.width : Screen.width < 120 ?
        sourceSize.height: 20
        width: sourceSize.width + 30
        fillMode: Image.PreserveAspectFit
        source: "logo.png"
    }

    Rectangle {
        anchors.right: parent.right
        id: root
        width: parent.width - logo.width; height: parent.height ;
        color: "#646464"
        property real clock_shift

        Component {
            id: comCkl
            Item
            {
                id : clock
                height: parent.parent.height
                width: background.width
                property alias city: cityLabel.text
                property int hours
                property int minutes
                property int seconds
                property real shift
                property bool night: false
                property bool internationalTime: true //Unset for local time

                function timeChanged() {
                    var date = new Date;
                    hours = internationalTime ? date.getUTCHours() + Math.floor(clock_shift) : date.getHours()
                    night = ( hours < 7 || hours > 19 )
                    minutes = internationalTime ? date.getUTCMinutes() + ((clock_shift % 1) * 60) : date.getMinutes()
                    seconds = date.getUTCSeconds();

                }

                Timer {
                    interval: 100; running: true; repeat: true;
                    onTriggered: clock.timeChanged()
                }

                Item {
                    id : dispclk
                    anchors.centerIn: parent
                    width: parent.width/10; height: parent.height/2


                    Image { id: background; source: "clock.png"; visible: clock.night == false }
                    Image { source: "clock-night.png"; visible: clock.night == true }

                    Image {
                        //  x: 92.5; y: 27
                        x: parent.x + 2.5
                        y: 27
                        source: "hour.png"
                        transform: Rotation {
                            id: hourRotation
                            origin.x: 7.5; origin.y: 73;
                            angle: (clock.hours * 30) + (clock.minutes * 0.5)
                            Behavior on angle {
                                SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                            }
                        }
                    }

                    Image {
                        //  x: 93.5; y: 17
                        x: parent.x + 3.5
                        y: 17
                        source: "minute.png"
                        transform: Rotation {
                            id: minuteRotation
                            origin.x: 6.5; origin.y: 83;
                            angle: clock.minutes * 6
                            Behavior on angle {
                                SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                            }
                        }
                    }

                    Image {
                        // x: 97.5; y: 20
                        x: parent.x + 7.5
                        y: 20
                        source: "second.png"
                        transform: Rotation {
                            id: secondRotation
                            origin.x: 2.5; origin.y: 80;
                            angle: clock.seconds * 6
                            Behavior on angle {
                                SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                            }
                        }
                    }

                    Image {
                        anchors.centerIn: background; source: "center.png"
                    }

                    Text {
                        id: cityLabel
                        x: parent.x - cityLabel.width/3
                        anchors.top: background.bottom
                        color: "white"
                        font.family: "Helvetica"
                        font.bold: true; font.pixelSize: 16
                        style: Text.Raised; styleColor: "black"
                        text: cityName

                    }
                }

            }

        }

        ListView {
            id: clockview
            flickableDirection: Flickable.AutoFlickDirection
            delegate: comCkl
            anchors.fill: parent
            anchors.bottom: parent.Center
            orientation: ListView.Horizontal
            cacheBuffer: 2000
            snapMode: ListView.SnapOneItem
            highlightRangeMode: ListView.ApplyRange

            model: ListModel {
                ListElement { cityName: "New York"; clock_shift: -4 }
                ListElement { cityName: "Pune"; clock_shift: 5.5 }
                ListElement { cityName: "Oslo"; clock_shift: 1 }
                ListElement { cityName: "Mumbai"; clock_shift: 5.5 }
            }



        }
        Image {
            width: parent.width / 10
            height: parent.height / 10
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: 10
            source: "arrow.png"
            rotation: 180
            opacity: clockview.atXBeginning ? 0 : 0.5
            Behavior on opacity { NumberAnimation { duration: 500 } }
        }

        Image {
            width: parent.width / 10
            height: parent.height / 10
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 10
            source: "arrow.png"
            opacity: clockview.atXEnd ? 0 : 0.5
            Behavior on opacity { NumberAnimation { duration: 500 } }
        }


    }

    //  Keys.onLeftPressed: console.log("2move left")
    focus: true


    Connections {
        target: receive
        onSendToQml: {
            console.log("Received in QML from C++: " + count)
            Qt.quit();
        }
    }

    Keys.onPressed: {
        console.log(event.key);
        // rectangle1.qmlSignal();
        receive.receiveFromQml(42);
        /*
        if (event.key === Qt.Key_Left) {
            console.log("1move left");
            event.accepted = true;
        }
      /
    }
}

  */
