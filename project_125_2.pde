//A vertical-scrolling action game.

//THESE VARIABLES SHOULD NOT BE ALTERED:
boolean giveInstructions = true; //a first-run variable to display the game instructions.
boolean gamePaused = false;
Character playerCharacter;
StringList texts;
int waterState= 0; //sets the water level
int gameFrameCount = 0; // tracks how many frames of gameplay have been played
int hitsTaken = 0; //counts how many times the player has been hit
int a, b, xyz, score, mX, mY = 0; //various counters
int h,p = 2;
int xCenter = 250; //use in place of width/2
int yCenter = 325; //use in place of height/2
Button resumeButton, exitButton, restartButton, instructionsButton;
color[] colorScheme = new color[16];

//THESE VARIABLES CAN BE ALTERED TO CHANGE GAMEPLAY (later encoded into menu):
int playerLives = 3; //change the number of lives (hearts) for the player to start with
Item[] items = new Item[10]; //create array of 100 Items - change number to change game length / win condition
Hazard[] hazards = new Hazard[10]; //create array of Hazards, change number to change number of hazards on course.
int playerSpeed = 6;
int gameSpeed = 4;
int fallSpeed = 3;
int generousity = 25; //how easy it is to pick up items (higher numbers are easier)
int coolDown = 50; //how long item effects last. higher numbers last longer.
int lungCapacity = 50; //how long you can remain underwater before losing a life.
int hazardValue = 25;
// 000000000000000000000000000000000000000000000000000000--END DECLARE VARIABLES, BEGIN SETUP--0000000000000000000000000000000000000000000000000000000000000000000000000000000000

void setup() {  
  size(500, 650);
  texts = new StringList(); //compile the "texts" stringList
  setupFunctions(); //moved most setup functions to their own method
} //end setup
//0000000000000000000000000000000000000000000000000000000-END SETUP---BEGIN DRAW--00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
void draw() {
  //loadScreen(); //possibly add the animated load screen later
  boolean drowned = playerCharacter.checkDead(); // i want this to constantly refresh, so i think it belongs in draw().
  
  //functions:
  drawStaticBackgroundElements(); //draw the non-moving background elements.
  drawBackground(!giveInstructions); //call the drawBackground block that controls whether the background moves or not.
  menuLogic(giveInstructions); //determines whether the instructions screen should load

  if (!giveInstructions && !gamePaused) { //if instructions are not being given and the game is not paused...
    int gameFrameCount = frameCounter(); //run the frameCounter and store in "gameFrameCount" variable
    drawWater(waterState); //draw the water according to waterState. Keep this in main gameplay loop because water will be underneath in menus, paused, etc.
    playerFunctions(); //calls a batch of player functions. keep in main gameplay loop.
    waterState = 1; //i think this is fine in the main gameplay loop.
    //println (); //debug
    items[p].display(); //display the items in array space "p"
    items[p-1].display();
    hazards[h].display();
    scoreBoard(gameFrameCount/5, playerLives);
      xyz+=gameSpeed; //THIS IS THE RATE AT WHICH THE BACKGROUND WILL MOVE!!! SHOULD BE EQUAL TO PLATFORM SPEED.
    if (gameFrameCount%90==0 && p < items.length) {
      p++;
    }//end if
    if (gameFrameCount%100==0 && p <items.length) {
      h++;
    }//end if 
    if (p == items.length){
      winScreen();
    }//end if
  } //end if !giveInstructions

  if (drowned == true) {
    waterState =2;
    hitsTaken++;
    changeScore(-100);
    gamePaused=true;
  } //if drowned


} //end draw