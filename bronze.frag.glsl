# version 120
/*
 * Earl Martin Momongan
 * techwiz@csu.fullerton.edu
 * 
 * Bronze Fragment Shader
 *
 */

// These are passed from the vertex shader to here, the fragment shader
// In later versions of GLSL these are 'in' variables.
varying vec3 myNormal;
varying vec4 myVertex;

// These are passed in from the CPU program, camera_control_*.cpp
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 normalMatrix;
uniform vec4 light0_position;
uniform vec4 light0_color;
uniform vec4 light1_position;
uniform vec4 light1_color;

vec4 ComputeLight (const in vec3 direction, const in vec4 lightcolor, const in vec3 normal, const in vec3 halfvec, const in vec4 mydiffuse, const in vec4 myspecular, const in float myshininess, const in vec3 eyeVec){

  float nDotL = dot(normal, direction);
  vec4 lambert = mydiffuse * lightcolor * max (nDotL, 0.0);

  float nDotH = dot(normal, halfvec);
  vec4 phong = myspecular * lightcolor * pow (max(nDotH, 0.0), myshininess);
  
  // R = 2N(N*L) - L
  // A . B = |A| * |B| * cos0
  vec3 wRGB = vec3(1, 1, 1);
  vec3 pRGB = vec3(1, 2, 20);
  vec3 refVal = reflect(normal, direction);
  float angle = acos(dot(eyeVec, refVal)/(length(eyeVec)*length(refVal)));

  vec3 temp = vec3((cos(angle) + 1)/2);
  vec3 cRGB = wRGB * pow(temp, pRGB);
  vec4 color = vec4(cRGB, 1.0);
  vec4 retval = lambert + phong + color;
  return retval;
}       

void main (void){
  vec4 ambient = vec4(0.2, 0.2, 0.2, 1.0);
  vec4 diffuse = vec4(0.5, 0.5, 0.5, 1.0);
  vec4 specular = vec4(1.0, 1.0, 1.0, 1.0);
  float shininess = 100;
  
  // They eye is always at (0,0,0) looking down -z axis 
  // Also compute current fragment position and direction to eye 

  const vec3 eyepos = vec3(0,0,0);
  vec4 _mypos = modelViewMatrix * myVertex;
  vec3 mypos = _mypos.xyz / _mypos.w;
  vec3 eyedirn = normalize(eyepos - mypos);

  // Compute normal, needed for shading. 
  vec4 _normal = normalMatrix * vec4(myNormal, 0.0);
  vec3 normal = normalize(_normal.xyz);

  // Light 0, point
  vec3 position0 = light0_position.xyz / light0_position.w;
  vec3 direction0 = normalize (position0 - mypos);
  vec3 half0 = normalize(direction0 + eyedirn); 
  vec4 color0 = ComputeLight(direction0, light0_color, normal, half0, diffuse, specular, shininess, eyedirn) ;

  // Light 1, point 
  vec3 position1 = light1_position.xyz / light1_position.w;
  vec3 direction1 = normalize(position1 - mypos);
  vec3 half1 = normalize(direction1 + eyedirn); 
  vec4 color1 = ComputeLight(direction1, light1_color, normal, half1, diffuse, specular, shininess, eyedirn) ;
    
  gl_FragColor = ambient + color0 + color1;
}
