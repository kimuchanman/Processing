Properties p;

PImage img;
void setup(){
  size(700, 500, P3D);
  img = loadImage("kinnzoku.jpg");
  noStroke();
  p = new Properties();
}

void draw(){
  sphereDetail(120);
  lightSpecular(255, 255, 255);
  directionalLight(p.getDirectionalLR(), p.getDirectionalLG(), p.getDirectionalLB(), -.5, .5, -1);
  ambientLight(p.getAmbientLR(), p.getAmbientLG(), p.getAmbientLB());
  ambient(p.getAmbientR(), p.getAmbientG(), p.getAmbientB());
  specular(p.getSpecularR(), p.getSpecularG(), p.getSpecularB());
  emissive(p.getEmissiveR(), p.getEmissiveG(), p.getEmissiveB());
  shininess(p.getShininess());
  pushMatrix();
    translate(200, height / 2, 0); 
    background(255);
   rotateX(map(mouseY, 0, height, PI, -PI));
  rotateY(map(mouseX, 0, width, -PI, PI));
  body(0, 10, 0, 100, 20, 150);
  wheel(30, 5, 50);
  wheel(-30, 5, 50);
  wheel(30, 5, -50);
  wheel(-30, 5, -50);
  popMatrix();
  
  p.update();

}


void mouseReleased(){
  p.release();
}

class Properties{
  HandleRGB ambientL = new HandleRGB(400, 2, "AmbientLight", 128, 128, 128);
  HandleRGB ambient = new HandleRGB(400, 84, "Ambient", 128, 128, 128);
  HandleRGB directionalL = new HandleRGB(400, 166, "DirectionalLight", 128, 128, 128);
  HandleRGB specular = new HandleRGB(400, 248, "Specular", 128, 128, 128);
  HandleRGB emissive = new HandleRGB(400, 330, "Emissive", 0, 0, 0);
  HandleA shininess = new HandleA(400, 412, "Shininess", 1);
  
  Properties(){};
  
  void update(){
    ambientL.update();
    ambient.update();
    directionalL.update();
    specular.update();
    emissive.update();
    shininess.update();
  }
  
  void release(){
    ambientL.release();
    ambient.release();
    directionalL.release();
    specular.release();
    emissive.release();
    shininess.release();
  }
  
  int getAmbientR(){ return ambient.getR(); }
  int getAmbientG(){ return ambient.getG(); }
  int getAmbientB(){ return ambient.getB(); }
  int getAmbientLR(){ return ambientL.getR(); }
  int getAmbientLG(){ return ambientL.getG(); }
  int getAmbientLB(){ return ambientL.getB(); }
  int getDirectionalLR(){ return directionalL.getR(); }
  int getDirectionalLG(){ return directionalL.getG(); }
  int getDirectionalLB(){ return directionalL.getB(); }
  int getSpecularR(){ return specular.getR(); }
  int getSpecularG(){ return specular.getG(); }
  int getSpecularB(){ return specular.getB(); }
  int getEmissiveR(){ return emissive.getR(); }
  int getEmissiveG(){ return emissive.getG(); }
  int getEmissiveB(){ return emissive.getB(); }
  int getShininess(){ return shininess.getA(); }
}

class HandleA extends Handle{
  final int handleAHeight = 40;
  int x, y;
  int offsetY = 30;
  private int A;
  Handle handleA;
  String title;
  
  HandleA(){};
  
  HandleA(int ix, int iy, String s, int a){
    x = ix; y = iy;
    handleA = new Handle(x, y + offsetY, "r", color(255, 0, 0), A = a);
    title = s;
  }
  
  int getA(){ return handleA.getColor(); }
  
  void release(){
    handleA.release();
  }
  
  void update(){
    A = getA();
    handleA.update();
    noStroke(); fill(A);
    rect(x, y, handleWidth, offsetY - 8);
    fill(0);
    text(title + ": (" + A + ")", x + 4, y + offsetY - 12);
    stroke(0); noFill();
    rect(x, y, handleWidth, handleAHeight);

    fill(255);
  }
}

class HandleRGB extends HandleA{
  final int handleRGBHeight = 80;
  private int R, G, B;
  Handle handleR, handleG, handleB;
  
  HandleRGB(){};
  
  HandleRGB(int ix, int iy, String s, int r, int g, int b){
    x = ix; y = iy;
    handleR = new Handle(x, y + offsetY, "r", color(255, 0, 0), R = r);
    handleG = new Handle(x, y + boxHeight + offsetY, "g", color(0, 255, 0), G = g);
    handleB = new Handle(x, y + 2 * boxHeight + offsetY, "b", color(0, 0, 255), B = b);
    title = s;
  }
  
