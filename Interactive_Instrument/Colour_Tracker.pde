class ColourTracker {
  color trackingColour; 
  PVector position;
  PVector erstwhilePosition;
  char updateKey;
  boolean setUp;
  ArrayList<PVector> currentPositions;

  ColourTracker(char key) {
    setTracker();
    updateKey = key;
    setUp = false;
  }

  void track() {
    if (setUp) {
      updatePosition();
      displayTracker();
    }
  }

  void updatePosition() {
    currentPositions = new ArrayList<PVector>();
    // Begin loop to walk through every pixel
    for (int x = 0; x < cam.width; x++ ) {
      for (int y = 0; y < cam.height; y++ ) {
        int loc = x + y*cam.width;
        // What is current color
        color currentColor = cam.pixels[loc];
        float r1 = red(currentColor);
        float g1 = green(currentColor);
        float b1 = blue(currentColor);
        float r2 = red(trackingColour);
        float g2 = green(trackingColour);
        float b2 = blue(trackingColour);

        // Using euclidean distance to compare colors
        float d = dist(r1, g1, b1, r2, g2, b2); // We are using the dist( ) function
        // to compare the current color with the color we are tracking.

        if (d < 15) {
          PVector location = new PVector(width-x, y);
          currentPositions.add(location);
        }
      }
    }
    PVector centre = new PVector(0, 0);
    for (int i = 0; i < currentPositions.size (); i++) {
      centre.add(currentPositions.get(i));
    }
    centre.mult(1.0f/currentPositions.size());
    erstwhilePosition = position;
    position = centre;
  }


  void displayTracker() {
    fill(trackingColour);
    ellipse(position.x, position.y, 5, 5);
  }

  void setTracker() {
    int loc = (width-mouseX) + mouseY*(cam.width);
    trackingColour = cam.pixels[loc];
    position = new PVector(mouseX, mouseY);
    setUp = true;
  }
}

