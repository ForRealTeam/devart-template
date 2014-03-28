public class Neurotic extends Doppelganger {

  private static final int NOISE_START = 2;
  private static final int NOISE_END = 30;
  private static final int NOISE_UPDATE_INTERVAL = 1000; // ms

  int noise = NOISE_START;
  int dir = 1;
  long last_noise_update;

  public Neurotic(SimpleOpenNI context, int userId) {
    super(context, userId);
    last_noise_update = millis();
  }

  void personalize() {
    addNoise(bodyRotation);
    addNoise(rightLimb.shoulderPanAngle);
    addNoise(rightLimb.shoulderTiltAngle);
    addNoise(rightLimb.elbowAngle);
    addNoise(leftLimb.shoulderPanAngle);
    addNoise(leftLimb.shoulderTiltAngle);
    addNoise(leftLimb.elbowAngle);

    if (millis() - last_noise_update > NOISE_UPDATE_INTERVAL) {
      last_noise_update = millis();
      noise += dir;
      if (noise > NOISE_END || noise < NOISE_START) {
        // dir *= -1;
        noise = NOISE_START;
      }
      println(noise);
    }
  }

  void addNoise(FilteredFloat messMeUp) {
    messMeUp.put(messMeUp.get() + random(-noise, noise));
  }

  float getSmoothing() {
    return 0.25; // no smoothing
  }
}

