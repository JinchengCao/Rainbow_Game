// Somewhere Over the Rainbow Game 
// - Created by Jincheng Cao and Martha Trevino

int score = 0;  //Starts score at 0
int lostCoins = 0;  //Starts lost coins at 0
int lives = 6;  //Sets number of lives
int numPaths = 4; //Number of paths, need to add the path in code...
Path path1;
Path path2;
Path path3;
Path path4;
Coin[][] coin;
boolean win = true;  
boolean start = false;  
PFont f;
PImage img;
PImage pot;
PImage potGold;

  
void setup(){
  size(800, 500);
  
  // Defines the paths that are going to be displayed.
  path1 = new Path(color(249, 255, 0), 200, 'g');
  path2 = new Path(color(0, 250, 0), 250, 'h');
  path3 = new Path(color(0, 206, 255), 300, 'j');
  path4 = new Path(color(163, 105, 255), 350, 'k');
  
  // Initialize the array of coins for each path
  // to an initial random y position.
  coin = new Coin[numPaths][100];
  for (int j = 0; j < numPaths; j++){
    for (int i = 0; i < 100; i++){
      coin[j][i] = new Coin(200 + 50*j, int(random(-1000-500*i,-500*i)));
    }
  }
  
  f = createFont("Arial", 40, true);
  
  img = loadImage("rainbow.png");
  potGold = loadImage("pot_of_gold.png");
  pot = loadImage("pot.png");
  drawStartPage();
}

void draw(){
  
  if (start){
    background(255);
    
    // Display the paths on the screen.
    path1.display();
    path2.display();
    path3.display();
    path4.display();
    
    // Display the score, available and lost lives.
    drawScore();
    drawLives(lives);
    drawLostCoins(lostCoins);
    
    // Loop to display all the coins and advance their position
    drawCoins();
    
    // Draw pot at the bottom of paths
    drawPot();
    
    // When win or lose draw "win/lose" screen
    drawWinLose();    
  }
}

void mouseClicked(){
  // Start game when clicked
  start = true;
  
  // If win or lose, restart when clicked
  if (!win || score == 50){
    reset();
  }
}

void reset(){
  // Reset variables to restart a game
  score = 0;
  lostCoins = 0;
  win = true;
  coin = new Coin[numPaths][100];
  for (int j = 0; j < numPaths; j++){
    for (int i = 0; i < 100; i++){
      coin[j][i] = new Coin(200 + 50*j, int(random(-1000-500*i,-500*i)));
    }
  }
  redraw();
}

void keyPressed(){
  // For each key (G, H, J, K) check if in pot
  // Flash the path if a coin is caught, add 1 to score
  for (int i = 0; i < 100; i++){
    if (key == path1.keyValue && path1.inRectangle(coin[0][i])){
      path1.flash();
      score += 1;
      coin[0][i].caught();
    }
    if (key == path2.keyValue && path2.inRectangle(coin[1][i])){
      path2.flash();
      score += 1;
      coin[1][i].caught();
    }
    if (key == path3.keyValue && path3.inRectangle(coin[2][i])){
      path3.flash();
      score += 1;
      coin[2][i].caught();
    }
    if (key == path4.keyValue && path4.inRectangle(coin[3][i])){
      path4.flash();
      score += 1;
      coin[3][i].caught();
    }    
  }
}

void drawStartPage(){
  // Displays initial screen with instructions for the game
  background(255);
  image(img, 0, 269);
  fill(0);
  textFont(f, 40);
  textAlign(CENTER, CENTER);
  text("Somewhere Over the Rainbow", width/2, height/7);
  textFont(f, 15);
  text("The purpose of this game is to catch as many falling coins as possible.\nWhen the coins reach the pot at the bottom,\npress 'G', 'H', 'J' or 'K' buttons on your keyboard.\n Each letter corresponds to a respective path, from left to right.\nCollect 50 coins to win. Good luck!", width/2, 175);
  text("Click anywhere to start.", width/2, height-50);
}

void drawCoins(){
  // Displays and advances each coin in the array of coins
  for (int j = 0; j < numPaths; j++){
    for (int i = 0; i < 100; i++){
      coin[j][i].display();
      coin[j][i].advance();
      if (coin[j][i].ypos > height){
        // If a coin gets out of the screen (didn't clicked it)
        // increment the number of lost coins (lost a life)
        lostCoins += 1;
        coin[j][i].ypos = -100000;
      }
      if (lostCoins >= lives){
        // Game Over if lost more coins than available lives
        win = false;
      }
    }
  }
}

void drawWinLose(){
  // Displays the appropriate screen for losing or winning the game
  if (!win){
    eraseCoins();
    
    fill(255, 0, 0);
    textFont(f, 50);
    text("Game Over!", 600, 250);
    fill(0);
    textFont(f, 20);
    text("Click anywhere to restart.", 600, 350);
  }
  if (win && score == 50){
    eraseCoins();
    
    fill(0);
    textFont(f, 60);
    image(potGold, width - 320, height - 500);
    text("You win!", 600, 250);
    fill(255);
    textFont(f, 15);
    text("Click anywhere to restart.", 585, 435);
  }
}

void drawLives(int lives){
  // Drawing the available lives (just the stroke of coin)
  for (int n = 1; n <= lives; n++){
    stroke(0);
    strokeWeight(3);
    fill(color(255, 255, 0));
    ellipse(450 + 40*n, 150, 30, 15);
  }
}

void drawLostCoins(int lostCoins){
  // Painting red the lost lives
  for (int n = 1; n <= lostCoins; n++){
    fill(255, 0, 0);
    ellipse(450 + 40*n, 150, 30, 15);
  }
}

void drawScore(){
  // Displays the score on the screen
  fill(0);
  textFont(f,40);
  text("Coins: " + score, 600, 50);
}

void drawPot(){
  // Draws the pot at the bottom of the paths
  image(pot, 175, height - 65);
}

void eraseCoins(){
  // Sets a position for all the coins outside the screen
  for (int j = 0; j < numPaths; j++){
    for (int i = 0; i < 100; i++){
      coin[j][i].ypos = -100000;
    }  
  }
}

