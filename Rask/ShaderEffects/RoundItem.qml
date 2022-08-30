import QtQuick
import QtQuick.Controls

Item {
    id: control

    property variant source
    property real radius: 0.0

    ShaderEffectSource {
        id: shaderSource

        width: control.width
        height: control.height

        visible: false
        sourceItem: control.source
        hideSource: control.visible
        smooth: true
    }

    ShaderEffect {
        id: effect

        property variant source: shaderSource
        property variant mask: maskRectangle

        width: control.width
        height: control.height

        fragmentShader: "qrc:/Rask/ShaderEffects/shaders/roundItem.frag.qsb"

        Rectangle {
            id: maskRectangle

            visible: false
            width: parent.width
            height: parent.height

            layer.enabled: true
            radius: control.radius
        }
    }
}
