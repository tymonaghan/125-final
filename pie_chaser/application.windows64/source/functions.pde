void showInstructions() { //Purple menu box that shows instructions
  PImage pie = loadImage("pie.png");
  PImage pizza = loadImage("pizza.png");
  imageMode(CORNER);
  stroke(0);
  strokeWeight(3);
  fill(colorScheme[3]);
  rectMode(CENTER);
  rect(xCenter, yCenter, width*.75, height*.75);
  stroke(0);
  fill(0);
  textAlign(CENTER);
  textSize(30);
  text(texts.get(0), xCenter, yCenter-height*.3); //title
  textSize(12);
  text(texts.get(2), xCenter, yCenter-height*.27); //by-line
  
  line(xCenter-width/5, yCenter-height*.25, xCenter+width/5,yCenter-height*.25);
  
  textSize(20);
  textAlign(LEFT);
  text (texts.get(3), width*.15, yCenter-height*.2); //pies
  image(pie, width*.6, yCenter-height*.25); //example pie
  image(pizza, width*.75, yCenter-height*.25); //example pizza

  text (texts.get(14), width*.15, yCenter-height*.12); //voids
  fill(0);
  ellipseMode(CENTER);
  ellipse(width*.7, yCenter-height*.13, width/9, height*.025); //example void

  textSize(18);
  textLeading(20);
  text (texts.get(15), width*.15, yCenter-height*.05); //rectangles
  rect(width*.75, yCenter-height*.05, width/10, height/25); //example rectangle

  line(xCenter-width/5, yCenter+5, xCenter+width/5,yCenter+5);

  textAlign(CENTER);
  text (texts.get(4), width*.35, height*.6, width/2.75, height*.15); //L&R
  text (texts.get(5), width*.35, height*.75, width/2.75, height*.15); //UP
  
  line (xCenter-width/5,height*.8,xCenter+width/5,height*.8);
  
  text (texts.get(6), xCenter, height*.85); //JUMP to Begin
  callButtonHelpers(int(width*.7), int(height*.6));
  drawWater(waterState);
} 



//CALLBUTTONHELPERS  --------------KEYBOARD ART FOR MENUS:
void callButtonHelpers(int x, int y) {
  rectMode(CENTER);
  stroke(0);
  strokeWeight(2);
  fill(150);
  rect(x-40, y-15, 35, 35, 5);
  rect(x+40, y-15, 35, 35, 5);
  rect(x-40, y+90, 35, 35, 5);
  rect(x+40, y+90, 35, 35, 5);
  strokeWeight(1);

  //left arrow key:
  line(x-30, y-15, x-50, y-15);
  line(x-50, y-15, x-43, y-8);
  line(x-50, y-15, x-43, y-22);

  //right arrow key:
  line(x+30, y-15, x+50, y-15);
  line(x+43, y-8, x+50, y-15);
  line(x+43, y-22, x+50, y-15);

  //up arrow key:
  line(x-40, y+100, x-40, y+80);
  line(x-40, y+80, x-47, y+87);
  line(x-40, y+80, x-33, y+87);

  //down arrow key
  line(x+40, y+100, x+40, y+80);
  line(x+40, y+80, x+47, y+87);
  line(x+40, y+80, x+33, y+87);
}//end callButtonHelpers

//FRAMECOUNTER --------------------------- FRAMECOUNTER
int frameCounter() {
  a++;
  return a;
} //end frameCounter

//SCOREBOARD ------------------------------SCOREBOARD:
int scoreBoard(int score_, int lives_) {
  //load variables:
  PImage heart=loadImage("heart.png");
  int score = score_+playerBonus;
  int lives = lives_;
  //int lungMeter = 200;


  //score display:
  rectMode(CORNER);
  fill(155, 200);
  rect(60, 7, 200, 25);
  fill(0);
  strokeWeight(1);
  stroke(0);
  textAlign(LEFT);
  textSize(16);
  text("PLAYER ONE SCORE:"+score, 65, 25);

  //life counter:
  for (int hp = 1; hp <= lives; hp++) {
    image(heart, 300+(hp*30), 15);
  }


  //lung meter: ----------some code to build a meter for how long you are underwater, no time to implement fully
  //int wetLevel = playerCharacter.checkWater();
  //rect(35,100,15,lungMeter);
  //fill(colorScheme[10]);
  //rect(36,101,13,lungCapacity);
  return score;
} //end scoreboard


