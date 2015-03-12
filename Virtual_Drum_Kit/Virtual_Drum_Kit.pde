import processing.video.*;
import ddf.minim.*;

Capture cam;
ColourTracker trackerOne;
ColourTracker trackerTwo;
DrumKit drumkit;
Minim minim;


void setup() {
  size(640, 480);
  frameRate(30);
  minim = new Minim(this);
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  cam = new Capture(this, 640, 480, 30);
  cam.start();
  trackerOne = new ColourTracker('a');
  trackerTwo = new ColourTracker('s');
  drumkit = new DrumKit();
  smooth();
}
void draw() {
  // Capture and display the video
  if (cam.available()) {
    cam.read();
  }
  fill(255);

  cam.loadPixels();
  pushMatrix();
  scale(-1, 1);
  image(cam, -width, 0);

  popMatrix();
  text(frameRate, 10, 10);

  trackerOne.updatePosition();
  trackerOne.displayTracker();
  trackerTwo.updatePosition();
  trackerTwo.displayTracker();
  drumkit.drawKit();
  drumkit.checkForHit(trackerOne);
  // drumkit.checkForHit(trackerTwo);
}

void keyPressed() {
  if (key == trackerOne.updateKey) {
    trackerOne.setTracker();
  } else if (key == trackerTwo.updateKey) {
    trackerTwo.setTracker();
  }
}

