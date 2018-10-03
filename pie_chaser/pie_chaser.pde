//PIE CHASER.
//A vertical-scrolling action game.

//THESE VARIABLES SHOULD NOT BE ALTERED:
//SoundFile intro;
Character playerCharacter;
StringList texts;
int waterState=0, gameFrameCount=0, a=0, b=0, xyz=0, score=0, alwaysRunning = 0, playerBonus = 0, h=3, p=3; //various counters
int xCenter = 250, yCenter = 325; //use in place of width/2 or height/2 -- will break if canvas size is changed
Button resumeButton, exitButton, restartButton, instructionsButton; //menu button objects
color[] colorScheme = new color[16]; //array for color scheme to keep theme consistent
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

void setup() {  
  size(500, 650);
  texts = new StringList(); //compile the "texts" stringList
  setupFunctions(); //moved most setup functions to their own method
} //end setup

//0000000000000000000000000000000000000000000000000000000-END SETUP---BEGIN DRAW--00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
void draw() {
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

void drawMainMenu() {
  //intro.play();
  movingBackground(0);
  backgroundStillElements();
  showInstructions();
  if ( keyPressed == true && key == CODED && keyCode == UP) { //press UP to start playing
    currentGameState = EGameState.InGame;
  }
}

void drawInGame() { //main gameplay loop
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

void drawPlayerDeadMenu() { // when player is dead but still has lives left.
  movingBackground(0);
  drawWater(2);
  hurtHelperMenu();
  if ( keyPressed == true && key == CODED && keyCode == LEFT ) { //resart with one fewer life by pressing LEFT arrow.
    currentGameState = EGameState.InGame;
    playerCharacter.reset();
  }
}

void drawGameOver() {
  failMenu();
}

void drawGameWon() {
  winScreen();
  pieSpinner(alwaysRunning/10);
}