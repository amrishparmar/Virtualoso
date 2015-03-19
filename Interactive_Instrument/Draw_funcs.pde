void drawMenu() {
  background(255);
  textSize(54);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Interactive Instrument", width/2, 100);
  selectD.drawButton(color(0), color(255));
  selectT.drawButton(color(0), color(255));
}

// draw wizard instructions for theremin
void drawInstructionsT() {
  textSize(24);
  text("Press A to set volume tracker", width/2, 25);
  text("Press F to set pitch tracker", width/2, 50);
}

// draws webcam to the screen
void drawCam() {
  // reverse the image so it acts like a mirror
  pushMatrix();
    scale(-1, 1);
    image(cam, -width, 0);
  popMatrix();
}

// draw testing stats on screen
void drawStats() {
  // fps count
  fill(0);
  textSize(20);
  textAlign(LEFT);
  text("FPS: "+frameRate, 10, 20);
  // x pos
  text("X: "+amplitude.position.x, 10, 40);
  // y pos
  text("Y: "+frequency.position.y, 10, 60);
}
