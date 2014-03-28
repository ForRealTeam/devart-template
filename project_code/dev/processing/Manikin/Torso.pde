public class Torso {

  FilteredFloat bodyRotation;
  Limb rightLimb;
  Limb leftLimb;

  public Torso() {
    this(0);
  }
  
  public Torso(float smoothing) {
    bodyRotation = new FilteredFloat(smoothing);
    rightLimb = new Limb(smoothing);
    leftLimb = new Limb(smoothing);
  }

  public Torso(FilteredFloat bodyRotation, Limb rightLimb, Limb leftLimb) {
    this.bodyRotation = new FilteredFloat(bodyRotation);
    this.rightLimb = new Limb(rightLimb);
    this.leftLimb = new Limb(leftLimb);
  }
  
  public FilteredFloat axisAt(int idx) {
    switch(idx) {
      case 0: return bodyRotation;
      case 1: return rightLimb.shoulderPanAngle;
      case 2: return rightLimb.shoulderTiltAngle;
      case 3: return rightLimb.elbowAngle;
      case 4: return leftLimb.shoulderPanAngle;
      case 5: return leftLimb.shoulderTiltAngle;
      case 6: return leftLimb.elbowAngle;
      default: return null;
    }
  }
  
  void put(Torso other) {
    bodyRotation.put(other.bodyRotation);
    rightLimb.put(other.rightLimb);
    leftLimb.put(other.leftLimb);
  } 

  void set(Torso other) {
    bodyRotation.set(other.bodyRotation);
    rightLimb.set(other.rightLimb);
    leftLimb.set(other.leftLimb);
  } 
}

