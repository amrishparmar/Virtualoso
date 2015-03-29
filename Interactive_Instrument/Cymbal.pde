class Cymbal extends AttackSurface {
  
  // constructor
  Cymbal(int x, int y, int newWidth, int newHeight, char newIdent, String path) {
    position = new PVector(x, y);
    width = newWidth;
    height = newHeight;
    sound = minim.loadFile(path);
  }
  
  // draw the cymbal to the screen
  void drawCymbal() {
    fill(255, 255, 0);
    rectMode(CORNER);
    strokeWeight(3);
    stroke(128);
    line(position.x+(width/2), position.y+5, position.x+(width/2), 480);
    strokeWeight(1);
    stroke(0);
    ellipse(position.x, position.y, width, height);
  }
}

