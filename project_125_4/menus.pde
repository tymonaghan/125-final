void keyPressed() { //SPACEBAR to bring up menu
  if (key == ' ') {
    escapeMenu();
  }
} // end keyPressed

void mousePressed() {
  if (gamePaused) {
    resumeButton.clickCheck(mouseX, mouseY, 0);
    instructionsButton.clickCheck(mouseX, mouseY, 1);
    restartButton.clickCheck(mouseX, mouseY, 2);
    exitButton.clickCheck(mouseX, mouseY, 3);
  } //end if Paused
}//end mousePressed

void escapeMenu() {
  fill(155, 200); //gray color
  rectMode(CENTER);
  rect(xCenter, yCenter, width, height); //darkens screen when paused
  stroke(95, 95, 95);
  strokeWeight(5);
  fill(178, 87, 245);
  rect(xCenter, yCenter, xCenter, yCenter);
  fill(0);
  text(texts.get(9), xCenter, yCenter-140);
  resumeButton.display(colorScheme[6], colorScheme[10], 13); //13
  instructionsButton.display(colorScheme[7],colorScheme[11], 7); //7
  restartButton.display(colorScheme[8], colorScheme[11], 10); //10
  exitButton.display(colorScheme[9], colorScheme[12], 8); //8
  noLoop();
  gamePaused= true;
} // end escape menu

void executeButton(int function_) {
  int function = function_;
  if (function == 1) {
    giveInstructions=true;
  } else if (function ==2) {
    println("THIS BUTTON NOT YET FUNCTIONAL");
  } else if (function == 3) {
    exit();
  }
} //end execute button function

void failMenu() {
  fill(100, 50); //gray color
  rectMode(CENTER);
  rect(xCenter, yCenter, width, height); //darkens screen when paused
  stroke(colorScheme[10]);
  strokeWeight(5);
  fill(colorScheme[3]);
  rect(xCenter, yCenter, xCenter, yCenter);
  fill(0);
  text(texts.get(9), xCenter, yCenter-140);
  instructionsButton.display(colorScheme[7],colorScheme[11], 7); //7
  restartButton.display(colorScheme[8], colorScheme[11], 10); //10
  exitButton.display(colorScheme[9], colorScheme[12], 8); //8
}

void winScreen() {
  fill(colorScheme[10],50); //gray color
  rectMode(CENTER);
  rect(xCenter, yCenter, width, height); //darkens screen when paused
  stroke(colorScheme[10]);
  strokeWeight(5);
  fill(colorScheme[3]); // menu purple
  rect(xCenter, yCenter, xCenter, yCenter);
  fill(0);
  text("YOU WIN!",xCenter,yCenter);
} //end winScreen

void hurtHelperMenu() {
  gamePaused=true;
  stroke(colorScheme[10]);
  strokeWeight(5);
  fill(colorScheme[3]); //menu purple
  rect (xCenter, yCenter, xCenter, yCenter);
  fill(0);
  text("You Drowned. Lives Remain:"+playerLives,xCenter,yCenter);
} //hurtMenuHelper