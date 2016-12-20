float scale = 0.5; 
float angle = random(PI); 
float len = 500;  
int n = 0; 

void setup() {
  
  size(600, 600);
  background(255);
  stroke(0);
  textFont(createFont("Tempus Sans ITC", 24));

}

void drawEllipse(float x1, float y1, float len, int n) {
  
  float x2= x1 + len*scale*scale*cos( angle );  
  float y2= y1 - len*scale*scale*sin( angle );  
  float x3= x1 - len*scale*scale*cos( angle );  
  float y3= y1 + len*scale*scale*sin( angle ); 
  ellipse(x1, y1, len, len);  
  
  if (n >= 1) {  
    
    drawEllipse(x2, y2, len*scale, n-1); 
    drawEllipse(x3, y3, len*scale, n-1);

  }
}

void mousePressed(){
   if((mouseButton == LEFT) && (n < 18)) n++;
   else if((mouseButton == RIGHT) && (n > 0)) n--;
}

void draw(){
  
  background(#FFFFFF);
  fill(#050000);
  text("n = " + n, 10, 30);
  fill(#FFFFFF);
  drawEllipse(width/2, height/2, len, n);
  
}