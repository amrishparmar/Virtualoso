import ddf.minim.*;
import ddf.minim.ugens.*;

import processing.video.*;

Minim minim;

Capture cam;

Theremin theremin;
DrumKit drumkit;

ColourTracker frequency;
ColourTracker amplitude;
ColourTracker leftStick;
ColourTracker rightStick;

int state; // current state of program
int app; // current program we are in - theremin or drums  

// state constants
final int MAIN_MENU = 0;
final int TRACK_WIZARD = 1;
final int IN_PROGRAM = 2;

// app constants
final int THEREMIN = 0;
final int DRUMS = 1;

Button selectD;
Button selectT;

