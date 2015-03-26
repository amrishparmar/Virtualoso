class Drum {
  PVector position;
  int width;
  int height;
  AudioPlayer sound;

  Drum(int x, int y, int newWidth, int newHeight, char newIdent, String path) {
    position = new PVector(x, y);
    width = newWidth;
    height = newHeight;
    sound = minim.loadFile(path);
  }

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

  void checkColl(ColourTracker tracker) {
    //Sees if the lines intersect
    if (lineIntersection(tracker)) {
      //if they do then grab the veloctiy (for amplitude)
      float velocity = tracker.position.dist(tracker.erstwhilePosition);
      //And play the sound
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
    float x4 = this.position.x + width;
    float y4 = this.position.y;
    float denominator = (((x1-x2)*(y3-y4))-((y1-y2)*(x3-x4)));

    //First check to see if the lines are parallel or coincident as the calc will break if they are
    if (denominator != 0) { 
      float interX = ((x1*y2-y1*x2)*(x3-x4)-(x1-x2)*(x3*y4-y3*x4))/denominator;
      float interY =  ((x1-y1*x2)*(y3-y4)-(y1-y2)*(x3*y4-y3*x4))/denominator;

      //We know where the lines intersect so we now need to check to see if that point is on the line.
      //Logic taken from http://stackoverflow.com/questions/17692922/check-is-a-point-x-y-is-between-two-points-drawn-on-a-straight-line

      //This is the point where the two lines meet
      PVector intersection = new PVector(interX, interY);
      //This is a vector for the end of the object
      PVector endOfLine = new PVector(position.x+width, position.y);

      //If the point is both on the line of the object and the tracker we have a drum hit.
      if ((tracker.position.dist(intersection)+(tracker.erstwhilePosition.dist(intersection)) == tracker.position.dist(tracker.erstwhilePosition)) && ((this.position.dist(intersection)+(endOfLine.dist(intersection)) == this.position.dist(endOfLine)))) {
        //So return true
        return true;
      }
    }
    //No coll so return false
    return false;
  }
}

