public class Patrick extends Doppelganger {
  
  private final static int TOLERANCE = 15;
  private final static int SAMPLE_INTERVAL = 250;  
  private final static int SIMILARITY_TRIGGER_DURATION = 500;

  private long last_sampled;
  private long similarity_started_tstamp;

  private FilteredFloat posedBodyRotation = new FilteredFloat(0);
  private Limb posedRightLimb = new Limb(0);
  private Limb posedLeftLimb = new Limb(0);

  private FilteredFloat lastBodyRotation = new FilteredFloat(0);
  private Limb lastRightLimb = new Limb(0);
  private Limb lastLeftLimb = new Limb(0);

  public Patrick(SimpleOpenNI context, int userId) {
    super(context, userId);
    last_sampled = millis();
  }

  
  void personalize() {
    //println("bodyRotation: " + bodyRotation + "\tlastBodyRotation" + lastBodyRotation);
    if(bodyRotation.similar(lastBodyRotation, TOLERANCE) && 
      rightLimb.similar(lastRightLimb, TOLERANCE) &&
      leftLimb.similar(lastLeftLimb, TOLERANCE)) {
        
      println("acquiring " + millis());
      
      if(similarity_started_tstamp < 0) {
        similarity_started_tstamp = millis();
      }
      if(millis() - similarity_started_tstamp > SIMILARITY_TRIGGER_DURATION) {
        posedBodyRotation.set(bodyRotation);
        posedRightLimb.set(rightLimb);
        posedLeftLimb.set(leftLimb);
      }
    }
    else {
      similarity_started_tstamp = -1;
    }
    
    if(millis() - last_sampled > SAMPLE_INTERVAL) {
      lastBodyRotation.set(bodyRotation);
      lastRightLimb.set(rightLimb);
      lastLeftLimb.set(leftLimb);    
      last_sampled = millis();
      // println("sampling");
    }
    if(posedBodyRotation != null) {
      bodyRotation.set(posedBodyRotation);
      rightLimb.set(posedRightLimb);
      leftLimb.set(posedLeftLimb);
    }
  }

  float getSmoothing() {
    return 0;
  }
}

