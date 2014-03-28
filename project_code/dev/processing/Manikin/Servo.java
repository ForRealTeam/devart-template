public enum Servo {
  SERVO_BODY_ROTATION (0), 
  SERVO_RIGHT_SHOULDER_PAN (1), 
  SERVO_RIGHT_SHOULDER_TILT (2), 
  SERVO_RIGHT_ELBOW (3), 
  SERVO_LEFT_SHOULDER_PAN (4), 
  SERVO_LEFT_SHOULDER_TILT (5), 
  SERVO_LEFT_ELBOW (6);
  
  private int servoNum;
  
  private Servo(int num) {
    servoNum = num;
  }
  
  public int number() {
    return servoNum;
  }
}

