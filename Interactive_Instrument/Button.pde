class Button {
  
  float posX;
  float posY;
  float wid;
  float hei;
  String label;
  
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
    textSize(hei-35);
    if (mouseX > posX - wid/2 && mouseX < posX + wid/2 && mouseY > posY - hei/2 && mouseY < posY + hei/2) {
      fill(lineCol);
      rect(posX, posY, wid, hei);
      fill(bgCol); 
      text(label, posX, posY);
    }
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
