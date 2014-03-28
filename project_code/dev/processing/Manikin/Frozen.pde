public class FrozenFrozen extends Doppelganger {

  private final static int FREEZE_UPDATE_INTERVAL = 1000; 

  private long last_freeze_tstamp;
  private FilteredFloat frozenBodyRotation = new FilteredFloat(0);
  private Limb frozenRightLimb = new Limb(0); // soothing of zero means that put = set
  private Limb frozenLeftLimb = new Limb(0);  // soothing of zero means that put = set

  public FrozenFrozen(SimpleOpenNI context, int userId) {
    super(context, userId);
    last_freeze_tstamp = millis();
  }

  void personalize() {
    if (millis() - last_freeze_tstamp > FREEZE_UPDATE_INTERVAL) {
      last_freeze_tstamp = millis();
      frozenBodyRotation.put(bodyRotation.get());
      frozenRightLimb.put(rightLimb);
      frozenLeftLimb.put(leftLimb);
    }
    bodyRotation.put(frozenBodyRotation.get());
    rightLimb.put(frozenRightLimb);
    leftLimb.put(frozenLeftLimb);
  }

  float getSmoothing() {
    return 0;
  }
}

