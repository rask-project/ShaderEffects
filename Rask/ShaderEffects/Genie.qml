import QtQuick

ShaderEffect {
    id: effect

    property variant source
    property bool minimized: false
    property real minimize: 0.0
    property real bend: 0.0
    property real side: 0.0

    enabled: effect.source.status === Image.Ready

    mesh: GridMesh { resolution: Qt.size(10, 10) }
    vertexShader: "qrc:/shaders/genieEffect.vert.qsb"

    ParallelAnimation {
        id: animationMinize
        running: effect.minimized

        SequentialAnimation {
            PauseAnimation { duration: 300 }

            NumberAnimation {
                target: effect
                property: "minimize"
                to: 1
                duration: 700
                easing.type: Easing.InOutSine
            }

            PauseAnimation { duration: 1000 }
        }

        SequentialAnimation {
            NumberAnimation {
                target: effect
                property: "bend"
                to: 1
                duration: 700
                easing.type: Easing.InOutSine
            }

            PauseAnimation { duration: 1300 }
        }
    }

    ParallelAnimation {
        id: animationshow
        running: !effect.minimized

        SequentialAnimation {
            NumberAnimation {
                target: effect
                property: "minimize"
                to: 0
                duration: 700
                easing.type: Easing.InOutSine
            }

            PauseAnimation { duration: 1300 }
        }

        SequentialAnimation {
            NumberAnimation {
                target: effect
                property: "bend"
                to: 0
                duration: 700
                easing.type: Easing.InOutSine
            }

            PauseAnimation { duration: 1000 }
        }
    }
}
