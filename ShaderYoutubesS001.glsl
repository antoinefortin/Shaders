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

// Shader number 4

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    
	vec2 uv = (fragCoord - .5 * iResolution.xy) /iResolution.y;
	
    
    vec3 a = vec3(0., 1.0, 0.0);
    vec3 b = vec3(1., 0., 0.0);
    vec3 c = cross(b,a);
    
    float dotProduct = dot(a,b);
    
    vec3 col = vec3(uv.y * uv.x);
   
    
   	col = vec3(dotProduct);
    /*
		col.r = dotProduct
		
	*/
    
    fragColor = vec4(col,1.0);
}

// Shader number 5
float sphere(vec3 pos, float radius)
{
	return length(pos) - radius;
}

float HowCloseAmIFromTheNearestObjectInScene(
	vec3 pos
)
{
    
    
	return sphere(pos, 1.0);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    
	vec2 uv = (fragCoord - .5 * iResolution.xy) /iResolution.y;

   	vec3 ro =  vec3(0.0, 0.0, -4.0);
     
    
    vec3 rd = normalize(vec3(uv.x, uv.y, 1.0));
   	vec3 col = vec3(rd);
  	
    vec3 currentRayPos = vec3(0.0,0.0,0.0f);
   	
    // Here we are walking along the ray
    for(int i = 0; i < 128; i++)
    {
    	float _distance = HowCloseAmIFromTheNearestObjectInScene(ro);
      	if(_distance < 0.01)
        {
            col = vec3(1.0);
        	break;    
        }
        ro += rd * _distance; 
      
    }
    fragColor = vec4(col,1.0);
}


float sphere(vec3 pos, float radius)
{
	return length(pos) - radius;
}
float plane(vec3 pos)
{
	return pos.y;
}



float HowCloseAmIFromTheNearestObjectInScene(
	vec3 pos
)
{	

    /*


	pos.x = mod(pos.x+ 2., 4.) -2.;
    pos.z = mod(pos.z+ 2., 4.) -2.;
*/
    
    vec3 spherePositionOffset = vec3(1.0 + cos(iTime), -1.0 + sin(iTime), 0.0);
   
    float radius = .5;
    float plane = plane(pos);
    float sphereDistance = sphere(pos + spherePositionOffset, radius); 
	
            
	return min(plane, sphereDistance);
}


// Basic ray marching
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    
	vec2 uv = (fragCoord - .5 * iResolution.xy) /iResolution.y;

   	vec3 ro =  vec3(0.0, 1.25, -5.0 /*+ sin(iTime)*/);
     
    
    vec3 rd = normalize(vec3(uv.x, uv.y, 1.0));
   	vec3 col = vec3(rd);
  	   	
    // Here we are walking along the ray
    for(int i = 0; i < 128; i++)
    {
    	float _distance = HowCloseAmIFromTheNearestObjectInScene(ro);
      	if(_distance < 0.01)
        {
            
            vec3 lp = vec3(1., 3., 5.);
          	vec3 pShade =  normalize(ro - _distance);
            
            vec3 shaded = vec3(dot(lp, pShade));
            col = vec3(shaded + .5);
        	break;    
        }
        ro += rd * _distance; 
      
    }
    fragColor = vec4(col,1.0);
}
