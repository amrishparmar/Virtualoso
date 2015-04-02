// draw main menu
void drawMenu() {
  textFont(mainFont);
  background(255);
  image(backgroundImage,0,50);
  filter(BLUR, 3);
  textSize(64);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Virtualoso", width/2, 100);
  selectD.drawButton(color(0), color(255));
  selectT.drawButton(color(0), color(255));
}

// draw wizard instructions for theremin
void drawInstructionsT() {
  textFont(inAppFont);
  fill(255,255,0);
  textSize(24);
  text("SETUP", width/2, 25);
  text("Press A to set volume tracker", width/2, 50);
  text("Press F to set pitch tracker", width/2, 75);
}

// draw wizard instructions for drum kit
void drawInstructionsD() {
  textFont(inAppFont);
  fill(255,255,0);
  textSize(24);
  text("SETUP", width/2, 25);
  text("Press L to set left stick", width/2, 50);
  text("Press R to set right stick", width/2, 75);
}

// draws webcam to the screen
void drawCam() {
  // reverse the image so it acts like a mirror
  pushMatrix();
  scale(-1, 1);
  image(cam, -width, 0);
  popMatrix();
}

