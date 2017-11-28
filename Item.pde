class Item {
  //declare class variables:
  int size, xpos, ypos;
  color iColor;
  boolean special;
  PImage pie;
  PImage pizza;

  //platform constructor:
  Item(int xpos_, int special_) {
    ypos=-(int(random(300)));
    xpos = xpos_;
    if (special_==1) {
          pie = loadImage("pizza.png");

      special = true;
      iColor = color(255, 150, 200);
      size = 50;
    } else {
      pie = loadImage("pie.png");
      special = false;
      iColor = color(125, 150, 200);
      size=100;
    }
  } //end constructor

  void display() { //function to draw platforms
    image(pie,xpos,ypos);
    ypos+=gameSpeed; //speed at which items will fall (gameSpeed)
  }
  
  void display(int special_) {
    image (pizza,xpos,ypos);
    ypos+=gameSpeed; 
  }

  void setColor(int r) {
    iColor = color(r, 150, 200);
  }
  
  int getItemX(){
    return xpos;
  } //end getItemX
  
  int getItemY(){
    return ypos;
  } //end getItemY

}//end item classx