GraphPaper paper; //Stores properties of the graph paper.
Button buttonApp1, buttonApp2; //Application buttons
String currentMode; //Stores the current application being run, or "None" if no application is selected.
ArrayList<String> instructions = new ArrayList<String>(); //Passes instructions into the application functions.

Quad quad; //Stores information relating to the quadratic regression program.
Circle circle; //Stores information relating to the circle program.

void setup() {
  size(800, 700);
  
  // creates the graph paper
  paper = new GraphPaper(width*0.5, height*0.55, 10);
  
  // creates the two menu buttons.  For the teacher version, these are the
  // polygon and regression buttons.  The student will want to change 
  // these button names so they are appropriate to his/her program. 
  buttonApp1 = new Button(0.35*width, 0.07*height, "Quadratic Regression");
  buttonApp2 = new Button(0.35*width, 0.11*height, "Circle From Three Points");

  // currentMode is a String that says what "mode" the program is in.
  // It starts as "None" until the user clciks on a button, and is then
  // switched accordingly (see below).
  currentMode = "None";
  
  //Initialize the arraylists of points used by both programs.
  quad = new Quad();
  circle = new Circle();
}


void draw() {
  background(255);

  // draws the graph paper
  paper.display();

  // if the user clicks on a menu button, switch modes accordingly and perform any initialization
  if (buttonApp1.clicked()) {
    currentMode = "Quadratic Regression";
    quad.initialize();
  }

  if (buttonApp2.clicked()) {
    currentMode = "Circle From Three Points";
    circle.initialize();
  }

  // Depending on what mode we're in, run the appropriate function.
  // The "instructions" arraylist is set inside the appropriate function.
  if (currentMode.equals("None"))           runNone(instructions);  
  if (currentMode.equals("Quadratic Regression"))  runQuadReg(instructions);
  if (currentMode.equals("Circle From Three Points"))  runCircle(instructions);

  // draw the main menu at the top of the screen.  Note that the 
  // customized "instructions" are passed into the function so they
  // can be printed in the main menu.
  drawMainMenu(buttonApp1, buttonApp2, instructions);
}




void mousePressed() {

  // if any of these conditions are met, just return now
  // and don't add a point to the points arraylist
  if (mouseY <= height*0.15) return;
  if (currentMode.equals("None")) return;
  
  // add the clicked location to the quad arraylist
  if (currentMode.equals("Quadratic Regression") && quad.finished==false) quad.points.add(new Point(mouseX, mouseY, paper));
  
  // add the clicked location to the circle arraylist
  if (currentMode.equals("Circle From Three Points") && circle.finished==false) circle.points.add(new Point(mouseX, mouseY, paper));
}


void keyPressed() {

  //Pans the graph paper
  if (keyCode == UP)    paper.shiftUp(); 
  if (keyCode == DOWN)  paper.shiftDown();
  if (keyCode == LEFT)  paper.shiftLeft();
  if (keyCode == RIGHT) paper.shiftRight();

  //Zooms the graph paper.
  if (key == 'z' || key == 'Z') paper.zoomIn();
  if (key == 'x' || key == 'X') paper.zoomOut();
  if (key == 'a' || key == 'A') paper.reset();
  
  //If appropriate conditions are met, the quadratic regression will be declared finished and the application will perform necessary calculations.
  if (currentMode.equals("Quadratic Regression") && key == 'd' && quad.finished == false && quad.points.size() > 2) {
    quad.finished = true;
  }
  
  //Resets the quadratic regression (and the circle too, just in case), deleting the points.
  if (currentMode.equals("Quadratic Regression") && key == 's') {
    quad.initialize();
  }
  
  //Same for the circle program.
  if (currentMode.equals("Circle From Three Points") && key == 's') {
    circle.initialize();
  }
}