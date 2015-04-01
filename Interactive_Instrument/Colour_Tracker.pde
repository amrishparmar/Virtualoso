class ColourTracker {
  
  color trackingColour; 
  PVector position;
  PVector erstwhilePosition;
  char updateKey;
  boolean setUp;

  ColourTracker(char key) {
    setTracker();
    updateKey = key;
    setUp = false;
  }
  
  void track() {
    //We only display when things are setup
    if (setUp) {
      //First we update the position
      updatePosition();
      //Then we display a dot at that location 
      displayTracker();
    }
  }

  void updatePosition() {
    //This was initally based on a simple colour tracker created by Daniel Shiffman (http://www.learningprocessing.com/examples/chapter-16/example-16-11/)
    //But since then it has been heavily modified to create a smoother tracker (by averaging the location) 
    
    //This tracks all of the 'hits' we have and starts off blank every frame
    ArrayList<PVector> currentPositions = new ArrayList<PVector>();
    // Loop through every pixel
    for (int x = 0; x < cam.width; x++ ) {
      for (int y = 0; y < cam.height; y++ ) {
        int loc = x + y*cam.width;
        //Get the current colour
        color currentColour = cam.pixels[loc];
        ///break it and the tracker colour into rgb vals
        float r1 = red(currentColour);
        float g1 = green(currentColour);
        float b1 = blue(currentColour);
        float r2 = red(trackingColour);
        float g2 = green(trackingColour);
        float b2 = blue(trackingColour);

        // Using euclidean distance to compare colors (from Shiffman's implmentation)
        float d = dist(r1, g1, b1, r2, g2, b2); 

        //if it is less than 15 away from what we want we have a hit
        if (d < 15) {
          //So create a vector to the location
          PVector location = new PVector(width-x, y);
          //And store in the current positions
          currentPositions.add(location);
        }
      }
    }
    //Once we have vectors to all of the locations were we have a hit we can average them
    //Start with an empty vect
    PVector centre = new PVector(0, 0);
    for (int i = 0; i < currentPositions.size (); i++) {
      //Add all of the hits to it
      centre.add(currentPositions.get(i));
    }
    //And divide by the number of hits
    centre.mult(1.0f/currentPositions.size());
    //The old position is now the position
    erstwhilePosition = position;
    
    //And the position is this new centre vector
    position = centre;
  }

  // draw the tracker to screen as an ellipse
  void displayTracker() {
    //We fill the ellipse with the tracking colour
    fill(trackingColour);
    //And draw it at the location
    ellipse(position.x, position.y, 5, 5);
  }

  // set up the colour tracker
  void setTracker() {
    int loc = (width-mouseX) + mouseY*(cam.width);
    trackingColour = cam.pixels[loc];
    position = new PVector(mouseX, mouseY);
    setUp = true;
  }
}

