#version 440

layout(location = 0) in vec2 coord;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 resolution;
    float radius;
};

layout(binding = 1) uniform sampler2D source;

float normpdf(in float x, in float sigma) {
    return 0.39894 * exp(-0.5 * x * x / (sigma * sigma)) / sigma;
}

void main() {
    vec2 radiusCalc =  resolution.xy / radius / 0.1;
    vec3 color = vec3(0.0f);

    const int mSize = 9;
    const int kSize = ( mSize - 1 ) / 2;
    float kernel[mSize];

    //create the 1-D kernel
    float sigma = 7.0f;
    float Z = 0.0f;

    for (int i = 0; i <= kSize; ++i) {
        const float norm = normpdf(float(i), sigma);
        kernel[kSize + i] = norm;
        kernel[kSize - i] = norm;
    }

    //get the normalization factor (as the gaussian has been clamped)
    for (int i = 0; i < mSize; ++i) {
        Z += kernel[i];
    }

    //read out the texels
    for (int i = -kSize; i <= kSize; ++i) {
        for (int j = -kSize; j <= kSize; ++j) {
            vec3 offset = texture(source, coord + vec2(float(i),float(j)) / radiusCalc ).rgb;
            color += kernel[kSize + j] * kernel[kSize+i] * offset;
        }
    }

    fragColor = vec4(color/(Z*Z), 1.0);
}
