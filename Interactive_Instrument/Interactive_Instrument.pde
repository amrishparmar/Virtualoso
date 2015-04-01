/**

  Virtualoso (an interactive instrument application)
  
  By Amrish Parmar and Charlie Ringer
  
  Submission for Audio-Visual Computing coursework

**/

void setup() {
  size(640, 480);

  // instantiate minim audio library
  minim = new Minim(this);

  // get list of cameras
  String[] cameras = Capture.list();

  // quit program if there are no cameras available
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  }

  // begin capturing
  cam = new Capture(this, 640, 480, 30);
  cam.start();

  // create new colour trackers
  frequency = new ColourTracker('f'); // frequency
  amplitude = new ColourTracker('a'); // amplitude
  leftStick = new ColourTracker('l'); //Left drum stick
  rightStick = new ColourTracker('r'); //Right drum stick

  //Buttons for choosing mode
  selectD = new Button(width/2, 225, 350, 75, "Play the Drums");
  selectT = new Button(width/2, 350, 350, 75, "Play the Theremin");
  back = new Button(60, 40, 80, 50, "Back");
  
  backgroundImage = loadImage("backgroundImg.png");
  mainFont = createFont("ChopinScript.otf", 64);
  inAppFont = createFont("Calibri.ttf", 48);
}

void draw() {
  if (state == MAIN_MENU) {
    //We are on the main menu
    drawMenu();
  } 
  else {
    //read data from camera and display on screen
    if (cam.available() == true) {
      cam.read();
    }
    drawCam();
    back.drawButton(color(0), color(255));
    
    // load pixels from camera - needed for colour tracker
    cam.loadPixels();

    if (app == THEREMIN) {
      // track colours
      frequency.track();
      amplitude.track();

      if (state == TRACK_WIZARD) {
        drawInstructionsT();
        //We need to set up the trackers so inform the user
        if (amplitude.setUp && frequency.setUp) {
          //They have been set up so make a new theremin and start
          state = IN_PROGRAM;
          theremin = new Theremin(); // instantiate the theremin
        }
      } 
      else if (state == IN_PROGRAM) {
        // update the pitch and volume based on position of colour trackers
        theremin.updateSound(frequency, amplitude);
      }
    } 
    else { // drums
      //track the sticks
      leftStick.track();
      rightStick.track();

      if (state == TRACK_WIZARD) {
        //We need to set up the sticks so inform the user
        drawInstructionsD();
        if (leftStick.setUp && rightStick.setUp) {
          //They have been set up so make a new drum kit and start
          drumkit = new DrumKit();
          state = IN_PROGRAM;
        }
      } 
      else if (state == IN_PROGRAM) {
        //draw the drum kit
        drumkit.drawKit();
        //Then check for a hit
        drumkit.checkForHit(leftStick);
        drumkit.checkForHit(rightStick);
      }
    }
  }
}

// set the colour trackers with a keypress
void keyPressed() {
  if (state > 0 && app == THEREMIN) {
    if (key == frequency.updateKey) {
      frequency.setTracker();
    } 
    else if (key == amplitude.updateKey) {
      amplitude.setTracker();
    }
  } 
  else if  (state > 0 && app == DRUMS) {
    if (key == leftStick.updateKey) {
      leftStick.setTracker();
    } 
    else if (key == rightStick.updateKey) {
      rightStick.setTracker();
    }
  }
}

void mouseClicked() {
  if (state == MAIN_MENU) {
    if (selectT.clicked()) {
      app = THEREMIN;
      state = TRACK_WIZARD;
    }
    if (selectD.clicked()) {
      app = DRUMS;
      state = TRACK_WIZARD;
    }
  } else if (back.clicked()) {
    returnToMainMenu();
  }
}

// reinitialises and returns the program to the main menu
void returnToMainMenu() {
  if (app == THEREMIN) {
    frequency.setUp = false;
    amplitude.setUp = false;
    minim.stop(); // stop the audio bleeding over into the menu
  }
  if (app == DRUMS) {
    leftStick.setUp = false; 
    rightStick.setUp = false;
  }
  state = MAIN_MENU;
}

