class Cymbal {
  PVector position;
  int width;
  int height;
  char ident;

  Cymbal(int x, int y, int newWidth, int newHeight, char newIdent) {
    position = new PVector(x, y);
    width = newWidth;
    height = newHeight;
    ident = newIdent;
  }

  void drawCymbal() {
    fill(255, 255, 0);
    rect(position.x, position.y, width, height);
  }

  void checkColl(ColourTracker tracker) {
    if (tracker.position.x > position.x && tracker.position.x < position.x+this.width && tracker.position.y > position.y && tracker.position.y < position.y+height) {
      float velocity = tracker.position.dist(tracker.erstwhilePosition);
      println("Cymbal Hit "  + ident + velocity);
    }
  }
}

