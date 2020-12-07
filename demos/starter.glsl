//vec2 modit(vec2 x, vec2 y) { return x - y * floor(x / y); }

float modit(float x, float y) { return x - y * floor(x / y); }

void main() {
  

  vec3 cam = getCam(uv);
  float face = getFace(uv);
  vec3 color = cam;
 
  
  // custom code here
  vec3 colorA = vec3(1.00,0.95,0.65);
  vec3 colorB = vec3(0.65,0.91,1.0);
  
  vec2 distFromCenter = faceCenter-uv;
    distFromCenter.x *= targetAspect;
    float dist = length(distFromCenter);


    float alpha = smoothstep(0.305,0.3,dist);
    vec3 gradient = mix(colorA, colorB, uv.y+uv.x*sin(time));

  vec2 pos = vec2(uv.x, uv.y * resolution.y / resolution.x) * 1.3;
  vec3 ro = vec3(pos.x, pos.y, 1.);
  vec3 rd = normalize(ro - vec3(0.));
  vec3 faceVec = vec3(faceCenter.x, faceCenter.y, 1);
  float hit = 0.0;
  int hitStep = 0;
  
  for (int i = 0; i<9;i++){
    vec3 pos2 = ro + rd * float(i) * .04;
    float fV = length(faceVec - pos2);
    
    hit = fV * .3 + fbn((pos2 * 4. + vec3(0., 0., time * .3)), 3) * .1 * fV*fV*20.;

    if (i == 17) {
      if (getFace(pos2.xy * .7) > .5) {
        hitStep = i;
        color = getCam(pos2.xy * .7);
        break;
      }
    }
    if (hit > .34) {
      color = hsl2rgb(0.65, 0.1,0.15);
      hitStep = i;

      break;
    }
  }

  if (hitStep == 0) {
    color = getPrevious(uv) * .9;
  }
 
    //float n = noise(vec3(distFromCenter,time*1.2));

    //gl_FragColor = vec4(gradient,alpha);
  
  if (alpha > 0.25 && color[2] < 0.5+0.7*sin(time)) {
    gl_FragColor = vec4(gradient,alpha);
  } else {
    gl_FragColor = vec4(color,1);
  }
  

}

