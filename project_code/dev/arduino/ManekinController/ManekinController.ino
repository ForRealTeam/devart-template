#include <SoftwareServo.h>

#define MAX_NUM_OF_SERVO 8
SoftwareServo servo[MAX_NUM_OF_SERVO];

int servo_pins[] = {3,4,5,6,10,8,9};

void setup()
{
  pinMode(13,OUTPUT);
  for(int i = 0; i < MAX_NUM_OF_SERVO; ++i) {
    pinMode(servo_pins[i], OUTPUT);    
    servo[i].attach(servo_pins[i]);
    servo[i].setMaximumPulse(2200);
  }
  Serial.begin(115200);
  Serial.println("Ready");
}

void loop()
{
  if ( Serial.available()) {
    int magic = Serial.read() & 0xff;
    if(magic == 255) {
      while(!Serial.available()) {
        delay(1);
      }
      int servo_idx = Serial.read() & 0xff;
      while(!Serial.available()) {
        delay(1);
      }
      int val = Serial.read() & 0xff;
      if (servo_idx<MAX_NUM_OF_SERVO) {
        if(servo_idx == 5 || servo_idx == 3 || servo_idx == 1)//left shoulder tilt, right elbow, right shoulder pan
          val = 180-val;
        servo[servo_idx].write(val);
      }
    }
  }
  else {
    // Serial.println("*");
  }
  SoftwareServo::refresh();
}


