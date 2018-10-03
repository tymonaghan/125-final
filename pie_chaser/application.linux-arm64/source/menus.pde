void keyPressed() { //SPACEBAR to bring up menu
  if (key == ' ') {
    escapeMenu();
  }
} // end keyPressed

void mousePressed() {
  resumeButton.clickCheck(mouseX, mouseY, 0);
  instructionsButton.clickCheck(mouseX, mouseY, 1);
  restartButton.clickCheck(mouseX, mouseY, 2);
  exitButton.clickCheck(mouseX, mouseY, 3);
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
  instructionsButton.display(colorScheme[7], colorScheme[11], 7); //7
  restartButton.display(colorScheme[8], colorScheme[11], 10); //10
  exitButton.display(colorScheme[9], colorScheme[12], 8); //8
  noLoop();
} // end escape menu

void executeButton(int function_) {
  int function = function_;
  if (function == 1) {
    currentGameState = EGameState.MainMenu;
  } else if (function ==2) {
    gameReset();
  } else if (function == 3) {
    exit();
  }
} //end execute button function

void failMenu() {
  movingBackground(0);
  fill(100, 50); //gray color
  rectMode(CENTER);
  rect(xCenter, yCenter, width, height); //darkens screen when paused
  stroke(colorScheme[10]);
  strokeWeight(5);
  fill(colorScheme[3]);
  rect(xCenter, yCenter, xCenter, yCenter);
  fill(0);
  text(texts.get(16), xCenter, height/3);
  text("Score:"+score,xCenter, height/2.75);
  instructionsButton.display(colorScheme[7], colorScheme[11], 7); //7
  restartButton.display(colorScheme[8], colorScheme[11], 10); //10
  exitButton.display(colorScheme[9], colorScheme[12], 8); //8
}

void winScreen() {
  fill(colorScheme[10], 50); //gray color
  rectMode(CENTER);
  rect(xCenter, yCenter, width, height); //darkens screen when paused
  stroke(colorScheme[10]);
  strokeWeight(5);
  fill(colorScheme[3]); // menu purple
  rect(xCenter, yCenter, xCenter, yCenter);
  fill(0);
  textAlign(CENTER);
  text("YOU WIN!", xCenter, yCenter);
} //end winScreen

void hurtHelperMenu() {
  score = scoreBoard(frameCount/5, playerLives);
  rectMode(CENTER);
  stroke(colorScheme[10]);
  strokeWeight(5);
  fill(colorScheme[3]); //menu purple
  rect (xCenter, yCenter, xCenter, yCenter);
  fill(0);
  textAlign(CENTER);
  text("You Drowned.", xCenter, yCenter-100);
  text("Lives Remaining:"+playerLives, xCenter, yCenter-25);
  text("Current Score:"+score, xCenter, yCenter+height/7);
  text("Press LEFT to resume", xCenter+25, yCenter+height/18);
  translate(-50, 50);
  strokeWeight(1);
  stroke(0);
  fill(100);
  rect(xCenter-40, yCenter-15, 35, 35, 5);
  line(xCenter-30, yCenter-15, xCenter-50, yCenter-15);
  line(xCenter-50, yCenter-15, xCenter-43, yCenter-8);
  line(xCenter-50, yCenter-15, xCenter-43, yCenter-22);
} //hurtMenuHelper
