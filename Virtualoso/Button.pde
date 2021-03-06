class Button {
  
  float posX;
  float posY;
  float wid;
  float hei;
  String label;
  
  // constructor
  Button(float cx, float cy, float w, float h, String l) {
    posX = cx;
    posY = cy;
    wid = w;
    hei = h;
    label = l;
  }
  
  // draws button to the screen
  void drawButton(color lineCol, color bgCol) {
    rectMode(CENTER);
    stroke(lineCol);
    textAlign(CENTER, CENTER);
    textSize(hei/2);
    // reverse the colours if the mouse is over the button
    if (mouseX > posX - wid/2 && mouseX < posX + wid/2 && mouseY > posY - hei/2 && mouseY < posY + hei/2) {
      fill(lineCol);
      rect(posX, posY, wid, hei);
      fill(bgCol); 
      text(label, posX, posY);
    }
    // draw normally
    else {
      fill(bgCol);
      rect(posX, posY, wid, hei);
      fill(lineCol);
      text(label, posX, posY);
    }
  }
  
  // returns true when the button has been clicked
  boolean clicked() {
    if (mouseX > posX - wid/2 && mouseX < posX + wid/2 && mouseY > posY - hei/2 && mouseY < posY + hei/2) {
      return true;
    }
    return false;
  }
}
