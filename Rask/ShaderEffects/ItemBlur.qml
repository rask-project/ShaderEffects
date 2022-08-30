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
        property variant source: shaderSource
        property variant resolution: Qt.size(control.width, control.height)
        property real radius: control.radius

        width: control.width
        height: control.height

        fragmentShader: "qrc:/Rask/ShaderEffects/shaders/itemBlur.frag.qsb"
    }

    function lerp(value: float, min: float, max: float): float {
        return (1.0 - value) * min + max * value;
    }

    function inverseLerp(value: float, min: float, max: float): float {
        return (value - min) / (max - min);
    }

    function remap(value: float, inMin: float, inMax: float, outMin: float, outMax: float): float {
        const t = inverseLerp(value, inMin, inMax);
        return lerp(t, outMin, outMax);
    }
}
