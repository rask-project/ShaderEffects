#version 440

layout(location = 0) in vec4 qt_Vertex;
layout(location = 1) in vec2 qt_MultiTexCoord0;

layout(location = 0) out vec2 qt_TexCoord0;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float bend;
    float minimize;
    float side;
    float width;
    float height;
};

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    qt_TexCoord0 = qt_MultiTexCoord0;

    vec4 pos = qt_Vertex;
    pos.y = mix(qt_Vertex.y, height, minimize);

    float t = pos.y / height;
    t = (3. - 2. * t) * t * t;

    pos.x = mix(qt_Vertex.x, side * width, t * bend);
    gl_Position = qt_Matrix * pos;
}
