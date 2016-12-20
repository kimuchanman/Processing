int n = 1;
float a = 100;
float l;
void setup() {
  size(600, 600);
  colorMode(RGB,256);
  background(#FFFFFF);
  textFont(createFont("Tempus Sans ITC", 24));
  smooth();
  fill(#050000);
  line(300,600,300,400);
}

void lineR(float x1, float y1, float x2, float y2, int n) {
  l = a/n;
  line(x2,y2,x2-(l*cos(PI/3+n/5)),y2-(l*sin(PI/3 + n/50)));
//  line(x2,y2,x2+a,y2-a);
  if (n>1) {
  lineR(x2,y2,x2-(l*cos(PI/3+n/5)),y2-(l*sin(PI/3 + n/50)),n-1);
//  lineR(x2,y2,x2+l,y2-l,n-1);
  }
}
void mousePressed(){
   if((mouseButton == LEFT) && (n < 10)) n++;
   else if((mouseButton == RIGHT) && (n > 1)) n--;
}
void draw(){
  background(#FFFFFF);
  fill(#050000);
  line(300,600,300,400);
  text("n = " + n, 10, 30);
  fill(#FFFFFF);
  lineR(300,600,300,400,n);  
}