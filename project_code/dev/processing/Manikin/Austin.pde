public class Wiggle {
  FilteredFloat target;
  int amplitude;
  int steps;
  float phase;
  boolean active;

  public Wiggle(FilteredFloat target, int amplitude, int steps, float initPhase, boolean active) {
    this.target = target;
    this.amplitude = amplitude;
    this.steps = steps;
    this.active = active;
    this.phase = initPhase;
  } 

  public void wiggle() {
    target.put(constrain(target.get() + sin(phase)*amplitude, 0, 180));
    phase += (PI/2)/steps;
  }

  public void activate() {
    this.active = true;
  }
  
  public void deactivate() {
    this.active = false;
  }
  
  public boolean active() {
    return active;
  }
  
}


public class Austin extends Doppelganger {
  final static int LIMB_CHANGE_INTERVAL = 1000;
  final static int WIGGLE_AMPLITUDE = 25;
  final static int WIGGLE_STEPS = 15;

  int last_limb_change_timestamp;

  Wiggle []wiggles = { 
    new Wiggle(bodyRotation, WIGGLE_AMPLITUDE, 30, 0, true), 
    new Wiggle(rightLimb.shoulderPanAngle, 23, WIGGLE_STEPS, 0, true), 
    new Wiggle(rightLimb.shoulderTiltAngle, 27, WIGGLE_STEPS, 0, true), 
    new Wiggle(rightLimb.elbowAngle, 31, WIGGLE_STEPS, 0.5 * PI, true), 
    new Wiggle(leftLimb.shoulderPanAngle, 29, WIGGLE_STEPS, 0, true), 
    new Wiggle(leftLimb.shoulderTiltAngle, 25, WIGGLE_STEPS, 0, true), 
    new Wiggle(leftLimb.elbowAngle, 29, WIGGLE_STEPS, 0.5 * PI, true)
  };

  public Austin(SimpleOpenNI context, int userId) {
    super(context, userId);
    last_limb_change_timestamp = millis();
  }

  void personalize() {
    for(int limbIdx = 0; limbIdx < 7; ++limbIdx) {
      if(wiggles[limbIdx].active()) {
        wiggles[limbIdx].wiggle();
      }
    }
    
    //    println("wigglePhase "+wigglePhase+"\tangle="+wiggleMe.get());

    if (millis() - last_limb_change_timestamp > LIMB_CHANGE_INTERVAL) {
      last_limb_change_timestamp = millis();
      //      limbIdx = (++limbIdx%7);
      //      println(limbIdx);
    }
  }

  float getSmoothing() {
    return 0.9;
  }
}

