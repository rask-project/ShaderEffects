#version 440
layout(location = 0) in vec2 coord;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
};

layout(binding = 1) uniform sampler2D source;
layout(binding = 2) uniform sampler2D mask;

void main() {
    vec4 texSource = texture(source, coord);
    vec4 texMask = texture(mask, coord);

    fragColor = texMask * texSource * qt_Opacity;
}
