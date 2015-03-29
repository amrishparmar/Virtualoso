class Theremin {
  
  AudioOutput out;
  Oscil wave;
  float targetFrequency;
  float targetAmplitude;
  float prevFrequency;
  float prevAmplitude;
  
  // constructor
  Theremin() {
    // create a sine wave Oscil and patch to output - from http://code.compartmental.net/minim/audiooutput_class_audiooutput.html
    out = minim.getLineOut();
    wave = new Oscil(440, 0.5f, Waves.SINE);
    wave.patch(out);
    
    // set some default values
    targetFrequency = 440;
    targetAmplitude = 0.5;
    prevFrequency = 440;
    prevAmplitude = 0.5;
  }
  
  // updates the frequency and amplitude of audio output
  void updateSound(ColourTracker freq, ColourTracker amp) {
    
    // use the position from colour tracker if we have a positive value
    if (freq.position.y > 0)
      prevFrequency = freq.position.y;
    // else (if we get NaN from colour tracker - happens when tracker not found) use the previous known position
    else
      freq.position.y = prevFrequency;
    // use the position from colour tracker if we have a positive value
    if (amp.position.x > 0)
      prevAmplitude = amp.position.x;
    // else (if we get NaN from colour tracker - happens when tracker not found) use the previous known position
    else
      amp.position.x = prevAmplitude;
    
    // change the frequency and amplitude to position of colour trackers
    targetFrequency = map(abs(freq.position.y - height), 0, height, 200, 1200);
    targetAmplitude = map(amp.position.x, 0, width, 0, 1);
    
    // update frequency and amplitude of wave to new values
    wave.setFrequency(targetFrequency);
    wave.setAmplitude(targetAmplitude);
  }
}
