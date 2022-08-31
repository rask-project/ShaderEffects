cmake_minimum_required(VERSION 3.18)

project(RaskShaderEffects
    VERSION 1.0
    LANGUAGES CXX
)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)
find_package(Qt6 COMPONENTS ShaderTools)

list(GET CMAKE_PREFIX_PATH 0 QML_PATH)
set(QML_PATH ${QML_PATH}/qml)
set(PLUGIN_PATH Rask/ShaderEffects)
string(REPLACE "/" "." PLUGIN_URI ${PLUGIN_PATH})

qt_add_qml_module(${PROJECT_NAME}
    URI ${PLUGIN_URI}
    VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    QML_FILES
        Genie.qml
        ItemBlur.qml
        RoundItem.qml
)

qt_add_shaders(${PROJECT_NAME} "shaders"
    GLSL    "100es,120,150"
    HLSL    "50"
    MSL     "12"
    BATCHABLE
    PRECOMPILE
    OPTIMIZED
    PREFIX
        "/${PLUGIN_PATH}"
    FILES
        shaders/genie.vert
        shaders/roundItem.frag
        shaders/itemBlur.frag
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE Qt6::Quick)
