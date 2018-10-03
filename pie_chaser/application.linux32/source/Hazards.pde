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

  void display () {
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

  void collisionCheck () {
  }

  int getHazardX() {
    return xPos;
  } //end getItemX

  int getHazardY() {
    return yPos;
  } //end getItemY
  
  int getHazXSize(){
    return xSize;
  }// end getHazXSize
  
  int getHazYSize(){
    return ySize;
  }//end getHazYSize
  
  int getHazType() {
    return shape;
  } //end getHazType
} //end hazard class
