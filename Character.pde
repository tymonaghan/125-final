class Character{ //begin Character class
int xPos,yPos,size;
color charColor;
float speed;
PImage avatar;

Character(int xPos_, int yPos_, int size_, color charColor_, float speed_) { //constructor
  xPos = xPos_;
  yPos = yPos_;
  size = size_;
  charColor = charColor_;
  speed = speed_;
  avatar = loadImage("Untitled.png");
}

void spawn () { //function to draw Character
  image(avatar,xPos,yPos);
  //rectMode(CENTER);
  //strokeWeight(1);
  //stroke(0);
  //fill(charColor);
  //ellipse(xPos,yPos,100,100);
  //shoes:
  //fill(15);
  }//end spawn function

//function to control the player character
void controls() {
  if(keyPressed == true && key == CODED) {
    
    //controls for moving LEFT:
    if(keyCode == LEFT) { 
      xPos-=speed;
    } // end if LEFT
    
    //controls for moving RIGHT
    else if(keyCode == RIGHT) { 
      xPos+=speed;
    } // end if RIGHT
    
    else if (keyCode == UP) {
      playerCharacter.jump();
      playerCharacter.descend();
    }
    
  } //end if keypressed and coded
}//end controls function



void jump() {
  //int gravity = 1;
  //for (int t = 10; t > 0; t--){
  yPos-=25;
  //} // end for loop
}//end jump function
  
void descend() {
  //for (int t = 10; t > 0; t--) {
    yPos+=20;
  //} // end for loop
} //end descend function
}//end Character class