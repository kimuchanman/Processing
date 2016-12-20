float a,b;
void setup(){
  a = 0;
  b = 0;
  size(400,100);
  smooth();
  noStroke();
  fill(200,255,200);
  ellipseMode(CORNER);
}

int d = 100, y = 0,vy = 5,x = 0,vx = 1,ax = 1;
void draw(){
  background(255);
  x += vx;
  a += ax;
  
  //packman_mouth
  if(a > 30){
   ax = -1;
  }
  if(a < 0){
    ax = 1;
  }
  
  //packman_move
  if(x>width-d){
   vx = -1;  
  }
  if(x<0){
    vx = 1;
  }
  
  //packman_reflect
  if(vx>0){
  arc(x,y,d,d,radians(30 - a),radians(330 + a)); 
  }
  if(vx<0){
  arc(x,y,d,d,radians(0),radians(150 + a));
  arc(x,y,d,d,radians(210 - a),radians(360));
  }
  
}