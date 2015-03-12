import processing.video.*;
Capture video;
ColourTracker trackerOne;
ColourTracker trackerTwo;
DrumKit drumkit;

void setup() {
  size(640, 480);
  frameRate(30);
  video = new Capture(this, width, height);
  video.start();
  trackerOne = new ColourTracker('a');
  trackerTwo = new ColourTracker('s');
  drumkit = new DrumKit();
  smooth();
}
void draw() {
  // Capture and display the video
  if (video.available()) {
    video.read();
  }
  fill(255);
  
  video.loadPixels();
  pushMatrix();
  scale(-1,1);
  image(video, -width, 0);
  
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

