class Drum {
  PVector position;
  int width;
  int height;
  char ident;

  Drum(int x, int y, int newWidth, int newHeight, char newIdent) {
    position = new PVector(x, y);
    width = newWidth;
    height = newHeight;
    ident = newIdent;
  }

  void drawDrum() {
    fill(128);
    rect(position.x, position.y, width, height);
  }

  void checkColl(ColourTracker tracker) {
    if (tracker.position.x > position.x && tracker.position.x < position.x+width && tracker.position.y > position.y && tracker.position.y 
      < position.y+height) {
      float velocity = tracker.position.dist(tracker.erstwhilePosition);
      println("Drum Hit " + ident  + velocity);
    }
  }
}

