float scale = 0.75; 
float angle = 25; 
float len = 90;  
int n = 0; 

void setup() {
  size(600, 400);
  background(255);
  stroke(0);
  textFont(createFont("Tempus Sans ITC", 24));
  drawTree(width/2, height, len, 0, n);
}

void drawTree(float x1, float y1, float len, float stand, int n) {
  float x2= x1 + len*sin( radians(stand) );  
  float y2= y1 - len*cos( radians(stand) );  
  line(x1, y1, x2, y2);  
  if (n >= 1) {  
    drawTree(x2, y2, len*scale, stand-angle, n-1); 
    drawTree(x2, y2, len*scale, stand+angle, n-1); 
  }
}

void mousePressed(){
   if((mouseButton == LEFT) && (n < 18)) n++;
   else if((mouseButton == RIGHT) && (n > 1)) n--;
}

void draw(){
  background(#FFFFFF);
  fill(#050000);
  line(300,600,300,400);
  text("n = " + n, 10, 30);
  fill(#FFFFFF);
  drawTree(width/2, height, len, 0, n);
}