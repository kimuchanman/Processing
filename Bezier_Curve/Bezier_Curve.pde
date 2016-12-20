int npoints = 10000, n = 0;
int[] x = new int[npoints], y = new int[npoints]; 

void setup(){
size(600, 600); // height must be equal to width
   background(255);
   textFont(createFont("Tempus Sans ITC", 18));
   textAlign(CENTER);
   fill(0);
   smooth();
   drawParamFuncs(drawGrid(10));
}

//first,draw Coordinate
float xInWindow(float x, int unit){ return(x * unit + width / 2); } // x in Window
float yInWindow(float y, int unit){ return(- y * unit + height / 2); } // y in Window

int drawGrid(int maxVal){ // draw grids
  int unitPixels = width / maxVal / 2; // grid interval(pixels/unit)
    int xc = width / 2, yc = height / 2;

  stroke(144, 238, 144);
  for(int i = 1 - maxVal; i < maxVal; i++){
    line(0, unitPixels * i + xc, width, unitPixels * i + yc);  // horizontal grid
    line(unitPixels * i + xc, 0, unitPixels * i + yc, height); // vertical grid
    if(i != 0){
       text(i, unitPixels * i + xc, yc + 18); // x-coordinate values
       text(i, xc - 14, unitPixels * i + yc + 5); // y-coordinate values
    }
  }
  stroke(0);
  text("O", xc - 14, yc + 18); // Origin(at the center of the Window)
  line(0, yc, width, yc); // x-axis
  line(xc, 0, xc, height);  // y-axis

  return unitPixels;
}

void drawParamFuncs(int unit){ // draw func()
     float theta = 1, step = 1; // parameter
   float x1, y1, x2, y2; // (x1, y1) and (x2, y2) are positions in Window
   x2 = xInWindow(xFunc(theta), unit);
   y2 = yInWindow(yFunc(theta), unit);
   while(theta < TWO_PI){
      x1 = x2; y1 = y2;
     x2 = xInWindow(xFunc(theta += step), unit);
     y2 = yInWindow(yFunc(theta), unit);
     line(x1, y1, x2, y2);
  }
}
float xFunc(float t){return 0;}
float yFunc(float t){return 0;}

//second,draw Bezier_Curve
void draw(){ }

void mouseClicked(){
  update(mouseX, mouseY);
}

void update(int p, int q){
  if(mouseButton == LEFT){
    if(n == npoints){
      n = 0;
      background(255);
    }
    x[n] = p; y[n] = q; // save (x, y) into array

    noStroke();
    fill(255, 0, 0);
    ellipse(x[n], y[n], 5, 5); // draw point (x[n], y[n])

    if(n != 0){ // draw line (x[n-1], y[n-1])-(x[n], y[n])
      stroke(200);
      line(x[n - 1], y[n - 1], x[n], y[n]);

      if(n%3 == 0){
         stroke(0, 0, 255);
         noFill();
         bezier(x[n - 3], y[n - 3], x[n - 2], y[n - 2], x[n - 1], y[n - 1], x[n], y[n]);
      }
    }
    n++;
  }
  else if(mouseButton == RIGHT){
    n = 0;
  }
}