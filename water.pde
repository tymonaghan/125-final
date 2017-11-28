int drawWater(int waterState_) { //waterState 0 = puddle, game start.  waterState 1 = gameplay, 75. waterState 2 = rising, fail condition
  int waterHeight = 75;
  if (waterState==0) { //if state is 0 set water depth to 10
    waterHeight =10;
  } else if (waterState == 1) { //if state is 1 set water depth to 75
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

int riseWater() {
  int waterHeight = 75+b;
  //println(waterHeight);
  if (b < height) {
  b+=5;
  } else {
    failMenu();
  }
  return waterHeight;
}