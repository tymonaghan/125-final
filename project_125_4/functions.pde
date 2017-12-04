int getGameState() {   // determines gameState. 0=first run, give instructions /// 1=failsafe - behaves like state 0 /// 2=main gameplay loop /// 3= paused, user wants instructions /// 4=fail condition or pause.
  int a = gameState;
  if (firstRun) {    
    a= 0;
  } else if (giveInstructions == true && gamePaused == false) {
    a= 1;
  } else if (giveInstructions == false && gamePaused == false && firstRun == false) {
    a= 2;
  } else if (giveInstructions == true && gamePaused == true) {
    a= 3;
  } else if (giveInstructions == false && gamePaused == true) {
    a= 4;
  }//end else ifs 
  return a;
}//end getGameState

void menuLogic(boolean instruct) {
  if (instruct == true) {
    showInstructions();
  } //end if
  if (keyPressed == true && key == CODED && keyCode == UP) {
    giveInstructions=false;
    firstRun = false;
    gamePaused = false;
    gameState = 2;
  } //end if
} // end menuLogic

/*void moveItems() {
 for (int i = 0; i<items.length; i++) {
 } //end for loop
 } //end moveItems*/



void showInstructions() {
  stroke(0);
  strokeWeight(3);
  fill(colorScheme[3]);
  rectMode(CENTER);
  rect(xCenter, yCenter, xCenter, yCenter);
  stroke(0);
  fill(0);
  textAlign(CENTER);
  textSize(25);
  text(texts.get(0), xCenter, yCenter-120); //title
  textSize(10);
  text(texts.get(2), xCenter, yCenter-105); //by-line
  textSize(15);
  text (texts.get(3), xCenter, yCenter-80);
  pushStyle();
  textSize(13);
  text (texts.get(14), xCenter, yCenter-60);
  popStyle();
  textLeading(15);
  text (texts.get(4), xCenter, yCenter-15, 225, 50); //L&R
  text (texts.get(5), xCenter, yCenter+65, 225, 50); //UP
  text (texts.get(6), xCenter, yCenter+150, 225, 50); //JUMP to Begin
  callButtonHelpers(xCenter, yCenter);
  drawWater(waterState);
} 



//CALLBUTTONHELPERS  --------------KEYBOARD ART FOR MENUS:
void callButtonHelpers(int x, int y) {
  rectMode(CENTER);
  stroke(0);
  strokeWeight(2);
  fill(150);
  rect(x-40, y+15, 35, 35, 5);
  rect(x+40, y+15, 35, 35, 5);
  rect(x, y+90, 35, 35, 5);
  strokeWeight(1);

  //left arrow key:
  line(x-30, y+15, x-50, y+15);
  line(x-50, y+15, x-43, y+8);
  line(x-50, y+15, x-43, y+22);

  //right arrow key:
  line(x+30, y+15, x+50, y+15);
  line(x+43, y+8, x+50, y+15);
  line(x+43, y+22, x+50, y+15);

  //up arrow key:
  line(x, y+100, x, y+80);
  line(x, y+80, x-7, y+87);
  line(x, y+80, x+7, y+87);
}//end callButtonHelpers

//FRAMECOUNTER --------------------------- FRAMECOUNTER
int frameCounter() {
  a++;
  return a;
} //end frameCounter

//SCOREBOARD ------------------------------SCOREBOARD:
void scoreBoard(int score_, int lives_) {
  //load variables:
  PImage heart=loadImage("heart.png");
  int score = score_;
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


  //lung meter:
  //int wetLevel = playerCharacter.checkWater();
  //rect(35,100,15,lungMeter);
  //fill(colorScheme[10]);
  //rect(36,101,13,lungCapacity);
} //end scoreboard


void playerFunctions() {
  playerCharacter.spawn();
  playerCharacter.controls();
  playerCharacter.checkWater();
  playerCharacter.checkDead();

  int itemX = items[p].getItemX();
  int itemXX = items[p-1].getItemX();
  int itemXXX = items[p-2].getItemX();
  int itemXXXX = items[p-3].getItemX();

  int itemY = items[p].getItemY();
  int itemYY = items[p-1].getItemY();
  int itemYYY = items[p-2].getItemY();
  int itemYYYY = items[p-3].getItemY();

  //println("itemY"+itemY);
  playerCharacter.itemPickupCheck(itemX, itemY);
  playerCharacter.itemPickupCheck(itemXX, itemYY);
  playerCharacter.itemPickupCheck(itemXXX, itemYYY);
  playerCharacter.itemPickupCheck(itemXXXX, itemYYYY);

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

void objectSpawner() {
  for (int i = p; i > p-4; i--) {
    items[i].display(); //display items (max 4/time)
  }//end for loop
  for (int i = h; i >h-4; i--) {
    hazards[i].display(); //display hazards (max 4/time)
  }// end for loop
} //end objectSpawner