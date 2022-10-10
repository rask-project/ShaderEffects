# ShaderEffects
Qt 6 Quick Shader Effects

QML plugin with some Shaders effects like:

* ItemBlur - Blur effect
* RoundItem - Image border rounding effect
* Genie - Magic lamp genie effect

## How to install

* Download file [FetchDependencies.cmake](https://gist.github.com/marssola/994ee9efb787024dcc7b323541a2c95c) and add to cmake folder inside your project root.
* Add to **CMakeLists.txt**

```cmake
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include(FetchDependencies)

...

### After add_executable or qt_add_executable
FetchDependencies(RaskShaderEffects
     REPOSITORY https://github.com/rask-project/ShaderEffects.git
     BRANCH 1.0.0
     TARGET ${PROJECT_NAME}
)
```

## How to use

* RoundItem

```qml
...
import Rask.ShaderEffects
...

RoundItem {
    id: roundItem

    width: parent.width
    height: width

    radius: 20
    source: Image {
        property int clipWidth: sliderImageSize.value.toFixed(2)
        property int clipHeight: sliderImageSize.value.toFixed(2)
        property int clipX: clipWidth - roundItem.width
        property int clipY: clipHeight - roundItem.height

        source: "[SOME IMAGE]"
        fillMode: Image.PreserveAspectCrop

        sourceSize.width: clipWidth
        sourceSize.height: clipHeight
        sourceClipRect: Qt.rect(clipX, clipY, roundItem.width, roundItem.height)
    }
}
```

![RoundImage](/doc/RoundImage.jpg)

* ItemBlur

```qml
...
import Rask.ShaderEffects
...

ItemBlur {
    id: itemBlur

    width: parent.width
    height: parent.height

    radius: 50
    source: Image {
        width: parent.width
        height: parent.height

        source: "[SOME IMAGE]"
        fillMode: Image.PreserveAspectCrop
    }
}
```

![ItemBlur](/doc/ItemBlur.jpg)

* Genie

```qml
...
import Rask.ShaderEffects
...

Genie {
    id: genie

    width: parent.width
    height: width
    source: Image { source: "[SOME IMAGE]" }
    side: 0.5
}

Button {
    anchors.horizontalCenter: parent.horizontalCenter

    text: !genie.minimized ? qsTr("Minimize") : qsTr("Show")
    onClicked: genie.minimized = !genie.minimized
}
```

![Genie](/doc/Genie.jpg)
