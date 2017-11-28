void setupFunctions() {

  //initialize color scheme
  colorScheme[0] = color(175, 164, 95); //brick brown
  colorScheme[1] = color(159, 211, 92); //olive green
  colorScheme[2] = color(150, 135, 70); //floor brown
  colorScheme[3] = color(178, 87, 245); //menu box purple
  colorScheme[4] = color(88, 200, 255, 150); //water (alpha);
  colorScheme[5] = color(139, 217, 255); //water (top);
  colorScheme[6] = color(137, 219, 115); //button green
  colorScheme[7] = color(67, 198, 247); //button blue
  colorScheme[8] = color (236, 237, 12); //button yellow
  colorScheme[9] = color(196, 0, 10); //button red
  colorScheme[10] = color(50, 50, 50); //gray text
  colorScheme[11] = color (0); //black
  colorScheme[12] = color (255); //white

  //CONSTRUCT CLASS OBJECTS
  playerCharacter = new Character(xCenter, yCenter, 1, color(255, 255, 54), playerSpeed); //construct player character
  for (int p = 0; p < items.length; p++) {
    items[p] = new Item(int(random(75, width-75)), p%5); //initialize array of items, every 5th is 'special'
  } //end for loop to create array of Items
  for (int h = 0; h < hazards.length; h++) {
    hazards[h] = new Hazard (int(random(hazardValue*2,width-hazardValue*2)),-hazardValue,int(random(2)),int(random(hazardValue*3,hazardValue*5)),int(random(hazardValue,hazardValue*2)),int(random(5))); //xPos_, yPos_, shape_, xSize_, ySize, level_
  } //end special for-loop

  //CONSTRUCT BUTTONS FOR MENU
  resumeButton = new Button(xCenter, yCenter-100, 200, 50); //13
  exitButton = new Button(xCenter, yCenter+125, 200, 50); //8
  restartButton = new Button(xCenter, yCenter+50, 200, 50); //10
  instructionsButton = new Button(xCenter, yCenter-25, 200, 50); //7

  buildTexts(); //build texts list
  frameRate(25); //set framerate
} //end setupFunctions

//BUILDTEXTS - - - - - - - - - - - - - - - - - - - -BUILDTEXTS
void buildTexts() {
  texts.set(0, "PIE-CHASER");
  texts.set(1, "Welcome to PieChaser");
  texts.set(2, "a game by T. Monaghan");
  texts.set(3, "Eat pie, run faster, don't die.");
  texts.set(4, "Use the LEFT and RIGHT Arrow keys to MOVE left and right.");
  texts.set(5, "Use the UP and DOWN arrow keys to move up and down");
  texts.set(6, "Ready? Press 'UP' to Begin!");
  texts.set(7, "Show I)nstructions");
  texts.set(8, "EX)it Game");
  texts.set(9, "Game Paused");
  texts.set(10, "ReS)tart");
  texts.set(11, "Restart? All progress will be lost.");
  texts.set(12, "High Scores:");
  texts.set(13, "R)esume Game");
  texts.set(14, "Avoid hazards that slow you down.");
} //end buildTexts