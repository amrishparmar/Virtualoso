class Drum extends AttackSurface {
  
  // constructor
  Drum(int x, int y, int newWidth, int newHeight, char newIdent, String path) {
    position = new PVector(x, y);
    width = newWidth;
    height = newHeight;
    sound = minim.loadFile(path);
  }
  
  // draw this drum to the screen
  void drawDrum() {
    fill(0);
    rectMode(CORNER);
    ellipseMode(CORNER);
    strokeWeight(3);
    stroke(128);
    line(position.x+(width/5), position.y+5, position.x+(width/5), 480);
    line(position.x+width-(width/5), position.y+5, position.x+width-(width/5), 480);
    strokeWeight(1);
    stroke(0);
    ellipse(position.x, position.y+height-8, width, 15);
    rect(position.x, position.y, width, height);
    fill(128);
    ellipse(position.x, position.y-8, width, 15);
  }
}

