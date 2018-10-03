void movingBackground(int moveRate_) {
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

void drawStaticBackgroundElements() {
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
