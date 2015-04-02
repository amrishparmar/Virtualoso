class DrumKit {
  Drum[] drums;
  Cymbal[] cymbals;
  
  // constructor
  DrumKit() {
    drums = new Drum[4];
    cymbals = new Cymbal[3];
    drums[0] = new Drum(100, 380, 100, 50, 'a', "data/Snare.wav");
    drums[1] = new Drum(205, 380, 100, 50, 'b', "data/Tom.wav");
    drums[2] = new Drum(335, 380, 100, 50, 'c', "data/Tom.wav");
    drums[3] = new Drum(440, 380, 100, 50, 'd', "data/FloorTom.wav");
    cymbals[0] = new Cymbal( 10, 300, 80, 15, 'a', "data/HiHat.wav");
    cymbals[1] = new Cymbal( 280, 300, 80, 15, 'b', "data/Ride.wav");
    cymbals[2] = new Cymbal( 530, 300, 80, 15, 'c', "data/Crash.wav");
  }
  
  // draws the the drum kit to the screen
  void drawKit() {
    for (int i = 0; i < drums.length; i++) {
      drums[i].drawDrum();
    }
    for (int j = 0; j < cymbals.length; j++) {
      cymbals[j].drawCymbal();
    }
  }
  
  // checks for collision with "drum stick" 
  void checkForHit(ColourTracker tracker) {
    for (int i = 0; i < drums.length; i++) {
      drums[i].checkColl(tracker);
    }
    for (int j = 0; j < cymbals.length; j++) {
      cymbals[j].checkColl (tracker);
    }
  }
}

