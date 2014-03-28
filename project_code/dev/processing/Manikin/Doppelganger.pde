public abstract class Doppelganger {

  protected SimpleOpenNI context;
  protected int userId;

  protected PVector rightShoulder = new PVector();
  protected PVector rightElbow = new PVector();
  protected PVector rightHand = new PVector();
  protected PVector rightHip = new PVector();
  protected PVector leftShoulder = new PVector();
  protected PVector leftElbow = new PVector();
  protected PVector leftHand = new PVector();
  protected PVector leftHip = new PVector();

  protected FilteredFloat bodyRotation;
  protected Limb rightLimb, leftLimb;

  public Doppelganger(SimpleOpenNI context, int userId) {
    this.context = context;
    this.userId = userId;
    bodyRotation = new FilteredFloat(getSmoothing());
    rightLimb = new Limb(getSmoothing());
    leftLimb = new Limb(getSmoothing());
  }

  public abstract void personalize();
  public abstract float getSmoothing();

  public void manifest() {
    track();
    analyze();
    personalize();
  }

  public int getUserId() {
    return userId;
  }
  
  private void track() {
    context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, rightShoulder);
    context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, rightElbow);
    context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, rightHand);
    context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HIP, rightHip);
    context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, leftShoulder);
    context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, leftElbow);
    context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, leftHand);
    context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HIP, leftHip);
  }
  
  private void analyzeLimb(Limb limb, PVector shoulder, PVector elbow, PVector hand, PVector hip, PVector shoulders) {
    PVector shoulderElbow = PVector.sub(shoulder, elbow);
    float pan = degrees(PVector.angleBetween(shoulderElbow, shoulders));
    limb.shoulderPanAngle.put(map(pan,0,120,0,180));

    PVector shoulderHip = PVector.sub(shoulder, hip);
    limb.shoulderTiltAngle.put(180-degrees(PVector.angleBetween(shoulderElbow, shoulderHip)));

    PVector elbowShoulder = PVector.sub(elbow, shoulder);
    PVector elbowHand = PVector.sub(elbow, hand);
    limb.elbowAngle.put(180-degrees(PVector.angleBetween(elbowShoulder, elbowHand)));
  }

  private void analyze() {
    float deltaZ = rightHip.z - leftHip.z;
    float deltaX = rightHip.x - leftHip.x;
    bodyRotation.put(180-(90+degrees(atan(deltaZ/deltaX))));
    analyzeLimb(rightLimb, rightShoulder, rightElbow, rightHand, rightHip, PVector.sub(leftShoulder, rightShoulder));
    analyzeLimb(leftLimb, leftShoulder, leftElbow, leftHand, leftHip, PVector.sub(rightShoulder, leftShoulder));
  }

  float getBodyRotation() {
    return bodyRotation.get();
  }

  float getRightShoulderPanAngle() {
    return rightLimb.shoulderPanAngle.get();
  }

  float getRightShoulderTiltAngle() {
    return rightLimb.shoulderTiltAngle.get();
  }

  float getRightElbowAngle() {
    return rightLimb.elbowAngle.get();
  }

  float getLeftShoulderPanAngle() {
    return leftLimb.shoulderPanAngle.get();
  }

  float getLeftShoulderTiltAngle() {
    return leftLimb.shoulderTiltAngle.value;
  }

  float getLeftElbowAngle() {
    return leftLimb.elbowAngle.value;
  }

  PVector getRightHand() {
    return rightHand;
  }

  PVector getLeftHand() {
    return leftHand;
  }

  void reset() {
  }

}

