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

void setup() {
  size(640, 480);

  // get list of cameras
  String[] cameras = Capture.list();
  
  // quit program if there are no cameras available
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
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
  
  audioThread = new AudioThread();
  audioThread.start();      
}

// calculate phase
float calcDPhase(float freq, float sampleRate){
  return (freq * 2.0/sampleRate * PI);
}

void draw() {
  // read data from camera and display on screen
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  
  drawStats();
  drawTrackers();
  moveTrackers();
  
  // change the frequency and amplitude to that of the markers
  targetFrequency = abs(freqPos.y - height);
  targetAmplitude = map(ampPos.x, 0, width, 0, 100);
}

// draw testing stats on screen
void drawStats() {
  // fps count
  fill(0);
  textSize(20);
  text("FPS: "+frameRate, 10, 20);

  // x pos
  text("X: "+ampPos.x, 10, 40);
  // y pos
  text("Y: "+freqPos.y, 10, 60);
}

// draw markers to the screen
void drawTrackers() {
  // mouse pos
  fill(255, 255, 0);
  ellipse(mouseX, mouseY, 20, 20);

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

  ampPos.x = constrain(ampPos.x, 20, width - 20);
  freqPos.y = constrain(freqPos.y, 20, height - 20);
}

// this function gets called when you press the escape key in the sketch
void stop(){
  // tell the audio to stop
  audioThread.quit();
  // call the version of stop defined in our parent class, in case it does anything vital
  super.stop();
}

// this gets called by the audio thread when it wants some audio
// we should fill the sent buffer with the audio we want to send to the 
// audio output
void generateAudioOut(float[] buffer){
  for (int i=0;i<buffer.length; i++){
    // generate white noise
    buffer[i] = 0.01 * targetAmplitude * sin(phase);
    phase += dPhase;
    if (frequency < targetFrequency){
      frequency+= 0.01;
    }
    if (frequency > targetFrequency){
      frequency-= 0.01;
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
