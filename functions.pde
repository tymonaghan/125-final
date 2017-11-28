void menuLogic(boolean instruct) {
  if (instruct == true) {
    showInstructions();
  } //end if
  if (keyPressed == true && key == CODED && keyCode == UP) {
    giveInstructions=false;
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
  text (texts.get(14),xCenter, yCenter-60);
  popStyle();
  textLeading(15);
  text (texts.get(4), xCenter, yCenter-15, 225, 50); //L&R
  text (texts.get(5), xCenter, yCenter+65, 225, 50); //UP
  text (texts.get(6), xCenter, yCenter+150, 225, 50); //JUMP to Begin
  callButtonHelpers(xCenter, yCenter);
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

int changeScore(int val_){
  int val = val_;
  return val;
} //end changeScore

void playerFunctions() {
  playerCharacter.spawn();
  playerCharacter.controls();
  playerCharacter.checkWater();
  playerCharacter.checkDead();
  int itemX = items[p].getItemX();
  int itemY = items[p].getItemY();
  //println("itemY"+itemY);
  playerCharacter.itemPickupCheck(itemX,itemY);
  
  int hazardX = hazards[h].getHazardX();
  int hazardY = hazards[h].getHazardY();
  playerCharacter.hazardCheck(hazardX,hazardY);
  playerCharacter.speedNormalizer(p);
} //end playerFunctions