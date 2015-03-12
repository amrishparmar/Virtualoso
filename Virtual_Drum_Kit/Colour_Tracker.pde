class ColourTracker {
  color trackingColour; 
  PVector position;
  PVector erstwhilePosition;
  char updateKey;

  ColourTracker(char key) {
    setTracker();
    updateKey = key;
  }

  void updatePosition() {
    // Before we begin searching, the "world record" for closest color is set to a high number that is easy for the first pixel to beat.
    float worldRecord = 500; 

    // XY coordinate of closest color
    int closestX = 0;
    int closestY = 0;

    // Begin loop to walk through every pixel
    for (int x = 0; x < cam.width; x ++ ) {
      for (int y = 0; y < cam.height; y ++ ) {
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

        // If current color is more similar to tracked color than
        // closest color, save current location and current difference
        if (d < worldRecord) {
          worldRecord = d;
          closestX = x;
          closestY = y;
        }
      }
    }
    if (worldRecord < 10) {
      erstwhilePosition = position;
      position = new PVector(width-closestX, closestY);
    }
  }

  void displayTracker() {
    fill(trackingColour);
    ellipse(position.x, position.y, 5, 5);
  }

  void setTracker() {
    int loc = (width-mouseX) + mouseY*(cam.width);
    trackingColour = cam.pixels[loc];
    position = new PVector(mouseX, mouseY);
  }
}

