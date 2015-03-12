  
import processing.video.*;

Capture cam;

AudioThread audioThread;

PVector ampPos;
PVector freqPos;

float amp;
float freq;
float phase;

float up, down, left, right;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();
  
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

  ampPos = new PVector(width/2, height - 50);
  freqPos = new PVector(width - 50, height/2);

  freq = freqPos.y;
  phase = 0;
  audioThread = new AudioThread();
  audioThread.start();      
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  
  drawStats();
  drawTrackers();
  moveTrackers();

  freq = abs(freqPos.y - height);
  amp = ampPos.x;
}

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
  for (int i = 0; i < buffer.length; i++){
    buffer[i] = 0;
    // generate white noise
    for (float partial = 0; partial < 10; partial++){
      buffer[i] += sin(TWO_PI / 44100 * phase * freq);
      buffer[i] *= 0.1;
      phase = (phase + 1) % 44100;      
    }
  }
}

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