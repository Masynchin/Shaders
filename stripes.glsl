// Params
float period = 1.;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1) respect aspect ratio
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y * 2.;

    // Parameter
    float p = fract(iTime / period);
    
    // Lines logis 
    float s = uv.x + uv.y;
    float opasity = step(0.5, mod((s + p), 1.));
    vec3 col = vec3(1., 1., 0.) * opasity;

    // Output to screen
    fragColor = vec4(col,1.0);
}
