class Cymbal {
  PVector position;
  int width;
  int height;
  char ident;
  AudioPlayer sound;

  Cymbal(int x, int y, int newWidth, int newHeight, char newIdent, String path) {
    position = new PVector(x, y);
    width = newWidth;
    height = newHeight;
    ident = newIdent;
    sound = minim.loadFile(path);
  }

  void drawCymbal() {
    fill(255, 255, 0);
    rect(position.x, position.y, width, height);
  }

  void checkColl(ColourTracker tracker) {
    if (lineIntersection(tracker)) {
      float velocity = tracker.position.dist(tracker.erstwhilePosition);
      println(ident);
      sound.play(0);
    }
  }

  boolean lineIntersection(ColourTracker tracker) {
    //Maths taken from http://en.wikipedia.org/wiki/Line%E2%80%93line_intersection

    //Storing our vals in locals to make it easier to read
    float x1 = tracker.position.x;
    float y1 = tracker.position.y;
    float x2 = tracker.erstwhilePosition.x;
    float y2 = tracker.erstwhilePosition.y;

    float x3 = this.position.x;
    float y3 = this.position.y;
    float x4 = this.position.x + this.width;
    float y4 = this.position.y;
    float denominator = (((x1-x2)*(y3-y4))-((y1-y2)*(x3-x4)));

    //First check to see if the lines are parallel or coincident as the calc will break if they are
    if (denominator != 0) {
      float interX = ((x1*y2-y1*x2)*(x3-x4)-(x1-x2)*(x3*y4-y3*x4))/denominator;
      float interY =  ((x1-y1*x2)*(y3-y4)-(y1-y2)*(x3*y4-y3*x4))/denominator;

      //We know where the lines intersect so we now need to check to see if that point is on the line.
      //Logic taken from http://stackoverflow.com/questions/17692922/check-is-a-point-x-y-is-between-two-points-drawn-on-a-straight-line

      PVector intersection = new PVector(interX, interY);
      PVector endOfLine = new PVector(position.x+width, position.y);

      if ((tracker.position.dist(intersection)+(tracker.erstwhilePosition.dist(intersection)) == tracker.position.dist(tracker.erstwhilePosition)) && ((this.position.dist(intersection)+(endOfLine.dist(intersection)) == this.position.dist(endOfLine)))) {
        println("XY1 = " + x1 + " " + y1 + " XY2 = " + x2 + " " + y2 + "XY3 = " + x3 + " " + y3 + " XY4 = " + x4 + " " + y4 + " Point = " + interX + " "  + interY);
        return true;
      }
    }
    return false;
  }
}
