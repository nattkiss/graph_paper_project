//Stores information pertaining to the quadratic regression program, such as the points drawn and the parameters of the curve.
class Quad {
  ArrayList<Point> points; //Stores data points.
  boolean finished; //Stores whether or not the user has finished plotting points.
  float[][] b; //Column vector that stores the 3 coefficients of the regression parabola.
  float[][] X; //Design matrix
  float[][] y; //Stores the y-values of all of the data points.
  //These three matrices are defined so that the unique least-squares solution of Xb = y can be found.
  
  //Constructor initializes the points arraylist.
  Quad() {
    points = new ArrayList<Point>();
  }
  
  //Resets the points and sets finished to false.
  void initialize() {
    points.clear();
    finished = false;
  }
  
  //Calculates the coefficients of the regression when the user finishes plotting points.
  void calculateReg() {
    
    //Initializes the three matrices with appropriate sizes.
    b = new float[3][1];
    X = new float[points.size()][3];
    y = new float[points.size()][1];
    
    //Initialize the entries of the design matrix X.
    for (int i=0; i<X.length; i++) {
      X[i][0] = 1;
    }
    for (int i=0; i<X.length; i++) {
      X[i][1] = points.get(i).graphX;
    }
    for (int i=0; i<X.length; i++) {
      X[i][2] = pow(points.get(i).graphX, 2);
    }
    
    //Initialize the entries of y.
    for (int i=0; i<y.length; i++) {
      y[i][0] = points.get(i).graphY;
    }
    
    //Use the normal equations of Xb = y to find the least-squares solution. (X^T X b = X^T y)
    b = mMult(mMult(mInverse(mMult(mTrans(X), X)), mTrans(X)), y);
  }
  
  //Displays the parabola on the screen.
  void displayReg() {
    stroke(0,0,255);
    strokeWeight(3);
    
    float x = paper.minX(); //This variable will iterate through the x-values displayed on the screen, and starts at the far left.
    float oldX = x; //Stores the previous x-value as x iterates.
    
    //Draws a segment of the parabola for each x-value on the screen.
    while (oldX < paper.maxX()) {
      
      //Computes y-values based on the equation of the least-squares parabola.
      float y = b[0][0] + b[1][0]*x + b[2][0]*pow(x,2);
      float oldY = b[0][0] + b[1][0]*oldX + b[2][0]*pow(oldX,2);
      
      //Creates point objects for the current and previous iteration.
      Point point = new Point(x,y);
      Point oldPoint = new Point(oldX,oldY);
      
      //Draws the segment.
      line(oldPoint.currentPixelX(),oldPoint.currentPixelY(),point.currentPixelX(),point.currentPixelY());
      
      //Increments x and oldX.
      oldX = x;
      x += 0.1;
    }
    
    //Creates text box that displays information regarding the regression.
    fill(255, 255, 255);
    stroke(0, 0, 0);
    rectMode(CORNERS);
    rect(0.2*width, 0.87*height, 0.8*width, 0.98*height);
    textSize(14);
    textAlign(CENTER, CENTER);
    fill(0, 0, 0);
    text("Your quadratic regression used " + quad.points.size() + " points.", width*0.5, height*0.85+40);
    text("The best-fit line is approximately y = " + round(10.0*b[0][0])/10.0 + " + " + round(10.0*b[1][0])/10.0 + "x + " + round(10.0*b[2][0])/10.0 + "x^2.", width*0.5, height*0.85+60);
  }
}

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
// separating the two classes for clarity
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


//Stores information pertaining to the quadratic regression program, such as the points drawn and the parameters of the curve.
class Circle {
  ArrayList<Point> points; //The plotted points  (no more than 3)
  boolean finished; //Whether or not the user has finished plotting points (becomes true once three points have been plotted.)
  Point center; //Circle's center
  float r; //Circle's radius
  
  //Initializes points arraylist.
  Circle() {
    points = new ArrayList<Point>();
  }
  
  //Resets the application by clearing the points and setting finished to false.
  void initialize() {
    points.clear();
    finished = false;
  }
  
  //Calculates the center and radious of the circle based on the three plotted points (using the circumcenter method).
  void calculateCircle() {
    
    float m1, m2; //Slopes of two perpendicular bisectors.
    float b1, b2; //Y-intercepts of two perpendicular bisectors.
    float xMid1, xMid2; //X-values of midpoints of two sides of the triangle formed from the points.
    float yMid1, yMid2; //Y-values, too.
    float cx; //X-coordinate of the circumcenter.
    float cy; //Y-coordinate of the circumcenter.
    
    //Calculate midpoints.
    xMid1 = (points.get(0).graphX + points.get(1).graphX)/2;
    xMid2 = (points.get(0).graphX + points.get(2).graphX)/2;
    yMid1 = (points.get(0).graphY + points.get(1).graphY)/2;
    yMid2 = (points.get(0).graphY + points.get(2).graphY)/2;
    
    //Calculate slopes of bisectors.
    m1 = -(points.get(1).graphX - points.get(0).graphX)/(points.get(1).graphY - points.get(0).graphY);
    m2 = -(points.get(2).graphX - points.get(0).graphX)/(points.get(2).graphY - points.get(0).graphY);
    
    //Calculate y-ints of bisectors.
    b1 = yMid1 - m1*xMid1;
    b2 = yMid2 - m2*xMid2;
    
    //Calculate location of center (intersection of bisectors.)
    cx = (b2 - b1)/(m1 - m2);
    cy = m1*cx + b1;
    
    //Calculate radius.
    r = sqrt(pow(points.get(0).graphX - cx, 2) + pow(points.get(0).graphY - cy, 2));
    
    //Initialize the center field based on the calculated circumcenter.
    center = new Point(cx, cy);  
  }
  
  //Displays the circle on the screen.
  void displayCircle() {
    
    //Stores the pixel location and pixel radius of the circle.
    float rPixel = r * paper.gridSpacing;
    float cxPixel = center.currentPixelX();
    float cyPixel = center.currentPixelY();
    
    //Draws the center on the screen.
    center.drawPoint(255,0,0);
    
    //Draws the circle.
    fill(0,0,255,50);
    stroke(0,0,255);
    ellipse(cxPixel, cyPixel, 2*rPixel, 2*rPixel);
    
    //Info box.
    fill(255, 255, 255);
    stroke(0, 0, 0);
    rectMode(CORNERS);
    rect(0.2*width, 0.87*height, 0.8*width, 0.98*height);
    textSize(14);
    textAlign(CENTER, CENTER);
    fill(0, 0, 0);
    text("The center of the circle is approximately (" + round(10.0*center.graphX)/10.0 + ", " + round(10.0*center.graphY)/10.0 + ").", width*0.5, height*0.85+40);
    text("The radius of the circle is approximately " + round(10.0*r)/10.0, width*0.5, height*0.85+60);
  }
}