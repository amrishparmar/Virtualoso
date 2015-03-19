class Theremin {
  AudioOutput out;
  Oscil wave;
  float targetFrequency;
  float targetAmplitude;
  
  Theremin() {
    // create a sine wave Oscil and patch to output - from http://code.compartmental.net/minim/audiooutput_class_audiooutput.html
    out = minim.getLineOut();
    wave = new Oscil(440, 0.5f, Waves.SINE);
    wave.patch(out);
    
    targetFrequency = 440;
    targetAmplitude = 0.5;
  }
  
  // updates the frequency and amplitude of audio output
  void updateSound(ColourTracker freq, ColourTracker amp) {
    // change the frequency and amplitude to position of colour trackers  - colour tracking controls
    targetFrequency = map(abs(freq.position.y - height), 0, height, 200, 1200);
    targetAmplitude = map(amp.position.x, 0, width, 0, 1);
    
    // update frequency and amplitude of wave to new values
    wave.setFrequency(targetFrequency);
    wave.setAmplitude(targetAmplitude);
  }
}
