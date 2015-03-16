import processing.video.*;

Capture cam;

AudioThread audioThread;

PVector ampPos;
PVector freqPos;

float phase;
float frequency;
float dPhase;
float targetFrequency;
float targetAmplitude;

// stores whether a number represented whether the key is pressed or not
float up, down, left, right;

ColourTracker trackerOne;
ColourTracker trackerTwo;

void setup() {
  size(640, 480);

  // get list of cameras
  String[] cameras = Capture.list();

  // quit program if there are no cameras available
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    //cam = new Capture(this, cameras[0]);
    cam = new Capture(this, 640, 480, 30);
    cam.start();
  }

  // create vectors to represent position of markers on screen
  ampPos = new PVector(width/2, height - 50);
  freqPos = new PVector(width - 50, height/2);

  // default initial values
  frequency = freqPos.y;
  phase = 0;
  dPhase = calcDPhase(frequency, 44100);

  trackerOne = new ColourTracker('1');
  trackerTwo = new ColourTracker('2');

  audioThread = new AudioThread();
  audioThread.start();
}

// calculate phase
float calcDPhase(float freq, float sampleRate) {
  return (freq * 2.0/sampleRate * PI);
}

void draw() {
  // read data from camera and display on screen
  if (cam.available() == true) {
    cam.read();
  }
  cam.loadPixels();
  // reverse the image so it acts like a mirror
  pushMatrix();
  scale(-1, 1);
  image(cam, -width, 0);
  popMatrix();

  drawStats();
  drawTrackers();
  moveTrackers();
  //trackerOne.track();
  //trackerTwo.track();

  // change the frequency and amplitude to that of the markers - keyboard controls
  targetFrequency = map(abs(freqPos.y - height), 0, height, 300, 1000);
  targetAmplitude = map(ampPos.x, 0, width, 0, 100);

  // change the frequency and amplitude to that of the markers - colour tracking controls
  //targetFrequency = abs(trackerOne.position.y - height);
  //targetAmplitude = map(trackerTwo.position.x, 0, width, 0, 100);
}

// draw testing stats on screen
void drawStats() {
  // fps count
  fill(0);
  textSize(20);
  text("FPS: "+frameRate, 10, 20);

  // x pos
  text("X: "+ampPos.x, 10, 40);
  //text("X: "+trackerTwo.position.x, 10, 40);
  // y pos
  text("Y: "+freqPos.y, 10, 60);
  //text("Y: "+trackerOne.position.y, 10, 60);
}

// draw markers to the screen
void drawTrackers() {
  // x pos
  fill(255, 0, 0);
  stroke(0);
  strokeWeight(5);
  ellipse(ampPos.x, ampPos.y, 40, 40);

  // y pos
  fill(255, 0, 0);
  stroke(0);
  strokeWeight(5);
  ellipse(freqPos.x, freqPos.y, 40, 40);
}

// move the trackers based on the keys pressed
void moveTrackers() {
  ampPos.x += (right - left) * 5;
  freqPos.y += (down - up) * 5;

  ampPos.x = constrain(ampPos.x, 0, width);
  freqPos.y = constrain(freqPos.y, 0, height);
}

// this function gets called when you press the escape key in the sketch
void stop() {
  // tell the audio to stop
  audioThread.quit();
  // call the version of stop defined in our parent class, in case it does anything vital
  super.stop();
}

// this gets called by the audio thread when it wants some audio
// we should fill the sent buffer with the audio we want to send to the 
// audio output
void generateAudioOut(float[] buffer) {
  for (int i = 0; i < buffer.length; ++i) {
    // generate white noise
    buffer[i] = 0.01 * targetAmplitude * sin(phase);
    phase += dPhase;
    if (frequency < targetFrequency) {
      frequency += 0.01;
    }
    if (frequency > targetFrequency) {
      frequency -= 0.01;
    }
    dPhase = calcDPhase(frequency, 44100);
  }
}

// set variable for movement
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      left = 1;
    }
    if (keyCode == RIGHT) {
      right = 1;
    }
    if (keyCode == UP) {
      up = 1;
    }
    if (keyCode == DOWN) {
      down = 1;
    }
  }
  if (key == trackerOne.updateKey) {
    trackerOne.setTracker();
  } else if (key == trackerTwo.updateKey) {
    trackerTwo.setTracker();
  }
}

// unset variable for movement
void keyReleased() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      left = 0;
    }
    if (keyCode == RIGHT) {
      right = 0;
    }
    if (keyCode == UP) {
      up = 0;
    }
    if (keyCode == DOWN) {
      down = 0;
    }
  }
}

