import ddf.minim.*;
import ddf.minim.ugens.*;

import processing.video.*;

Minim minim;

Capture cam;

Theremin theremin;
DrumKit drumkit;

ColourTracker frequency;
ColourTracker amplitude;
ColourTracker leftStick;
ColourTracker rightStick;

int state; // current state of program
int app; // current program we are in - theremin or drums  

// state constants
final int MAIN_MENU = 0;
final int TRACK_WIZARD = 1;
final int IN_PROGRAM = 2;

// app constants
final int THEREMIN = 0;
final int DRUMS = 1;

Button selectD;
Button selectT;

void setup() {
  size(640, 480);

  // instantiate minim audio library
  minim = new Minim(this);

  // get list of cameras
  String[] cameras = Capture.list();

  // quit program if there are no cameras available
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  }

  // begin capturing
  cam = new Capture(this, 640, 480, 30);
  cam.start();

  // create new colour trackers
  frequency = new ColourTracker('f'); // frequency
  amplitude = new ColourTracker('a'); // amplitude
  leftStick = new ColourTracker('l'); //Left drum stick
  rightStick = new ColourTracker('r'); //Right drum stick

  selectD = new Button(width/2, 225, 350, 75, "Play the drums");
  selectT = new Button(width/2, 350, 350, 75, "Play the theremin");
}

void stop() {
  // tell the audio to stop
  minim.stop();
  // call the version of stop defined in our parent class, in case it does anything vital
  super.stop();
}

void draw() {
  if (state == MAIN_MENU) {
    drawMenu();
  } else if (state > 0) { 
    // read data from camera and display on screen
    if (cam.available() == true) {
      cam.read();
    }
    drawCam();
    drawStats();

    // load pixels from camera - needed for colour tracker
    cam.loadPixels();

    if (app == THEREMIN) {
      // track colours
      frequency.track();
      amplitude.track();

      if (state == TRACK_WIZARD) {
        drawInstructionsT();
        if (amplitude.setUp && frequency.setUp) {
          state = IN_PROGRAM;
          theremin = new Theremin(); // instantiate the theremin
        }
      } else if (state == IN_PROGRAM) {
        // update the pitch and volume based on position of colour trackers
        theremin.updateSound(frequency, amplitude);
      }
    } else { // drums
      leftStick.track();
      rightStick.track();

      if (state == TRACK_WIZARD) {
        drawInstructionsD();
        if (leftStick.setUp && rightStick.setUp) {
          println("Set up complete");
          drumkit = new DrumKit();
          state = IN_PROGRAM;
        }
      } else if (state == IN_PROGRAM) {
        println("DRUMS");
        drumkit.drawKit();
        drumkit.checkForHit(leftStick);
        drumkit.checkForHit(rightStick);
      }
    }
  }
}



// set the colour trackers with a keypress
void keyPressed() {
  if (state > 0 && app == THEREMIN) {
    if (key == frequency.updateKey) {
      frequency.setTracker();
    } else if (key == amplitude.updateKey) {
      amplitude.setTracker();
    }
  } else if  (state > 0 && app == DRUMS) {
    if (key == leftStick.updateKey) {
      leftStick.setTracker();
    } else if (key == rightStick.updateKey) {
      rightStick.setTracker();
    }
  }
}

void mouseClicked() {
  if (state == MAIN_MENU) {
    if (selectT.clicked()) {
      app = THEREMIN;
      state = TRACK_WIZARD;
    }
    if (selectD.clicked()) {
      app = DRUMS;
      state = TRACK_WIZARD;
    }
  }
}

