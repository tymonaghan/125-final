class Character { //begin Character class
  boolean drowned = false;
  int xPos, yPos, size, wetness, itemX, itemY, base;
  color charColor;
  float speed;
  PImage avatar;

  Character(int xPos_, int yPos_, int size_, color charColor_, float speed_) { //constructor
    xPos = constrain(xPos_, 55, width-55);
    yPos = yPos_;
    size = size_;
    charColor = charColor_;
    speed = speed_;
    avatar = loadImage("Untitled.png");
  }

  void spawn () { //function to draw Character
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
  void controls() {
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

  void setSpeedBoost(int boost_) {
    if (boost_ == 0) {
      speed = playerSpeed;
    } else if (boost_ == 20) {
      speed = 0;
    } else {
      speed = speed+boost_;
    } //end if
  } //end setSpeedBoost

  void checkWater() {
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

  boolean checkDead() {
    if (yPos>height || drowned == true) {
      waterState=2;
    } //end if
    return drowned;
  }//end checkDead

  void itemPickupCheck(int itemX_, int itemY_) {
    int itemX = itemX_;
    int itemY = itemY_;
    if (xPos > itemX-generosity && xPos < itemX+generosity && yPos > itemY -generosity && yPos < itemY +generosity) {
      playerCharacter.setSpeedBoost(3);
      //insert a function to check whether pizza or pie and decide speed boost accordingly
      println("SPEEDBOOST");
      playerBonus+=10;
    }//end if
  }//end itemPickupCheck

  void reset()
  {
    xPos = constrain(xCenter, 55, width-55);
    yPos = yCenter;
    drowned = false;
    wetness = 0;
  }

  void hazardCheck(int hazardX_, int hazardY_, int xSize_, int ySize_, int hazType_) {
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

  void speedNormalizer(int base_) {
    base = base_;
    if ((p-base)>1) {
      println("COOLDOWN");
      setSpeedBoost(0);
    } //end if
  }//end speedNormalizer
}//end Character class