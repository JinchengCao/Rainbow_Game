class Path{
  color c;
  int xpos;
  int keyValue;
  
  Path(color tempC, int tempXpos, int tempKeyValue){
    c = tempC;
    xpos = tempXpos;
    keyValue = tempKeyValue;
  }
  
  void display(){
    noStroke();
    fill(c);
    rect(xpos, 0, 50, height);
  }
  
  void flash(){
    noStroke();
    fill(0);
    rect(xpos, 0, 50, height);
  }
  
  boolean inRectangle(Coin b){
    if (height - 60 < b.ypos && b.ypos < height - 20){
      return true;
    }
    else {
      return false;
    }
  }
}
