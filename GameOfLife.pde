import de.bezier.guido.*;
int NUM_ROWS = 20;
int NUM_COLS = 20;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = false; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  Interactive.make( this );
  buttons = new Life[NUM_ROWS][NUM_COLS];
  buffer = new boolean[NUM_ROWS][NUM_COLS]; 
  for (int row = 0; row < NUM_ROWS; row++)
    for (int col = 0; col < NUM_COLS; col++)
      buttons[row][col] = new Life(row, col);
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();
  for (int row = 0; row < NUM_ROWS; row++) {
    for (int col = 0; col < NUM_COLS; col++) {
      if (countNeighbors(row, col)==3) {
        buffer[row][col] = true;
      } else if (countNeighbors(row, col)==1 && buttons[row][col].getLife()) {
        buffer[row][col] = true;
      } else {
        buffer[row][col] = false;
      }
    }
    copyFromBufferToButtons();
  }
}
public void keyPressed() {
  running =!running;
}

public void copyFromBufferToButtons() {
  for (int row = 0; row < NUM_ROWS; row++)
    for (int col=0; col< NUM_COLS; col++)
      buttons[row][col].setLife(buffer[row][col]);
}

public void copyFromButtonsToBuffer() {
  for (int row = 0; row < NUM_ROWS; row++)
    for (int col=0; col< NUM_COLS; col++)
      buffer[row][col]=buttons[row][col].getLife();
}

public boolean isValid(int r, int c) {
  if (r<20 && r>=0 && c<20 && c>=0) {
    return true;
  } else {
    return false;
  }
}

public int countNeighbors(int r, int c) {
  int neighbors = 0;
  if (isValid(r-1, c-1)&& buttons[r-1][c-1].getLife()) {
    neighbors ++;
  }
  if (isValid(r-1, c)&&buttons[r-1][c].getLife()) {
    neighbors ++;
  }
  if (isValid(r-1, c+1)&&buttons[r-1][c+1].getLife()) {
    neighbors ++;
  }
  if (isValid(r, c+1)&&buttons[r][c+1].getLife()) {
    neighbors ++;
  }
  if (isValid(r+1, c+1)&&buttons[r+1][c+1].getLife()) {
    neighbors ++;
  }
  if (isValid(r+1, c)&&buttons[r+1][c].getLife()) {
    neighbors ++;
  }
  if (isValid(r+1, c-1)&&buttons[r+1][c-1].getLife()) {
    neighbors ++;
  }
  if (isValid(r, c-1)&&buttons[r][c-1].getLife()) {
    neighbors ++;
  }
  return neighbors;
}
