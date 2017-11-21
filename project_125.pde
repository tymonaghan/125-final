//A vertical-scrolling action game.
boolean giveInstructions = true;
Platform[] plats = new Platform[100]; //create array of 100 Platforms
Character playerCharacter;
int jumping = 100;
StringList texts;


void setup() {
  size(500,650);
  texts = new StringList();
  
//  for(int p = 0; p < plats.length; p++) {
//  plats[p] = new Platform(int(random(55,105)),1%5);
 //   } //end for loop to create array of Platforms
  playerCharacter = new Character(200,200,1,color(255,255,54),5); //construct player character

} //end setup

void draw() {
  //loadScreen();
  buildTexts();
  drawBackground();
  menuLogic(giveInstructions);
  if (!giveInstructions) {
    movePlatforms();
    drawWater();
    playerCharacter.spawn();
    playerCharacter.controls();
    }
  } //end if
    