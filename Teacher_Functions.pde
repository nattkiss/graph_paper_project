void drawMainMenu(Button button1, Button button2, ArrayList<String> instructions) {

  fill(230, 230, 230);
  stroke(0,0,0);
  rectMode(CORNERS);
  rect(0, 0, width, 0.15*height);

  textSize(12);
  fill(0, 0, 0);
  textAlign(LEFT, CENTER);

  text("Use cursor keys to pan.", 0.03*width, 0.05*height);
  text("Use 'z' to zoom in.", 0.03*width, 0.07*height);
  text("Use 'x' to zoom out.", 0.03*width, 0.09*height);
  text("Use 'a' to reset.", 0.03*width, 0.11*height);


  textAlign(CENTER, CENTER);
  text("Select a Mode:", 0.35*width, 0.035*height);
  button1.display();
  button2.display();

  textSize(12);
  textAlign(CENTER, CENTER);
  for (int i = 0; i < instructions.size(); i++) {
    text(instructions.get(i), 0.7*width, 0.075*height - instructions.size()/2.0*14 + i*14 + 5);
  }
}



void runNone(ArrayList<String> messages) {
  messages.clear();
  messages.add("*** Select a Mode using the buttons on the left ***");
}