//A vertical-scrolling action game.

//THESE VARIABLES SHOULD NOT BE ALTERED:
boolean giveInstructions = true; //a first-run variable to display the game instructions.
boolean gamePaused = false;
boolean firstRun = true;
Character playerCharacter;
StringList texts;
int waterState= 0; //sets the water level
int gameFrameCount = 0; // tracks how many frames of gameplay have been played
int a, b, xyz, score, mX, mY = 0; //various counters
int h=3;
int p = 3;
int xCenter = 250; //use in place of width/2
int yCenter = 325; //use in place of height/2
Button resumeButton, exitButton, restartButton, instructionsButton;
color[] colorScheme = new color[16];
int gameState;

//THESE VARIABLES CAN BE ALTERED TO CHANGE GAMEPLAY (later encoded into menu):
int playerLives = 3; //change the number of lives (hearts) for the player to start with
Item[] items = new Item[100]; //create array of 100 Items - change number to change game length / win condition
Hazard[] hazards = new Hazard[200]; //create array of Hazards, change number to change number of hazards on course.
int playerSpeed = 4;
int gameSpeed = 4;
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
  //functions:
  drawStaticBackgroundElements(); //draw the non-moving background elements.
  println("gameState:"+gameState);

  gameState = getGameState();
  if (gameState == 0 || gameState ==1 ) { //0=first run, give instructions /// 1=failsafe - behaves like state 0 /// 2=main gameplay loop /// 3= paused, user wants instructions /// 4=fail condition or pause.
    movingBackground(0);
    backgroundStillElements();
    
  } else if (gameState == 2) {
    movingBackground(xyz%60); //this resets the background loop every time it gets to brick height
    drawWater(waterState); //draw the water according to waterState. Keep this in main gameplay loop because water will be underneath in menus, paused, etc.
    boolean drowned = playerCharacter.checkDead();
    if (!drowned) {

      int gameFrameCount = frameCounter(); //run the frameCounter and store in "gameFrameCount" variable

      playerFunctions(); //calls a batch of player functions. keep in main gameplay loop.
      waterState = 1; //i think this is fine in the main gameplay loop.
      //println (); //debug
      objectSpawner();

      scoreBoard(gameFrameCount/5, playerLives);
      xyz+=gameSpeed; //THIS IS THE RATE AT WHICH THE BACKGROUND WILL MOVE!!! SHOULD BE EQUAL TO PLATFORM SPEED.
      if (gameFrameCount%70==0 && p < items.length-4) {
        p++;
        playerCharacter.setSpeedBoost(0);
      }//end if
      if (gameFrameCount%50==0 && p <items.length-4) {
        h++;
      }//end if
    } //end if not drowned

    if (drowned == true) {
      if (playerLives>0) {
        hurtHelperMenu();
        gameState=3;
      } else {
        gameState = 4;
      }
    } // if drowned
  } else if (gameState ==3) { //drowned but still have lives remaining
  } else if (gameState ==4) {
  }

  menuLogic(giveInstructions); //determines whether the instructions screen should load

  if (!giveInstructions && !gamePaused) { //if instructions are not being given and the game is not paused...

    if (p == items.length) {
      winScreen();
      gamePaused = true;
    }//end if
  } //end if !giveInstructions END MAIN GAMEPLAY LOOP
  //else if (!giveInstructions && gamePaused) {
    //drawWater(waterState);
  //}

  /*if (drowned == true) {
   waterState =2;
   text("YOU LOSE", xCenter, yCenter);
   //xyz-=100;
   gamePaused=true;
   } //if drowned*/
} //end draw