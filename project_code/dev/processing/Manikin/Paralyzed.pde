public class Paralyzed extends Doppelganger {

  final static int LIMB_CHANGE_INTERVAL = 6000;

  int last_limb_change_timestamp;
  int axisIdx = 0;

  Torso captured = new Torso(0);   

  public Paralyzed(SimpleOpenNI context, int userId) {
    super(context, userId);
  }

  void personalize() {
    Torso current = new Torso(bodyRotation, rightLimb, leftLimb);
    if (millis() - last_limb_change_timestamp > LIMB_CHANGE_INTERVAL) {
      last_limb_change_timestamp = millis();
      axisIdx = (axisIdx + 1) % 7;
      // println("active axis set to: " + axisIdx);
      background(255);
      captured.set(current);
    }
    float activeAxisValue = current.axisAt(axisIdx).get();
    if(captured != null) {
      current.set(captured);
    }
    current.axisAt(axisIdx).set(activeAxisValue);
  }

  float getSmoothing() {
    return 0.75;
  }
}

