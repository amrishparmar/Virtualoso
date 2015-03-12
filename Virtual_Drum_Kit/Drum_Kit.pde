class DrumKit {
  Drum[] drums;
  Cymbal[] cymbals;

  DrumKit() {
    drums = new Drum[4];
    cymbals = new Cymbal[3];
    drums[0] = new Drum(100, 380, 100, 50, 'a');
    drums[1] = new Drum(205, 380, 100, 50, 'b');
    drums[2] = new Drum(335, 380, 100, 50, 'c');
    drums[3] = new Drum(440, 380, 100, 50, 'd');
    cymbals[0] = new Cymbal( 10, 300, 80, 20, 'a');
    cymbals[1] = new Cymbal( 280, 300, 80, 20, 'b');
    cymbals[2] = new Cymbal( 530, 300, 80, 20, 'c');
  }

  void drawKit() {
    for (int i = 0; i < drums.length; i++) {
      drums[i].drawDrum();
    }
    for (int j = 0; j < cymbals.length; j++) {
      cymbals[j].drawCymbal();
    }
  }
  
  void checkForHit(ColourTracker tracker){
        for (int i = 0; i < drums.length; i++) {
      drums[i].checkColl(tracker);
    }
    for (int j = 0; j < cymbals.length; j++) {
      cymbals[j].checkColl (tracker);
    }
  }
}

