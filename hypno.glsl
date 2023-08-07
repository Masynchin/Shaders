// Consts
float pi = 3.1415926535897932384626433832795;

// Params
float radius = 12.0;
float smoothK = 12.0;
float period = 2.0;

// [-1, 1] -> [1-n, 1+n]
float scale( float x, float n ) {
    return x * n + 1.0;
}

// Z+ -> [a, b]
float intRange( float z, float a, float b ) {
    return mod(z, (b - a + 1.0)) + a;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Computed
    float spikes = intRange(floor(iTime / period), 3., 10.);
    float ampl = 1.0 / (spikes + 5.0);
    float height = sin(iTime * pi / period) * ampl;

    // Normalized pixel coordinates (from 0 to 1)
    // respecting aspect ratio
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
    
    // Stretch the space to show waves
    float angle = atan(uv.y, uv.x) + (iTime / 8.0); // [-pi, pi]
    uv *= scale(sin(angle * spikes), height);

    // Render circles
    float distanceToCircle = abs(sin(length(uv) * radius - iTime * 2.0) / radius);
    float res = exp(-distanceToCircle * smoothK);

    vec3 color = vec3(res, res, res);
    fragColor = vec4(color, 1.0);
}
