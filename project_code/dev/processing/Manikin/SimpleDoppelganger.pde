public class SimpleDoppelganger extends Doppelganger {
  public SimpleDoppelganger(SimpleOpenNI context, int userId) {
    super(context, userId);
  }

  void personalize() {
  }

  float getSmoothing() {
    return 0.75;
  }
}


