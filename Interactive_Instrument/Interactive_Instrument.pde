import ddf.minim.*;
import ddf.minim.ugens.*;

import processing.video.*;

Minim minim;

Capture cam;

Theremin theremin;

ColourTracker frequency;
ColourTracker amplitude;

int state; // current state of program
int app; // current program we are in - theremin or drums  

// state constants
final int MAIN_MENU = 0;
final int TRACK_WIZARD = 1;
final int IN_PROGRAM = 2;

// app constants
final int THEREMIN = 0;
final int DRUMS = 1;

// monitor whether the wizard has been completed
boolean fTracked = false;
boolean aTracked = false;

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
  }
  else if (state > 0) { 
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
        if (aTracked && fTracked) {
          state = IN_PROGRAM;
          theremin = new Theremin(); // instantiate the theremin
        }
      }
      else if (state == IN_PROGRAM) {
        // update the pitch and volume based on position of colour trackers
        theremin.updateSound(frequency, amplitude);
      }
    }
    else { // drums
      // code for drum kit goes here
    }
  }
}

// set the colour trackers with a keypress
void keyPressed() {
  if (state > 0 && app == THEREMIN) {
    if (key == frequency.updateKey) {
      frequency.setTracker();
      fTracked = true;
    } 
    else if (key == amplitude.updateKey) {
      amplitude.setTracker();
      aTracked = true;
    }
  }
}

void mouseClicked() {
  if (state == MAIN_MENU) {
    if (selectT.clicked()) {
      app = THEREMIN;
      state = TRACK_WIZARD;
    }
//    if (selectD.clicked()) {
//      app = DRUMS;
//      state = TRACK_WIZARD;
//    }
  }
}
