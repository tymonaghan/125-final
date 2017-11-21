class Platform{
  //declare class variables:
  int size, xpos, ypos;
  color pcolor;
  boolean special;
  
  //platform constructor:
  Platform(int xpos_, int special_){
    xpos = xpos_;
    if (special_==1){
      special = true;
      pcolor = color(255,150,200);
    } else {
      special = false;
      pcolor = color(125,150,200);
    }
  } //end constructor

void display() { //function to draw platforms
  strokeWeight(3);
  rectMode(CORNER);
  fill(pcolor);
  rect(xpos,ypos,size,35);
}

void setColor(int r) {
  pcolor = color(r,150,200);
}
}//end platform classx