// Simple CRT scanlines shader
// Adjustable parameters
#define SCANLINE_INTENSITY 0.15  // How dark the scanlines are (0.0 - 1.0)
#define SCANLINE_COUNT 240.0     // Number of scanlines (higher = thinner lines)
#define SCANLINE_SHARPNESS 0.8   // How sharp the scanlines are (0.0 - 1.0)

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // Normalized coordinates
    vec2 uv = fragCoord / iResolution.xy;

    // Sample the original texture
    vec3 color = texture(iChannel0, uv).rgb;

    // Calculate scanline effect
    // Using sin function to create repeating dark/light pattern
    float scanline = SCANLINE_INTENSITY *
                    smoothstep(SCANLINE_SHARPNESS,
                              1.0,
                              abs(sin(uv.y * SCANLINE_COUNT * 3.14159)));

    // Apply scanline darkening
    color = color * (1.0 - scanline);

    // Optional: Add subtle screen flickering
    // Uncomment to enable
    // float flicker = 1.0 - 0.01 * sin(iTime * 8.0);
    // color *= flicker;

    fragColor = vec4(color, 1.0);
}
