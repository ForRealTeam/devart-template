/* --------------------------------------------------------------------------
 * Manikin OpenNI controller
 * 
 * (C)2014 ForReal team
 * http://wwww.forrealteam.com
 * 
 */

import processing.serial.*;
import SimpleOpenNI.*;
import java.util.*;

boolean offline = false;//used for developing offline
Serial myPort;  // Create object from Serial class

SimpleOpenNI  context;
PGraphics paintCanvas;
Map<Integer, Doppelganger> doppels = new HashMap<Integer, Doppelganger>();

TextBox textBox = new TextBox(10, 32);

boolean showDepth = false;
boolean showUser = false;

void setup()
{
  size(640, 480);

  if (!offline) {
    String portName = "COM13";
    println("Opening '"+portName+"'...");
    myPort = new Serial(this, portName, 115200);
  }

  context = new SimpleOpenNI(this);
  print("init...");
  if (context.isInit() == false)
  {
    println("\nCan't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }
  context.setMirror(false);
  println("complete");

  // enable depthMap generation 
  context.enableDepth();

  // enable skeleton generation for all joints
  context.enableUser();

  background(250);

  stroke(0, 0, 255);
  strokeWeight(3);
  smooth();  

  paintCanvas = createGraphics(displayWidth, displayHeight);
  clearCanvas();
}

void draw()
{
  // update the cam
  context.update();

  background(250);
  image(paintCanvas, 0, 0);
  if (showDepth)// draw depthImageMap
    image(context.depthImage(), 0, 0);
  if (showUser)
    image(context.userImage(), 0, 0);

  // draw the skeleton if it's available
  int[] userList = context.getUsers();

  if (userList.length > 0) {
    for (int i=0;i<userList.length;i++)
    {
      int userId = userList[i];
      if (context.isTrackingSkeleton(userId))
      {
        Doppelganger doppel = doppels.get(userId);
        if (doppel == null) {
          // doppel = new SimpleDoppelganger(context, userId);
          //doppel = new Austin(context, userId);
          doppel = new Patrick(context, userId);
          // doppel = new Paralyzed(context, userId);
          doppels.put(userId, doppel);
        }
//        println(doppel.getClass());
        stroke(255, 0, 0);
        drawSkeleton(userId);
        doppel.manifest();

        textBox.clear();
        updateServo(Servo.SERVO_BODY_ROTATION, doppel.getBodyRotation());
        updateServo(Servo.SERVO_RIGHT_SHOULDER_PAN, doppel.getRightShoulderPanAngle());
        updateServo(Servo.SERVO_RIGHT_SHOULDER_TILT, doppel.getRightShoulderTiltAngle());
        updateServo(Servo.SERVO_RIGHT_ELBOW, doppel.getRightElbowAngle());
        updateServo(Servo.SERVO_LEFT_SHOULDER_PAN, doppel.getLeftShoulderPanAngle());
        updateServo(Servo.SERVO_LEFT_SHOULDER_TILT, doppel.getLeftShoulderTiltAngle());
        updateServo(Servo.SERVO_LEFT_ELBOW, doppel.getLeftElbowAngle());

        fill(0);
        textAlign(LEFT);
        textBox.draw(10, 100);
        return;//display only one user!!!
      }
      else {
        fill(250, 128, 0);
        textAlign(CENTER);
        textSize(80);
        text("Locking...", 320, 400);
        return;//show once
      }
    }
  }
  else {
    //if we got here we have no user 
    fill(250, 0, 0);
    textAlign(CENTER);
    textSize(100);
    text("No user", 320, 400);
  }
}

void updateServo(Servo servo, float val) {
  int valInt = (int)val;
  byte valByte = (byte)valInt;
  textBox.add(servo.name()+" (" + servo.number() + "): "+valInt);
  if (!offline) {
    myPort.write(255);//magic
    myPort.write(servo.number());
    myPort.write(valByte);
  }
}


// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{
  // to get the 3d joint data
  /*
  PVector jointPos = new PVector();
   context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,jointPos);
   println(jointPos);
   */

  //  context.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
  stroke(0, 255-userId*16, 0);
  strokeWeight(100);
  context.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_HEAD);
  //
  //  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  strokeWeight(30);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);
  //
  //  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  //
  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  //  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  //  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);
  //
  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  //  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  //  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);

  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_HIP);
}

// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");

  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //  println("onVisibleUser - userId: " + userId);
}


void keyPressed()
{
  switch(key)
  {
  case ' ':
    context.setMirror(!context.mirror());
    break;
  case '\n':
    clearCanvas();
    resetAllUsers();
    break;
  case 'u': 
  case 'U': 
    showUser = !showUser;
    break;
  case 'd': 
  case 'D':
    showDepth=!showDepth;
    break;
  case '1':
    for (int uid: doppels.keySet()) {
      doppels.put(uid, new SimpleDoppelganger(context, uid));
    }
    break;
  case '2':
    for (int uid: doppels.keySet()) {
      doppels.put(uid, new Neurotic(context, uid));
    }
    break;
  case '3':
    for (int uid: doppels.keySet()) {
      doppels.put(uid, new FrozenFrozen(context, uid));
    }
    break;
  case '4':
    for (int uid: doppels.keySet()) {
      doppels.put(uid, new Paralyzed(context, uid));
    }
    break;
  case '5':
    for (int uid: doppels.keySet()) {
      doppels.put(uid, new Austin(context, uid));
    }
    break;
  case '6':
    for (int uid: doppels.keySet()) {
      doppels.put(uid, new Patrick(context, uid));
    }
    break;
  }
}  

void resetAllUsers() {
  int[] userList = context.getUsers();
  for (Doppelganger doppel : doppels.values()) {
    doppel.reset();
  }
}


void clearCanvas() {
  paintCanvas.beginDraw();
  paintCanvas.background(220, 200, 210);
  paintCanvas.endDraw();
}

