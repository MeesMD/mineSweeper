Cell[][] grid;
int cols;
int rows;
int w = 30;
int minesTotal = 20;
boolean timerStart;

void setup() {
   size(450,500);
   cols = 15;
   rows = 15;
   grid = new Cell[cols][rows];
   for (int i = 0; i < cols; i++) {
     for (int j = 0; j < cols; j++) {
       grid[i][j] = new Cell(i, j, w);
     }
   }
  
  ArrayList<int[]> options = new ArrayList<int[]>();
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int[] option = new int[2];
      option[0] = i;
      option[1] = j;
      options.add(option);
    }
  }

  for (int n = 0; n < minesTotal; n++) {
    int index = floor(random(options.size()));
    int[] choice = options.get(index);
    int i = choice[0];
    int j = choice[1];

    options.remove(index);
    grid[i][j].mine = true;
  }
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].mineCounter();
    }
  }

}

void mousePressed() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid[i][j].mouseOverCell(mouseX, mouseY)) {
        grid[i][j].reveal();
        timerStart = true;
        
        if(grid[i][j].mine ) {
          gameOver();
        }
      }
    }
  }
}

void gameOver() {
   for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].revealed = true;
      timerStart = false;
    }
  }
}

void draw() {
  background(255);
  
  textSize(20); 
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].show();
    }
  }
}
