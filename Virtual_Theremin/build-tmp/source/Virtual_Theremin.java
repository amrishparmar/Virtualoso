import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Virtual_Theremin extends PApplet {

  


Capture cam;

PVector amp;
PVector freq;

float up, down, left, right;

public void setup() {
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

  amp = new PVector(width/2, height - 50);
  freq = new PVector(width - 50, height/2);      
}

public void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  
  drawStats();
  drawTrackers();
  moveTrackers();
}

public void drawStats() {
  // fps count
  fill(0);
  textSize(20);
  text("FPS: "+frameRate, 10, 20);

  // x pos
  text("X: "+amp.x, 10, 40);
  // y pos
  text("Y: "+freq.y, 10, 60);
}

public void drawTrackers() {
  // mouse pos
  fill(255, 255, 0);
  ellipse(mouseX, mouseY, 20, 20);

  // x pos
  fill(255, 0, 0);
  stroke(0);
  strokeWeight(5);
  ellipse(amp.x, amp.y, 40, 40);

  // y pos
  fill(255, 0, 0);
  stroke(0);
  strokeWeight(5);
  ellipse(freq.x, freq.y, 40, 40);
}

public void moveTrackers() {
  amp.x += (right - left) * 5;
  freq.y += (down - up) * 5;

  amp.x = constrain(amp.x, 20, width - 20);
  freq.y = constrain(freq.y, 20, height - 20);
}

public void keyPressed() {
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

public void keyReleased() {
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Virtual_Theremin" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
