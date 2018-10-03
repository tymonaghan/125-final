import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class pie_chaser extends PApplet {

//PIE CHASER.
//A vertical-scrolling action game.

//THESE VARIABLES SHOULD NOT BE ALTERED:
//SoundFile intro;
Character playerCharacter;
StringList texts;
int waterState=0, gameFrameCount=0, a=0, b=0, xyz=0, score=0, alwaysRunning = 0, playerBonus = 0, h=3, p=3; //various counters
int xCenter = 250, yCenter = 325; //use in place of width/2 or height/2 -- will break if canvas size is changed
Button resumeButton, exitButton, restartButton, instructionsButton; //menu button objects
int[] colorScheme = new int[16]; //array for color scheme to keep theme consistent
int currentGameState;

//THESE VARIABLES CAN BE ALTERED TO CHANGE GAMEPLAY (later encoded into menu):
int playerLives = 3;  //change the number of lives (hearts) for the player to start with. Default 3
Item[] items = new Item[50]; //create array of 100 Items - change number to change game length / win condition   default 50
int itemFrequency = 70;  //controls how often items (pies) appear. Higher numbers are harder. //Default 70
Hazard[] hazards = new Hazard[200];  //create array of Hazards, change number to change number of hazards on course. Keep above item# from line 18.   Default 200
int hazardFrequency = 50;   //controls how often hazards appear. Higher numbers are easier.  Default 50
int playerSpeed = 4;    //player speed. Faster is easier, but too fast can be very hard.   Default 4
int gameSpeed = 5;   //game speed. Faster is harder. GameSpeed should be around player Speed.  Default 5
int generosity = 30;   //how easy it is to pick up items (higher numbers are easier).  Default 30
int coolDown = 50;  //how long item effects last. higher numbers last longer. (NOT currently used).  Default 50
int lungCapacity = 30;  //how long you can remain underwater before losing a life. Default 30
int hazardValue = 25;  //change hazard size. Bigger values = Harder gameplay. Default 25


static class EGameState 
{
  static final int MainMenu = 0;
  static final int InGame = 1;
  static final int Dead = 2;
  static final int Paused = 3;
  static final int GameOver = 4;
  static final int GameWon = 5;
}
// 000000000000000000000000000000000000000000000000000000--END DECLARE VARIABLES, BEGIN SETUP--0000000000000000000000000000000000000000000000000000000000000000000000000000000000

public void setup() {  
  
  texts = new StringList(); //compile the "texts" stringList
  setupFunctions(); //moved most setup functions to their own method
} //end setup

//0000000000000000000000000000000000000000000000000000000-END SETUP---BEGIN DRAW--00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
public void draw() {
  drawStaticBackgroundElements(); //draw the non-moving background elements.
  println("gameState:"+ currentGameState);

  switch( currentGameState )  { //in place of a series of if/else statements
  case EGameState.MainMenu:
    drawMainMenu();
    break;

  case EGameState.InGame:
    drawInGame();
    break;

  case EGameState.Dead:
    drawPlayerDeadMenu();
    break;

  case EGameState.Paused:
    break;

  case EGameState.GameOver:
    drawGameOver();
    break;

  case EGameState.GameWon:
    drawGameWon();
    break;
  };
  alwaysRunning++;
} //--------------------------end draw--------------------------------------------

public void drawMainMenu() {
  //intro.play();
  movingBackground(0);
  backgroundStillElements();
  showInstructions();
  if ( keyPressed == true && key == CODED && keyCode == UP) { //press UP to start playing
    currentGameState = EGameState.InGame;
  }
}

public void drawInGame() { //main gameplay loop
  movingBackground(xyz%60); //this resets the background loop every time it gets to brick height
  drawWater(waterState); //draw the water according to waterState. Keep this in main gameplay loop because water will be underneath in menus, paused, etc.
  int gameFrameCount = frameCounter(); //run the frameCounter and store in "gameFrameCount" variable
  playerFunctions(); //calls a batch of player functions. keep in main gameplay loop.
  waterState = 1; //i think this is fine in the main gameplay loop.
  //println (); //debug
  objectSpawner();
  scoreBoard(gameFrameCount/5, playerLives);
  xyz+=gameSpeed; //rate for moving background, use gameSpeed variable
  text("Press SPACEBAR to pause", xCenter, height-15);
  if (gameFrameCount%itemFrequency==0 && p < items.length-4) {  //for-loop for spawning items
    p++;
    playerCharacter.setSpeedBoost(0);
  }//end if
  if (gameFrameCount%hazardFrequency==0 && p <items.length-4) {  //for-loop for spawning hazards
    h++;
  }//end if

  if ( playerCharacter.checkDead()) { // check to see if the player is dead or whether the game has been won and adjust the game state accordingly
    --playerLives;
    if ( playerLives > 0 ) {
      currentGameState = EGameState.Dead;
    } else {
      currentGameState = EGameState.GameOver;
    }
  }
  // check to see if the player has won the game
  if ( p == items.length-4 ) {
    currentGameState = EGameState.GameWon;
  }
} //end drawInGame ----main gameplay loop

public void drawPlayerDeadMenu() { // when player is dead but still has lives left.
  movingBackground(0);
  drawWater(2);
  hurtHelperMenu();
  if ( keyPressed == true && key == CODED && keyCode == LEFT ) { //resart with one fewer life by pressing LEFT arrow.
    currentGameState = EGameState.InGame;
    playerCharacter.reset();
  }
}

public void drawGameOver() {
  failMenu();
}

public void drawGameWon() {
  winScreen();
  pieSpinner(alwaysRunning/10);
}
class Button {
  int xSize, ySize, xPos, yPos, stringNum, buttonFunction;
  int bColor, tColor;

  Button(int xPos_, int yPos_, int xSize_, int ySize_) {
    xSize = xSize_;
    ySize = ySize_;
    xPos = xPos_;
    yPos = yPos_;
    tColor = 0;
    //bColor = bColor_;
    //stringNum = stringNum_;
  } // end Button constructor

  public void display(int bColor_, int tColor_, int nummer_) {
    stringNum = nummer_;
    bColor = bColor_;
    tColor = tColor_;
    String buttonText = texts.get(stringNum);

    rectMode(CENTER);
    stroke(0);
    strokeWeight(2);
    fill(bColor);
    textAlign(CENTER, CENTER);
    rect(xPos, yPos, xSize, ySize);
    fill(tColor);
    text(buttonText, xPos, yPos);
  } //end display

  public void clickCheck(int mX_, int mY_, int buttonFunction_) {
    int mX = mX_;
    int mY = mY_;
    buttonFunction = buttonFunction_;
    if (mousePressed == true) {
      if (mX>150 && mX<350 && mY <yPos+25 && mY > yPos-25) {
        executeButton(buttonFunction);
        loop();
        println("Button Clicked");
      }
    }
  }//end clickCheck
} //end Button class
class Character { //begin Character class
  boolean drowned = false;
  int xPos, yPos, size, wetness, itemX, itemY, base;
  int charColor;
  float speed;
  PImage avatar;

  Character(int xPos_, int yPos_, int size_, int charColor_, float speed_) { //constructor
    xPos = constrain(xPos_, 55, width-55);
    yPos = yPos_;
    size = size_;
    charColor = charColor_;
    speed = speed_;
    avatar = loadImage("avatar.png");
  }

  public void spawn () { //function to draw Character
    imageMode(CENTER);
    image(avatar, xPos, yPos);
    yPos+=gameSpeed;

    //rectMode(CENTER);
    //strokeWeight(1);
    //stroke(0);
    //fill(charColor);
    //ellipse(xPos,yPos,100,100);
    //shoes:
    //fill(15);
    println(speed);
  }//end spawn function

  //function to control the player character
  public void controls() {
    if (keyPressed == true && key == CODED) {

      //controls for moving LEFT:
      if (keyCode == LEFT) { 
        if (xPos >50) {
          xPos-=speed;
        } //end if xPos less than 50
      } // end if LEFT

      //controls for moving RIGHT
      else if (keyCode == RIGHT) { 
        if (xPos < width-50) {
          xPos+=speed;
        } //end if xPos less than 50
      } // end if RIGHT

      else if (keyCode == UP) {
        //

        yPos-=speed;
      } else if (keyCode == DOWN) {
        yPos+=speed;
      } //end if DOWN
    } //end if keypressed and coded
  }//end controls function

  public void setSpeedBoost(int boost_) {
    if (boost_ == 0) {
      speed = playerSpeed;
    } else if (boost_ == 20) {
      speed = 0;
    } else {
      speed = speed+boost_;
    } //end if
  } //end setSpeedBoost

  public void checkWater() {
    int waterHeight = drawWater(waterState); //gets the waterHeight from the drawWater function

    if (yPos > height-waterHeight) { //if playerCharacter goes below waterline...
      wetness++; 
      fill(colorScheme[12]);
      text("you're drowning!", xPos, yPos);//...they get wet
    }//end if 
    else if (wetness>0) { //if they are not underwater...
      wetness--; //...they get less wet.
    }

    print( "wetness " + wetness + " lungCapacity " + lungCapacity + "\n" );
    if (wetness > lungCapacity) { //if you stay in the water too long...
      drowned = true; //...you drown
    } //end if

    //println(wetness); //debug wetness
    //return wetness; //experimenting with a lung capacity meter
    fill(colorScheme[10]); //black
    text("oxygen level:"+(lungCapacity-wetness), 60, height-15); //ON-SCREEN OXYGEN INDICATOR
  }//end checkWater

  public boolean checkDead() {
    if (yPos>height || drowned == true) {
      waterState=2;
    } //end if
    return drowned;
  }//end checkDead

  public void itemPickupCheck(int itemX_, int itemY_) {
    int itemX = itemX_;
    int itemY = itemY_;
    if (xPos > itemX-generosity && xPos < itemX+generosity && yPos > itemY -generosity && yPos < itemY +generosity) {
      playerCharacter.setSpeedBoost(3);
      //insert a function to check whether pizza or pie and decide speed boost accordingly
      println("SPEEDBOOST");
      playerBonus+=10;
    }//end if
  }//end itemPickupCheck

  public void reset()
  {
    xPos = constrain(xCenter, 55, width-55);
    yPos = yCenter;
    drowned = false;
    wetness = 0;
  }

  public void hazardCheck(int hazardX_, int hazardY_, int xSize_, int ySize_, int hazType_) {
    int hazX = hazardX_;
    int hazY = hazardY_;
    int hazXSize = xSize_;
    int hazYSize = ySize_;
    int hazType = hazType_;
    if (xPos > hazX-hazXSize && xPos < hazX+hazXSize && yPos > hazY -hazYSize && yPos < hazY +hazYSize) {
      if (hazType == 1) {
        playerCharacter.setSpeedBoost(-1);
        println("HAZARD- elliptical - slow/reverse");
      } else {
        playerCharacter.setSpeedBoost(20);
      } //end else
      playerBonus-=5;
    } // end if
  }//end hazardCheck

  public void speedNormalizer(int base_) {
    base = base_;
    if ((p-base)>1) {
      println("COOLDOWN");
      setSpeedBoost(0);
    } //end if
  }//end speedNormalizer
}//end Character class
class Hazard {
  int xPos, yPos, shape, xSize, ySize, level;

  Hazard(int xPos_, int yPos_, int shape_, int xSize_, int ySize_, int level_) { //begin Hazard constructor
    xPos = xPos_;
    yPos = yPos_;
    shape = shape_;
    xSize = xSize_;
    ySize = ySize_;
    level = level_;
  } //end Hazard constructor

  public void display () {
    rectMode(CENTER);
    ellipseMode(CENTER);
    if (shape == 0) {
      fill(colorScheme[11]);
      rect(xPos, yPos, xSize, ySize);
    } else if (shape == 1) {
      fill(level*40+50,25,25);
      ellipse(xPos, yPos, xSize, ySize);
    }
    yPos+=gameSpeed;
  }//end display

  public void collisionCheck () {
  }

  public int getHazardX() {
    return xPos;
  } //end getItemX

  public int getHazardY() {
    return yPos;
  } //end getItemY
  
  public int getHazXSize(){
    return xSize;
  }// end getHazXSize
  
  public int getHazYSize(){
    return ySize;
  }//end getHazYSize
  
  public int getHazType() {
    return shape;
  } //end getHazType
} //end hazard class
class Item {
  //declare class variables:
  int size, xpos, ypos;
  int iColor;
  boolean special;
  PImage pie;
  PImage pizza;

  //item constructor:
  Item(int xpos_, int special_) {
    ypos=-(PApplet.parseInt(random(300)));
    xpos = xpos_;
    if (special_==1) {
      pie = loadImage("pizza.png");

      special = true;
      iColor = color(255, 150, 200);
      size = 50;
    } else {
      pie = loadImage("pie.png");
      special = false;
      iColor = color(125, 150, 200);
      size=100;
    }
  } //end constructor

  public void display() { //function to draw items
    image(pie, xpos, ypos);
    ypos+=gameSpeed; //speed at which items will fall (gameSpeed)
  }

  /*void display(int special_) {
   image (pizza,xpos,ypos);
   ypos+=gameSpeed; 
   }*/

  public void setColor(int r) {
    iColor = color(r, 150, 200);
  }

  public int getItemX() {
    return xpos;
  } //end getItemX

  public int getItemY() {
    return ypos;
  } //end getItemY
}//end item classx
class Platform{
  //declare class variables:
  int size, xpos, ypos;
  int pcolor;
  boolean special;
  
  //platform constructor:
  Platform(int xpos_, int special_){
    xpos = xpos_;
    if (special_==1){
      special = true;
      pcolor = color(255,150,200);
    } else {
      special = false;
      pcolor = color(125,150,200);
    }
  } //end constructor

public void display() { //function to draw platforms
  strokeWeight(3);
  rectMode(CORNER);
  fill(pcolor);
  rect(xpos,ypos,size,35);
}

public void setColor(int r) {
  pcolor = color(r,150,200);
}
}//end platform classx
public void movingBackground(int moveRate_) {
  int moveRate = moveRate_;
  stroke(0);

  for (int b=height; b>=-60; b-=30) { // b for bricks height, BtoT
    strokeWeight(1);
    line(55, (b+moveRate), width-55, (b+moveRate)); //horzontal lines on back wall
    line(30, (b+25+moveRate), 55, (b+moveRate)); //left hand angled bricks
    line(width-30, (b+25+moveRate), width-55, (b+moveRate)); //right hand angled bricks

    for (int bb = 55; bb < width-55; bb+=50) { //bb moves LtoR
      for (int x = height; x > -60; x-=60) {
        line(bb, (x+moveRate), bb, (x-30+moveRate)); //draws vertical lines between bricks
      }
      for (int xx = height-30; xx > -60; xx-=60) {
        line(bb+25, (xx+moveRate), bb+25, (xx-30+moveRate)); //draws other set of vertical lines between bricks
      }
    }
  }//end for loop
} //end movingBackground

public void drawStaticBackgroundElements() {
  //COMMON BACKGROUND ELEMENTS (NEVER MOVE):
  rectMode(CORNER);
  strokeWeight(4);
  stroke(50);
  fill(colorScheme[0]);//brick-brown color
  rect(0, 0, width, height); //background for whole canvas
  fill(colorScheme[1]); //olive green color
  rect(0, 0, 30, height); //draw left wall
  rect(width-30, 0, 30, height); //draw right wall
  strokeWeight(2);
  line(55, height, 55, 0); //back left corner
  line(width-55, height, width-55, 0); //back right corner
} //end drawStaticBackgroundElements
public void showInstructions() { //Purple menu box that shows instructions
  PImage pie = loadImage("pie.png");
  PImage pizza = loadImage("pizza.png");
  imageMode(CORNER);
  stroke(0);
  strokeWeight(3);
  fill(colorScheme[3]);
  rectMode(CENTER);
  rect(xCenter, yCenter, width*.75f, height*.75f);
  stroke(0);
  fill(0);
  textAlign(CENTER);
  textSize(30);
  text(texts.get(0), xCenter, yCenter-height*.3f); //title
  textSize(12);
  text(texts.get(2), xCenter, yCenter-height*.27f); //by-line
  
  line(xCenter-width/5, yCenter-height*.25f, xCenter+width/5,yCenter-height*.25f);
  
  textSize(20);
  textAlign(LEFT);
  text (texts.get(3), width*.15f, yCenter-height*.2f); //pies
  image(pie, width*.6f, yCenter-height*.25f); //example pie
  image(pizza, width*.75f, yCenter-height*.25f); //example pizza

  text (texts.get(14), width*.15f, yCenter-height*.12f); //voids
  fill(0);
  ellipseMode(CENTER);
  ellipse(width*.7f, yCenter-height*.13f, width/9, height*.025f); //example void

  textSize(18);
  textLeading(20);
  text (texts.get(15), width*.15f, yCenter-height*.05f); //rectangles
  rect(width*.75f, yCenter-height*.05f, width/10, height/25); //example rectangle

  line(xCenter-width/5, yCenter+5, xCenter+width/5,yCenter+5);

  textAlign(CENTER);
  text (texts.get(4), width*.35f, height*.6f, width/2.75f, height*.15f); //L&R
  text (texts.get(5), width*.35f, height*.75f, width/2.75f, height*.15f); //UP
  
  line (xCenter-width/5,height*.8f,xCenter+width/5,height*.8f);
  
  text (texts.get(6), xCenter, height*.85f); //JUMP to Begin
  callButtonHelpers(PApplet.parseInt(width*.7f), PApplet.parseInt(height*.6f));
  drawWater(waterState);
} 



//CALLBUTTONHELPERS  --------------KEYBOARD ART FOR MENUS:
public void callButtonHelpers(int x, int y) {
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
public int frameCounter() {
  a++;
  return a;
} //end frameCounter

//SCOREBOARD ------------------------------SCOREBOARD:
public int scoreBoard(int score_, int lives_) {
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


public void playerFunctions() { //everything to control and interact with playerCharacter
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

public void failState() {
}

public void backgroundStillElements() {
  strokeWeight(3);
  fill(colorScheme[2]);
  quad(30, height, 55, height-35, width-55, height-35, width-30, height); //draw quad for floor -- only when !movingBackground
} //end backgroundstill elements

public void objectSpawner() { // i think this is creating some of the issues with Restart not working.
  for (int i = p; i > p-4; i--) {
    items[i].display(); //display items (max 4/time)
  }//end for loop
  for (int i = h; i >h-4; i--) {
    hazards[i].display(); //display hazards (max 4/time)
  }// end for loop
} //end objectSpawner

public void pieSpinner(int pieSpin) {
  PImage pie = loadImage("pie.png");
  PImage pizza = loadImage("pizza.png");
  pushMatrix();
  translate(xCenter,height/4);
  rotate(pieSpin);
  image(pizza,0,0);
  popMatrix();
  translate(xCenter,height/1.5f);
  rotate(pieSpin);
  image (pie,0,0);
} //end pieSpinner

public void gameReset() {
  waterState=0;
  gameFrameCount=0;
  a=0; b=0; xyz=0; score=0; alwaysRunning = 0; 
  h=3; p=3;
  playerLives = 3;
  currentGameState = EGameState.MainMenu;
}//end game reset
public void keyPressed() { //SPACEBAR to bring up menu
  if (key == ' ') {
    escapeMenu();
  }
} // end keyPressed

public void mousePressed() {
  resumeButton.clickCheck(mouseX, mouseY, 0);
  instructionsButton.clickCheck(mouseX, mouseY, 1);
  restartButton.clickCheck(mouseX, mouseY, 2);
  exitButton.clickCheck(mouseX, mouseY, 3);
}//end mousePressed

public void escapeMenu() {
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

public void executeButton(int function_) {
  int function = function_;
  if (function == 1) {
    currentGameState = EGameState.MainMenu;
  } else if (function ==2) {
    gameReset();
  } else if (function == 3) {
    exit();
  }
} //end execute button function

public void failMenu() {
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
  text("Score:"+score,xCenter, height/2.75f);
  instructionsButton.display(colorScheme[7], colorScheme[11], 7); //7
  restartButton.display(colorScheme[8], colorScheme[11], 10); //10
  exitButton.display(colorScheme[9], colorScheme[12], 8); //8
}

public void winScreen() {
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

public void hurtHelperMenu() {
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
public void setupFunctions() {

  //intro = new SoundFile(this,"D:/PROCESSING/project_125_5/snakeEaterIntro.mp3");


  //initialize color scheme
  colorScheme[0] = color(175, 164, 95, 255); //brick brown
  colorScheme[1] = color(159, 211, 92, 255); //olive green
  colorScheme[2] = color(150, 135, 70, 255); //floor brown
  colorScheme[3] = color(178, 87, 245, 255); //menu box purple
  colorScheme[4] = color(88, 200, 255, 150); //water (alpha);
  colorScheme[5] = color(139, 217, 255, 200); //water (top);
  colorScheme[6] = color(137, 219, 115, 255); //button green
  colorScheme[7] = color(67, 198, 247, 255); //button blue
  colorScheme[8] = color (236, 237, 12, 255); //button yellow
  colorScheme[9] = color(196, 0, 10, 255); //button red
  colorScheme[10] = color(50, 50, 50, 255); //gray text
  colorScheme[11] = color (0, 255); //black
  colorScheme[12] = color (255, 255); //white

  //CONSTRUCT CLASS OBJECTS
  playerCharacter = new Character(xCenter, yCenter, 1, color(255, 255, 54), playerSpeed); //construct player character
  for (int p=0; p <3; p++) {
    items[p] = new Item(-300, 0);
  }//end for loop to create first 3 array items off-screen
  for (int p = 3; p < items.length-3; p++) {
    items[p] = new Item(PApplet.parseInt(random(75, width-75)), p%5); //initialize array of items, every 5th is 'special'
  } //end for loop to create array of Items
  for (int h = 0; h <3; h++) {
    hazards[h] = new Hazard (1000, 0, 0, 0, 0, 0);
  }//end for loop to create first 3 array items off-screen
  for (int h = 3; h < hazards.length-3; h++) {
    hazards[h] = new Hazard (PApplet.parseInt(random(hazardValue*2, width-hazardValue*2)), -(PApplet.parseInt(random(5)))*hazardValue, PApplet.parseInt(random(2)), PApplet.parseInt(random(hazardValue*3, hazardValue*8)), PApplet.parseInt(random(hazardValue, hazardValue*2)), PApplet.parseInt(random(5))); //xPos_, yPos_, shape_, xSize_, ySize, level_
  } //end  for-loop

  //CONSTRUCT BUTTONS FOR MENU
  resumeButton = new Button(xCenter, yCenter-100, 200, 50); //13
  exitButton = new Button(xCenter, yCenter+125, 200, 50); //8
  restartButton = new Button(xCenter, yCenter+50, 200, 50); //10
  instructionsButton = new Button(xCenter, yCenter-25, 200, 50); //7

  buildTexts(); //build texts list
  frameRate(25); //set framerate
  currentGameState = EGameState.MainMenu;
} //end setupFunctions

//BUILDTEXTS - - - - - - - - - - - - - - - - - - - -BUILDTEXTS
public void buildTexts() {
  texts.set(0, "PIE-CHASER");
  texts.set(1, "Welcome to Pie-Chaser");
  texts.set(2, "a game by T. Monaghan");
  texts.set(3, "Eat pies to speed up");
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
  texts.set(14, "Voids slow you down");
  texts.set(15, "Rectangular barriers stop you\nAvoid them at all costs!");
  texts.set(16, "You Lose. Try Again?");
} //end buildTexts
public int drawWater(int waterState_) { //waterState 0 = puddle, game start.  waterState 1 = gameplay, 75. waterState 2 = rising, fail condition
  int waterHeight = 75;
  if (waterState_==0) { //if state is 0 set water depth to 10
    waterHeight =25;
  } else if (waterState_ == 1) { //if state is 1 set water depth to 75
    waterHeight=75;
  } else {
    waterHeight = riseWater();
  } //end else


  rectMode(CORNERS);
  noStroke();
  fill(colorScheme[4]);
  rect(30, (height-waterHeight), width-30, height); //water mass
  fill(colorScheme[5]);
  quad(30, height-waterHeight, 55, height-(waterHeight+15), width-55, height-(waterHeight+15), width-30, height-waterHeight); //top surface of water
  return waterHeight;
}

public int riseWater() {
  int waterHeight = 75+b;
  //println(waterHeight);
  if (b < height) {
  b+=5;
  }
  return waterHeight;
}
  public void settings() {  size(500, 650); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "pie_chaser" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
