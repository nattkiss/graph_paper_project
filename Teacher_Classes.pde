// The Point class used for this project
//
// pixelX and pixelY are the *original* pixel locations of the point when it was first created.  
// Note that these may not be the *current* pixel locations of the point if the user has panned 
// or zoomed.
//
// graphX and graphY are the graph coordinates of the point.  These stay the same even if the user
// pans or zooms.
//
// The methods currentPixelX() and currentPixelY() return the *curent* pixel coordiantes taking into
// account any user pans or zooms that occurred after the point was created.
class Point {
  float pixelX, pixelY;
  float graphX, graphY;
  
  // The "var" variables can be used by the student to store other attributes for the point
  // that might be needed for his or her particular program.
  float var1, var2, var3, var4, var5;  
  
  // This 3-argument construtor creates the point using the current *pixel location* as input.  The graph coordinates 
  // are then computed using the point's current pixel location and the graph paper's origin and gridSpacing
  Point(float _pixelX, float _pixelY, GraphPaper paper) {
    pixelX = _pixelX;
    pixelY = _pixelY;
    graphX = (pixelX - paper.originX) / paper.gridSpacing;
    graphY = (paper.originY - pixelY) / paper.gridSpacing;
  }

  // This 2-argument constructor create the point using the *graph location* as input.
  Point(float _graphX, float _graphY) {
    graphX = _graphX;
    graphY = _graphY;
  }

  // This method returns the current pixel X location of the point.  Note that this may not be equal to the
  // original pixel location when the point was created, since the user may have panned or zoomed.
  float currentPixelX() {
    return (graphX * paper.gridSpacing + paper.originX);
  }

  // This method returns the current pixel Y location of the point.  Note that this may not be equal to the
  // original pixel location when the point was created, since the user may have panned or zoomed.
  float currentPixelY() {
    return (paper.originY - graphY * paper.gridSpacing);
  }
  
  //Draws the point on the screen.
  void drawPoint(int r, int g, int b) {
    fill(r,g,b);
    noStroke();
    ellipse(currentPixelX(), currentPixelY(), 7, 7);
  }
}




class GraphPaper {
  float originX, originY; 
  float gridSpacing; 

  // The constructor takes three input arguments: the initail pixel location for the 
  // graph paper's origin, and the grid spacing in pixels.
  GraphPaper(float _originX, float _originY, float _gridSpacing) {
    originX = _originX;
    originY = _originY;
    gridSpacing = _gridSpacing;
  }


  // This method draws the graph paper on the screen
  void display() {
    float x, y;

    // light gray grid lines spaced every grid space
    strokeWeight(1);
    stroke(200, 200, 200);
    for (x=originX; x<=width; x+=gridSpacing) line(x, 0, x, height);
    for (x=originX; x>=0; x-=gridSpacing) line(x, 0, x, height);
    for (y=originY; y<=height; y+=gridSpacing) line(0, y, width, y);
    for (y=originY; y>=0; y-=gridSpacing) line(0, y, width, y);

    // darker gray grid lines spaced every 5 grid spaces
    strokeWeight(1);
    stroke(100, 100, 100);
    for (x=originX; x<=width; x+=5*gridSpacing) line(x, 0, x, height);
    for (x=originX; x>=0; x-=5*gridSpacing) line(x, 0, x, height);
    for (y=originY; y<=height; y+=5*gridSpacing) line(0, y, width, y);
    for (y=originY; y>=0; y-=5*gridSpacing) line(0, y, width, y);

    // heavy black lines for the x and y axes
    strokeWeight(3);
    stroke(0, 0, 0);
    line(originX, 0, originX, height);
    line(0, originY, width, originY);
  }

  // The method resets the graph paper origin's position and grid spacing to their default values
  void reset() {
    originX = width*0.5;
    originY = height*0.55;
    gridSpacing = 10.0;
  }

  // These methods handle panning and zooming by the user
  void shiftRight() {
    originX -= gridSpacing;
  }

