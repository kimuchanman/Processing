void setup(){
  size(400,300);
  smooth();
  noStroke();
  fill(200,255,200);
  ellipseMode(CORNER);
}

int d = 20, y = 0,vy = 5,x = 0,vx = 5;
void draw(){
  background(255);
  ellipse(x,y,d,d);
  x += vx;
  y += vy;
  if(y>height-d){
   vy = -5;
  }
  if(y<0){
    vy = 5;
  }
  if(x>width-d){
   vx = -5;
  }
  if(x<0){
    vx = 5;
  }
  
}