  int getR(){ return handleR.getColor(); }
  int getG(){ return handleG.getColor(); }
  int getB(){ return handleB.getColor(); }
  
  void release(){
    handleR.release();
    handleG.release();
    handleB.release();
  }
  
  void update(){
    R = getR(); G = getG(); B = getB();
    handleR.update();
    handleG.update();
    handleB.update();
    noStroke(); fill(R, G, B);
    rect(x, y, handleWidth, offsetY - 8);
    fill(0);
    text(title + ": (" + R + ", " + G + ", " + B + ")", x + 4, y + offsetY - 12);
    stroke(0); noFill();
    rect(x, y, handleWidth, handleRGBHeight);

    fill(255);
  }
}

public class Handle{
  int handleX, handleY;
  final int handleWidth = 260;
  final int boxWidth = 10, boxHeight = 20;
  int boxXleft, boxXright, boxYtop, boxYbottom; // (boxXleft, boxYbottom)縺ｨ(boxXright, boxYtop)繧貞ｷｦ荳奇ｼ悟承荳九�鬆らせ縺ｫ謖√▽box
  int value;
  color c;
  String label;
  boolean over;
  boolean press;
  boolean locked = false;
  
  Handle(){};
  
  Handle(int x, int y, String s, color cl, int v){
    handleX = x; handleY = y;
    setBoxPosition();
    label = s;
    c = cl;
    value = v;
  }
  
  void setBoxPosition(){
    boxXleft = handleX + value - boxWidth / 2;  boxYbottom = handleY - boxWidth / 2;
    boxXright = handleX + value + boxWidth / 2; boxYtop = handleY + boxWidth / 2;
  }
  
  int getColor(){ return value; }
  
  int getValue(){
    int val = mouseX - handleX - boxWidth / 2;
    if(val < 0) return 0;
    else if(val > 255) return 255;
    else return val;
  } 
  
  void update(){
    setBoxPosition();

    over();
    boxPress();
    
    if(press) {
      value = getValue();
    }
    
    display();
  }
  
  void over(){
    if(overRect(boxXleft, boxYbottom, boxXright, boxYtop)) over = true;
    else over = false;
  }
  
  void boxPress(){
    if(over && mousePressed || locked) {
      press = true;
      locked = true;
    }
    else{
      press = false;
    }
  }
  
  void release(){
    locked = false;
  }
  
  boolean overRect(int xl, int yb, int xr, int yt){
    if (mouseX >= xl && mouseX <= xr && mouseY >= yb && mouseY <= yt) return true;
    else return false;
  }
  
  void display(){
    stroke(c);
    line(handleX, handleY, handleX + value, handleY);
    fill(c);
    rect(boxXleft, boxYbottom, boxWidth, boxWidth);
    stroke(0);
    if(over || press) {
      line(boxXleft, boxYbottom, boxXright, boxYtop);
      line(boxXleft, boxYtop, boxXright, boxYbottom);
    }
  }
}

void axis(char s, color c){
  int len = 200;
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

void body(int px, int py, int pz, int sx, int sy, int sz){
  pushMatrix();
  beginShape(QUADS);
  texture(img);
  textureMode(NORMAL);
  vertex(0, 1, 0, 0, 0); vertex(0, 0, 0, 0, 1);
        vertex(1, 0, 0, 1, 1); vertex(1, 1, 0, 1, 0);
      vertex(1, 1, 0, 0, 0); vertex(1, 0, 0, 0, 1);
        vertex(1, 0, 1, 1, 1); vertex(1, 1, 1, 1, 0);
      vertex(1, 1, 1, 0, 0); vertex(1, 0, 1, 0, 1);
        vertex(0, 0, 1, 1, 1); vertex(0, 1, 1, 1, 0);
      vertex(0, 1, 1, 0, 0); vertex(0, 0, 1, 0, 1);
        vertex(0, 0, 0, 1, 1); vertex(0, 1, 0, 1, 0);
      vertex(0, 1, 1, 0, 0); vertex(0, 1, 0, 0, 1);
        vertex(1, 1, 0, 1, 1); vertex(1, 1, 1, 1, 0);
      vertex(0, 0, 0, 0, 0); vertex(0, 0, 1, 0, 1);
        vertex(1, 0, 1, 1, 1); vertex(1, 0, 0, 1, 0);
        scale(80,60,150);
        translate(-.5, .1, -.5);
        noStroke();
        endShape();
  popMatrix();
}

void wheel(int px, int py, int pz){
  pushMatrix();
  noStroke();
  fill(0);
  translate(px, py, pz);
  scale(.5, 1, 1);
  sphere(15);
  popMatrix();
}