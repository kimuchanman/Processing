int i;
int a;
void setup(){
  size(600, 600, P3D);
  noStroke();
}

void leaf(int r, int g, int b){
  fill(r, g, b);
  beginShape(TRIANGLES);
    vertex(0, .5, 0); vertex(-.5, 0, -.5); vertex(.5, 0, -.5);
    vertex(0, .5, 0); vertex(.5, 0, -.5); vertex(.5, 0, .5);
    vertex(0, .5, 0); vertex(.5, 0, .5); vertex(-.5, 0, .5);
    vertex(0, .5, 0); vertex(-.5, 0, .5); vertex(-.5, 0, -.5);
    vertex(-.5, 0, -.5); vertex(.5, 0, .5); vertex(.5, 0, -.5);
    vertex(-.5, 0, -.5); vertex(-.5, 0, .5); vertex(.5, 0, .5);
  endShape();
}

void leaves(){
  pushMatrix(); translate(0, .5, 0); scale(.6, .6, .6); leaf(0, 224, 0); popMatrix();
  pushMatrix(); translate(0, .25, 0); scale(.8, .8, .8); leaf(0, 192, 0); popMatrix();
  leaf(0, 128, 0);
}

void stem(){
  fill(128, 64, 0);
  pushMatrix();
    scale(.2, .4, .2);
    translate(0, .5, 0);
    box(1);
  popMatrix();
}

void tree(float s){
  scale(s, 2*s, s);
  stem();
  translate(0, .4, 0);
  leaves();
}

void roof(){
  fill(128, 64, 0);
  beginShape(TRIANGLES);
    vertex(0, .5, 0); vertex(-.5, 0, -.5); vertex(.5, 0, -.5);
    vertex(0, .5, 0); vertex(.5, 0, -.5); vertex(.5, 0, .5);
    vertex(0, .5, 0); vertex(.5, 0, .5); vertex(-.5, 0, .5);
    vertex(0, .5, 0); vertex(-.5, 0, .5); vertex(-.5, 0, -.5);
    vertex(-.5, 0, -.5); vertex(.5, 0, .5); vertex(.5, 0, -.5);
    vertex(-.5, 0, -.5); vertex(-.5, 0, .5); vertex(.5, 0, .5);
    translate(0, .5, 0);
    scale(1.5, 1.5, 1.5);  
  endShape();
}

void wall(){
  fill(255,69,0);
  pushMatrix();
    scale(1, 1, 1);
    translate(0, .5, 0);
    box(1);
  popMatrix();
}

void house(float s2){
  scale(s2, s2, s2);
  wall();
  translate(0, .4, 0);
  roof();
}


void draw(){
  
  background(255);
  translate(width/2, height/2, 0);
  rotateX(map(mouseY, 0, height, PI, -PI));
  rotateY(map(mouseX, 0, width, -PI, PI));
  
  
   for(i = -100;i<100;i++){
     pushMatrix();
      translate(-100, 0, 400*i);
      house(100);
     popMatrix();
   }
   
   for(i = -100;i<100;i++){
     pushMatrix();
      translate(100, 0, 400*i);
      house(100);
     popMatrix();
   }

 
 for(i = -100;i<100;i++){
     pushMatrix();
      translate(-100, 0, 400*i-200);
      tree(100);
     popMatrix();
   }
 
 for(i = -100;i<100;i++){
     pushMatrix();
      translate(100, 0, 400*i-200);
      tree(100);
     popMatrix();
   }
   
 translate(0, 0, a-10);  
  pushMatrix();
   noStroke();
   fill(128, 64, 0);
   translate(0, 30, 0);
   box( 90, 60, 150);
  popMatrix();
  wheel(30, 0, 50, 16);
  wheel(-30, 0, 50, 16);
  wheel(30, 0, -50, 16);
  wheel(-30, 0, -50, 16);
  a += 1;
}

void axis(char s, color c){
  int len = 100;
  fill(c);
  stroke(c);
  box(len, 1, 1);
  pushMatrix();
   translate(len/2, 0, 0);
   sphere(3);
   text(s, 5, -5, 0);
  popMatrix();
  pushMatrix();
   translate(0, -len/2, -len/2);
   int ngrids = 20;
   int xs = len/ngrids, ys = len/ngrids;
   for(int i = 1; i < ngrids; i++){
     line(0, 0, ys*i, 0, len, ys*i);
     line(0, xs*i, 0, 0, xs*i, len);
   }
  popMatrix();
}

void drawAxis(char s, color c){
  switch(s){
    case 'X': axis(s, c); break;
    case 'Y': pushMatrix(); rotateZ(PI/2); axis(s, c); popMatrix(); break;
    case 'Z': pushMatrix(); rotateY(-PI/2); axis(s, c); popMatrix(); break;
  }
}

void wheel(int px, int py, int pz, int n){
  pushMatrix();
   noStroke();
   fill(0);
   translate(px, py, pz);
   scale(.5, 1, 1);
   sphere(n);
  popMatrix();
}