  void shiftLeft() {
    originX += gridSpacing;
  }

  void shiftDown() {
    originY -= gridSpacing;
  }

  void shiftUp() {
    originY += gridSpacing;
  }

  void zoomIn() {
    gridSpacing *= 2.0; 
    if (gridSpacing >= width*0.3) gridSpacing = width*0.3;
  }

  void zoomOut() {
    gridSpacing /= 2.0; 
    if (gridSpacing <= 3.0) gridSpacing = 3.0;
  }
  
  //These methods return the window boundaries.
  float maxX() {
    return (width - originX)/gridSpacing;
  }
  float minX() {
    return -1*originX/gridSpacing;
  }
}






// This is the button class definition
class Button {
  // these internal variables are created for each new button 
  float x, y, w, h;    // stores the location and geometry of the button
  String label;        // stores the label to printinside the button
  boolean pressed;     // stores a boolean (true or false) for if the button is being pressed

  // this is the constructor method.  It is called automatically when a new instance of the
  // button is created.  Note that the expected input is the same information that's passed
  // to this constructor when a button is instantiated at the top of the code.
  Button(float initialx, float initialy, String initialLabel) {
    x = initialx;
    y = initialy;
    w = 150;
    h = 20;  
    label = initialLabel;
    pressed = false;
  }

  // this draw the button.  it's drawn slightly differently if the button is being pressed or not.
  // this gives the appearance that the button is being pressed down.
  void display() {

    // backgrond fill of button
    fill(240);
    noStroke();
    rectMode(CENTER);
    rect(x, y, w, h);

    // draw shading with shadow in the lower right side of the box
    if (pressed == false) {
      stroke(190);

      strokeWeight(3);
      line(x-w/2.0, y+h/2.0, x-w/2.0, y-h/2.0);
      line(x-w/2.0, y-h/2.0, x+w/2.0, y-h/2.0);
      stroke(0);
      line(x-w/2.0, y+h/2.0, x+w/2.0, y+h/2.0);
      line(x+w/2.0, y-h/2.0, x+w/2.0, y+h/2.0);
      strokeWeight(1);
    }

    // draw shading with shadow in the upper left side of the box
    if (pressed == true) {
      stroke(0);

      strokeWeight(3);
      line(x-w/2.0, y+h/2.0, x-w/2.0, y-h/2.0);
      line(x-w/2.0, y-h/2.0, x+w/2.0, y-h/2.0);
      stroke(190);
      line(x-w/2.0, y+h/2.0, x+w/2.0, y+h/2.0);
      line(x+w/2.0, y-h/2.0, x+w/2.0, y+h/2.0);
      strokeWeight(1);
    }

    // print the label
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, x, y-1.);
  }

  // checks if the current mouse coordiantes are on top of the button AND if the 
  // mouse button is being pressed.  If so then return true and set the internal
  // pressed variable to true.
  boolean pressed() {
    float mx = mouseX;
    float my = mouseY;
    if (mx>=x-w/2.0 && mx<=x+w/2.0 && my>=y-h/2.0 && my<=y+h/2.0 && mousePressed==true) {
      this.pressed = true;
      return true;
    } else {
      this.pressed = false; 
      return false;
    }
  }
  
  // checks if the current mouse coordiantes are on top of the button AND if the 
  // mouse button is being clicked (pressed and released). 
  boolean clicked() {
    float mx = mouseX;
    float my = mouseY;
    if (mx>=x-w/2.0 && mx<=x+w/2.0 && my>=y-h/2.0 && my<=y+h/2.0 && mousePressed==true) {
      this.pressed = true;
      return false;
    } else
      if (mx>=x-w/2.0 && mx<=x+w/2.0 && my>=y-h/2.0 && my<=y+h/2.0 && pressed==true && mousePressed==false) {
        this.pressed = false;
        return true;
      } else {
        this.pressed = false;
        return false;
      }
  }
} // end class definition