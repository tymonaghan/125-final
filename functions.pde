void menuLogic(boolean instruct) {
  if(instruct == true) {
    showInstructions();
  } //end if
  if (keyPressed == true && key == CODED && keyCode == UP){
  giveInstructions=false;
  } //end if 
  
} // end menuLogic

void movePlatforms() {
  for (int i = 0; i<plats.length; i++) {
  } //end for loop
} //end movePlatforms

void drawWater() {
  rectMode(CORNERS);
  noStroke();
  fill(88,200,255,150);
  rect(30, height-75, width-30,height);
  fill(139,217,255);
  quad(30,height-75, 55,height-90, width-55,height-90, width-30,height-75);
}

void showInstructions() {
  int xCenter = width/2;
  int yCenter = height/2;
  
  stroke(0);
  strokeWeight(3);
  fill(178, 87, 245);
  rectMode(CENTER);
  rect(xCenter,yCenter,xCenter,yCenter);
  stroke(0);
  fill(0);
  textAlign(CENTER);
  textSize(25);
  text(texts.get(0), xCenter,yCenter-120); //title
  textSize(10);
  text(texts.get(2), xCenter, yCenter-105); //by-line
  textSize(15);
  text (texts.get(3), xCenter, yCenter-80);
  textLeading(15);
  text (texts.get(4), xCenter, yCenter-15,225,50); //L&R
  text (texts.get(5), xCenter, yCenter+65,225,50); //UP
  text (texts.get(6), xCenter, yCenter+150,225,50); //JUMP to Begin
  callButtonHelpers(xCenter,yCenter);
  } 
  
void buildTexts(){
  texts.set(0, "FLOODRUNNER");
  texts.set(1, "Welcome to FloodRunner");
  texts.set(2, "a game by T. Monaghan");
  texts.set(3, "Outrun and Outjump the flood.");
  texts.set(4, "Use the LEFT and RIGHT Arrow keys to MOVE left and right.");
  texts.set(5, "Use the UP Arrow Key to JUMP");
  texts.set(6, "Ready? Press 'JUMP' to Begin!");
  
} //end buildTexts

void callButtonHelpers(int x, int y){
  rectMode(CENTER);
  stroke(0);
  strokeWeight(2);
  fill(150);
  rect(x-40,y+15,35,35,5);
  rect(x+40,y+15,35,35,5);
  rect(x,y+90,35,35,5);
  strokeWeight(1);
  
  //left arrow key:
  line(x-30,y+15,x-50,y+15);
  line(x-50,y+15,x-43,y+8);
  line(x-50,y+15,x-43,y+22);
  
  //right arrow key:
  line(x+30,y+15,x+50,y+15);
  line(x+43,y+8,x+50,y+15);
  line(x+43,y+22, x+50,y+15);
  
  //up arrow key:
  line(x,y+100,x,y+80);
  line(x,y+80, x-7,y+87);
  line(x,y+80,x+7,y+87);
  
}//end callButtonHelpers