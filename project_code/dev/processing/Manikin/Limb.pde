public class Limb {
  FilteredFloat shoulderPanAngle, shoulderTiltAngle, elbowAngle;

  public Limb(Limb other) {
     shoulderPanAngle = new FilteredFloat(other.shoulderPanAngle);
     shoulderTiltAngle = new FilteredFloat(other.shoulderTiltAngle);
     elbowAngle = new FilteredFloat(other.elbowAngle);
  }
  
  public Limb(float smoothing) {
     shoulderPanAngle = new FilteredFloat(smoothing);
     shoulderTiltAngle = new FilteredFloat(smoothing);
     elbowAngle = new FilteredFloat(smoothing);
  }
  
  void put(Limb other) {
    shoulderPanAngle.put(other.shoulderPanAngle.get());
    shoulderTiltAngle.put(other.shoulderTiltAngle.get());
    elbowAngle.put(other.elbowAngle.get());
  } 
  
  void set(Limb other) {
    shoulderPanAngle.set(other.shoulderPanAngle);
    shoulderTiltAngle.set(other.shoulderTiltAngle);
    elbowAngle.set(other.elbowAngle);
  } 
  
  boolean similar(Limb other, int tolerance) {
    return shoulderPanAngle.similar(other.shoulderPanAngle, tolerance);
  } 
}
