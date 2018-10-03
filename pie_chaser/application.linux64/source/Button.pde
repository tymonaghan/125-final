class Button {
  int xSize, ySize, xPos, yPos, stringNum, buttonFunction;
  color bColor, tColor;

  Button(int xPos_, int yPos_, int xSize_, int ySize_) {
    xSize = xSize_;
    ySize = ySize_;
    xPos = xPos_;
    yPos = yPos_;
    tColor = 0;
    //bColor = bColor_;
    //stringNum = stringNum_;
  } // end Button constructor

  void display(color bColor_, color tColor_, int nummer_) {
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

  void clickCheck(int mX_, int mY_, int buttonFunction_) {
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
