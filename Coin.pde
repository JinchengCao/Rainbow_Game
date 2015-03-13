class Coin{
  int xpos; 
  int ypos;
  int speed;
  color c;
  
  Coin(int tempXpos, int tempYpos){
    xpos = tempXpos;
    ypos = tempYpos;
    speed = 2;
    c = color(255, 255, 0);
  }
  
  void display(){
    stroke(0);
    fill(c);
    ellipse(xpos+25, ypos, 30, 15);
  }
  
  void advance(){
    ypos += speed;
  }
  
  void caught() {
    // If coin in pot, stop it and get it out of display
    speed = 0; 
    ypos = -100000;
  }
}