void playerFunctions() { //everything to control and interact with playerCharacter
  playerCharacter.spawn(); //draw playerCharacter
  playerCharacter.controls(); //keyboard controls for playerCharacter
  playerCharacter.checkWater(); //check whether the playerCharacter is underwater
  playerCharacter.checkDead(); //check whether playerCharacter is dead/drowned

  //this block gathers the X and Y coordinates of any items on the screen....
  int itemX = items[p].getItemX();
  int itemXX = items[p-1].getItemX();
  int itemXXX = items[p-2].getItemX();
  int itemXXXX = items[p-3].getItemX();

  int itemY = items[p].getItemY();
  int itemYY = items[p-1].getItemY();
  int itemYYY = items[p-2].getItemY();
  int itemYYYY = items[p-3].getItemY();

  //This block checks whether the player touches (picks up) an item
  //println("itemY"+itemY);
  playerCharacter.itemPickupCheck(itemX, itemY);
  playerCharacter.itemPickupCheck(itemXX, itemYY);
  playerCharacter.itemPickupCheck(itemXXX, itemYYY);
  playerCharacter.itemPickupCheck(itemXXXX, itemYYYY);

  //this block gathers X and Y coordinates as well as size and type info for hazards on the screen
  int hazardX = hazards[h].getHazardX();
  int hazardXz = hazards[h-1].getHazardX();
  int hazardXXX = hazards[h-2].getHazardX();
  int hazardXXXX = hazards[h-3].getHazardX();
  int hazardY = hazards[h].getHazardY();
  int hazardYY = hazards[h-1].getHazardY();
  int hazardYYY = hazards[h-2].getHazardY();
  int hazardYYYY = hazards[h-3].getHazardY();
  int hazardXSize = hazards[h].getHazXSize();
  int hazardXXSize = hazards[h-1].getHazXSize();
  int hazardXXXSize = hazards[h-2].getHazXSize();
  int hazardXXXXSize = hazards[h-3].getHazXSize();  
  int hazardYSize = hazards[h].getHazYSize();
  int hazardYYSize = hazards[h-1].getHazYSize();
  int hazardYYYSize = hazards[h-2].getHazYSize();
  int hazardYYYYSize = hazards[h-3].getHazYSize();
  int hazType1 = hazards[h].getHazType();
  int hazType2 = hazards[h-1].getHazType();
  int hazType3 = hazards[h-2].getHazType();
  int hazType4 = hazards[h-3].getHazType();

  // this block checks whether the Character is touching any hazards
  playerCharacter.hazardCheck(hazardX, hazardY, hazardXSize/2, hazardYSize/2, hazType1);  
  playerCharacter.hazardCheck(hazardXz, hazardYY, hazardXXSize/2, hazardYYSize/2, hazType2);
  playerCharacter.hazardCheck(hazardXXX, hazardYYY, hazardXXXSize/2, hazardYYYSize/2, hazType3);
  playerCharacter.hazardCheck(hazardXXXX, hazardYYYY, hazardXXXXSize/2, hazardYYYYSize/2, hazType4);

  playerCharacter.speedNormalizer(p);
} //end playerFunctions

void failState() {
}

void backgroundStillElements() {
  strokeWeight(3);
  fill(colorScheme[2]);
  quad(30, height, 55, height-35, width-55, height-35, width-30, height); //draw quad for floor -- only when !movingBackground
} //end backgroundstill elements

void objectSpawner() { // i think this is creating some of the issues with Restart not working.
  for (int i = p; i > p-4; i--) {
    items[i].display(); //display items (max 4/time)
  }//end for loop
  for (int i = h; i >h-4; i--) {
    hazards[i].display(); //display hazards (max 4/time)
  }// end for loop
} //end objectSpawner

void pieSpinner(int pieSpin) {
  PImage pie = loadImage("pie.png");
  PImage pizza = loadImage("pizza.png");
  pushMatrix();
  translate(xCenter,height/4);
  rotate(pieSpin);
  image(pizza,0,0);
  popMatrix();
  translate(xCenter,height/1.5);
  rotate(pieSpin);
  image (pie,0,0);
} //end pieSpinner

void gameReset() {
  waterState=0;
  gameFrameCount=0;
  a=0; b=0; xyz=0; score=0; alwaysRunning = 0; 
  h=3; p=3;
  playerLives = 3;
  currentGameState = EGameState.MainMenu;
}//end game reset
