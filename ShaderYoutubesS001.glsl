// Basic 1
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
	
    float f = 20.0;
    float r =abs( sin(uv.x * f));
    float g = r * cos(uv.y * (f * 2.));
    float b = atan(g *sin(iTime));
    vec3 col = vec3(r,g,b);
    // Output to screen
    fragColor = vec4(sqrt(col * .5),1.0);
}

// Basic Shader Code 002

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    
	vec2 uv = (fragCoord - .5 * iResolution.xy) /iResolution.y;
    vec2 pc = vec2(atan(uv.x, uv.y), length(uv + vec2(iTime * .5, iTime * .25)));
    
	  uv = pc;        
    float f = 22.0;
    float r = abs( sin(uv.x * f));
    float g = r * cos(uv.y * (f * 2.));
    float b = sin(g *sin(iTime * 12.));
    
    
    vec3 col = vec3(r,g,b);
    // Output to screen
    fragColor = vec4(sqrt(col * .5),1.0);
}

// Basic Shader Code 003
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    
	vec2 uv = (fragCoord - .5 * iResolution.xy) /iResolution.y;
    vec2 pc = vec2(atan(uv.x, uv.y), length(uv));
	//vec3 noise = texture(iChannel1, uv * 2.).xxx;
    
    vec3 textureBrick = texture(iChannel0, uv * 1.).rgb;
    vec3 textureBrick2 = texture(iChannel0, pc * 1.).rgb;
    
    
    float r,g,b = 0.0;
    
    r = textureBrick.r;
    g = textureBrick.g;
    b = textureBrick.b;
    
    
    
    vec3 col = vec3(abs(sin(textureBrick * 12.)) *  cos(3. *textureBrick2));
    
    
    fragColor = vec4(col,1.0);
}
