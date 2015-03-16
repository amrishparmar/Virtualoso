import ddf.minim.*;
import ddf.minim.ugens.*;

import processing.video.*;

Minim minim;
AudioOutput out;
Oscil wave;

Capture cam;

ColourTracker trackerOne;
ColourTracker trackerTwo;

float targetFrequency;
float targetAmplitude;

void setup() {
  size(640, 480);
  
  // instantiate minim audio library
  minim = new Minim(this);
  
  // create a sine wave Oscil and patch to output - from http://code.compartmental.net/minim/audiooutput_class_audiooutput.html
  out = minim.getLineOut();
  wave = new Oscil(440, 0.5f, Waves.SINE);
  wave.patch(out);

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
  trackerOne = new ColourTracker('f'); // frequency
  trackerTwo = new ColourTracker('a'); // amplitude
}

void stop() {
  // tell the audio to stop
  minim.stop();
  // call the version of stop defined in our parent class, in case it does anything vital
  super.stop();
}

void draw() {
  // read data from camera and display on screen
  if (cam.available() == true) {
    cam.read();
  }
  
  // reverse the image so it acts like a mirror
  pushMatrix();
  scale(-1, 1);
  image(cam, -width, 0);
  popMatrix();
  
  // draw diagnostic stats to screen
  drawStats();
  
  // load pixels from camera - needed for colour tracker
  cam.loadPixels();
  
  // track colours
  trackerOne.track();
  trackerTwo.track();
  
  // change the frequency and amplitude to position of colour trackers  - colour tracking controls
  targetFrequency = map(abs(trackerOne.position.y - height), 0, height, 200, 1200);
  targetAmplitude = map(trackerTwo.position.x, 0, width, 0, 1);
  
  // update frequency and amplitude of wave to new values
  wave.setFrequency(targetFrequency);
  wave.setAmplitude(targetAmplitude);
}

// draw testing stats on screen
void drawStats() {
  // fps count
  fill(0);
  textSize(20);
  text("FPS: "+frameRate, 10, 20);

  // x pos
  text("X: "+trackerTwo.position.x, 10, 40);
  // y pos
  text("Y: "+trackerOne.position.y, 10, 60);
}

// set the colour trackers with a keypress
void keyPressed() {
  if (key == trackerOne.updateKey) {
    trackerOne.setTracker();
  } 
  else if (key == trackerTwo.updateKey) {
    trackerTwo.setTracker();
  }
}

