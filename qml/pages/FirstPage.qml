import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Show Page 2SSSSSS1111")
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }

            MenuItem {
                text: qsTr("Run Python - Random Number & Text")
                onClicked: python.rand();
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column
            //spacing: 10

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("UI Template")
            }
            Label {
                id: mainLabel
                x: Theme.horizontalPageMargin
                text: qsTr("Text will be here")
                color: Theme.secondaryHighlightColor
                //font.pixelSize: Theme.fontSizeLarge
            }

            Label {
                id: secondLabel
                x: Theme.horizontalPageMargin
                text: qsTr("Random will be here")
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
            }

            TextInput {
                id: text1
                text: qsTr('Enter Text')
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeExtraLarge
                //focus: true
                //validator: IntValidator { bottom:0; top: 2000}
            }
        }
    }    
    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('.'));

            setHandler('text', function(newvalue) {
                mainLabel.text = newvalue;
            });

            setHandler('random', function(newvalue) {
                secondLabel.text = newvalue;
            });

            importModule('thingy', function () {});
        }

        function rand() {
            call('thingy.rand', [text1.text]);
        }

        onError: {
            // when an exception is raised, this error handler will be called
            console.log('python error: ' + traceback);
        }

        onReceived: {
            // asychronous messages from Python arrive here
            // in Python, this can be accomplished via pyotherside.send()
            console.log('got message from python: ' + data);
        }
    }
}
