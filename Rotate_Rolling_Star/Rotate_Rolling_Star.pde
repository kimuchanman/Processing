float a;
void setup(){
  a = -3;
  size(500, 100);
  background(255);
  smooth();
  noStroke();
  ellipseMode(CORNER);
  fill(200,255,200);
  frameRate(30);
}

void star(){
  beginShape();
  for(int i = 0; i < 5; i++){
    float theta = 2 * TWO_PI / 5 * i - HALF_PI;
    vertex(.5 * cos(theta), .5 * sin(theta));
  }
  endShape();
}

void draw(){
  background(255);
  pushMatrix();
  translate(20*a, height / 2 );
  scale(100, 100);
  rotate(a);
  star(); 
  a += 0.1;
  popMatrix();
  if(a > 27){
    a = -3;
  }
}