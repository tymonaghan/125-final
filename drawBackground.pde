void drawBackground() {
  rectMode(CORNER);
  strokeWeight(4);
  stroke(50);
  
  fill(175,164,95);//brick-brown color
  rect(0,0,width,height);
  
  fill(159,211,92); //olive green color
  rect(0,0,30,height); //draw left wall
  rect(width-30,0,30,height); //draw right wall

  strokeWeight(3);
  fill(150,135,70);
  quad(30,height,  55,height-35,  width-55,height-35, width-30,height); //draw quad for floor
  strokeWeight(2);
  line(55,height-35, 55,0);
  line(width-55,height-35, width-55,0);
  
  for(int b=height-50; b>=0 ; b-=30) { // b for bricks height, BtoT
    strokeWeight(1);
    line(55,b,width-55,b); //horzontal lines on back wall
    line(30,b+25, 55,b);
    line(width-30,b+25, width-55,b);
    
    for (int bb = 55; bb < width-55; bb+=50){ //bb moves LtoR
      for(int x = height-50; x > 0; x-=60){
        line(bb,x,bb,x-30);
      }
      for(int xx = height-80; xx > 0; xx-=60){
        line(bb+25,xx,bb+25,xx-30);
      }
    }
    
  } //end for loop
}//end drawBackground