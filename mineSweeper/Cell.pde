class Cell {
  int i;
  int j;
  int x;
  int y;
  int w;
  int neighbourCount;
  boolean mine;
  boolean revealed;
  
  Cell(int i_, int j_, int w_) {
    i = i_;
    j = j_;
    x = i * w_;
    y = j * w_;
    w = w_;
    neighbourCount = 0;
    
    mine = false;
    revealed = false;
  }
  
  void show() {
   noStroke();
   fill(220);
   rect(x, y, w, w);
   
   noStroke();
   fill(255);
   rect(x, y, 4, 29);
   noStroke();
   fill(255);
   rect(x, y, 29, 4);
   
   noStroke();
   fill(100);
   rect(x+28, y+2, 4, 28);
   noStroke();
   fill(100);
   rect(x+2, y+28, 28, 4);
   
   if(revealed) {
     if(mine) {
       fill(255,0,0);
       rect(x, y, w, w);
       
       fill(0);
       noStroke();
       ellipse(x + w -15, y + w -15, w-15, w-15);
     } else {
       fill(220);
       stroke(1);
       rect(x, y, w, w);
        textAlign(CENTER);
        if(neighbourCount >= 3){
          fill(255,0,0);
          text(neighbourCount, x + w -15, y + w - 7);
        }
        else if(neighbourCount == 2){
          fill(34,139,34);
          text(neighbourCount, x + w -15, y + w - 7);
        }
        else if(neighbourCount == 1){
          fill(0,0,255);
          text(neighbourCount, x + w -15, y + w - 7);
       }
     }
   }
 }
  
  void mineCounter() {
   if(mine) {
     neighbourCount = -1;
   }
   
   int totalMines = 0;
   for (int xoff = -1; xoff <= 1; xoff++) {
     int cellX = i + xoff;
     if (cellX < 0 || cellX >= cols) continue;
  
     for (int yoff = -1; yoff <= 1; yoff++) {
       int cellY = j + yoff;
       if (cellY < 0 || cellY >= rows) continue;
       
       Cell neighbour = grid[cellX][cellY];
        if (neighbour.mine) {
          totalMines++;
        }
      }
    }
    neighbourCount = totalMines;
  }
  
  boolean mouseOverCell(int x_, int y_) {
    return (x_ > x && x_ < x + w && y_ > y && y_ < y + w);
  }
  
  void reveal() {
   revealed = true;
   if(neighbourCount == 0) {
     floodFill();
   }
  }
  
  void floodFill() {
    for (int xoff = -1; xoff <= 1; xoff++) {
     int celli = i + xoff;
     if (celli < 0 || celli >= cols) continue;
  
     for (int yoff = -1; yoff <= 1; yoff++) {
       int cellj = j + yoff;
       if (cellj < 0 || cellj >= rows) continue;
       
       Cell neighbour = grid[celli][cellj];
       
       if(!neighbour.revealed) {
         neighbour.reveal();
       }
     }
    }
  }
}
