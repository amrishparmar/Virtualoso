class Drum {
  PVector position;
  int width;
  int height;
  char ident;
  AudioPlayer sound;

  Drum(int x, int y, int newWidth, int newHeight, char newIdent, String path) {
    position = new PVector(x, y);
    width = newWidth;
    height = newHeight;
    ident = newIdent;
    sound = minim.loadFile(path);
  }

  void drawDrum() {
    fill(128);
    rect(position.x, position.y, width, height);
  }

  void checkColl(ColourTracker tracker) {
    if (tracker.position.x > position.x && tracker.position.x < position.x+width && tracker.position.y > position.y && tracker.position.y < position.y+height) {
      if ((tracker.erstwhilePosition.x > position.x && tracker.erstwhilePosition.x < position.x+this.width && tracker.erstwhilePosition.y > position.y && tracker.erstwhilePosition.y < position.y+height) == false) {
        float velocity = tracker.position.dist(tracker.erstwhilePosition);
        sound.play(0);
        println("Drum Hit " + ident  + velocity);
      }
    }
  }
}

