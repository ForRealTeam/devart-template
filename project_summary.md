# Doppelganger
An Army Of You - Multiple Robotic Personality Disorder

## Authors
- Zvika Markfeld (github username: zvikapika), zvika@forrealteam.com
- Saron Paz, saron@forrealteam.com

## Project Description
Doppelganger is an array of 15-20 interactive robots guided by a software based on 3D scanning of the user.
It depicts the user standing in front of it in many alternative states simultaneously, each enacted by a separate humanoid robot. We consider it an authenticity search contraption. While imitating the different personalities in code, we seek to capture a jest of the physical manifestation residing in the core of numerous characters: Patrick, who is a dance instructor, Austin, an easy going music loving bloke, Nathan the neurotic and a few others.

The activation of robot swarm may be done (admin or user-level) via the Android control app, which connects to the robotic contraption over bluetooth, allowing selection of imitation modes and, upon user concent, tagging the user on Google Plus video posts, uploaded from footage taken during the active session.

## Links
Personaity Test videos:
https://www.youtube.com/watch?v=1hFgxRXSCxk
https://www.youtube.com/watch?v=8dfWkjarHsk
https://www.youtube.com/watch?v=KePhjsnCpnU


## Exmple Code Snippet: Wiggly Personality
```
public class Austin extends Doppelganger {
  final static int LIMB_CHANGE_INTERVAL = 1000;
  final static int WIGGLE_AMPLITUDE = 25;
  final static int WIGGLE_STEPS = 15;

  int last_limb_change_timestamp;

  Wiggle []wiggles = { 
    new Wiggle(bodyRotation, WIGGLE_AMPLITUDE, 30, 0, true), 
    new Wiggle(rightLimb.shoulderPanAngle, 23, WIGGLE_STEPS, 0, true), 
    new Wiggle(rightLimb.shoulderTiltAngle, 27, WIGGLE_STEPS, 0, true), 
    new Wiggle(rightLimb.elbowAngle, 31, WIGGLE_STEPS, 0.5 * PI, true), 
    new Wiggle(leftLimb.shoulderPanAngle, 29, WIGGLE_STEPS, 0, true), 
    new Wiggle(leftLimb.shoulderTiltAngle, 25, WIGGLE_STEPS, 0, true), 
    new Wiggle(leftLimb.elbowAngle, 29, WIGGLE_STEPS, 0.5 * PI, true)
  };

  public Austin(SimpleOpenNI context, int userId) {
    super(context, userId);
    last_limb_change_timestamp = millis();
  }

  void personalize() {
    for(int limbIdx = 0; limbIdx < 7; ++limbIdx) {
      if(wiggles[limbIdx].active()) {
        wiggles[limbIdx].wiggle();
      }
    }
    
    //    println("wigglePhase "+wigglePhase+"\tangle="+wiggleMe.get());

    if (millis() - last_limb_change_timestamp > LIMB_CHANGE_INTERVAL) {
      last_limb_change_timestamp = millis();
      //      limbIdx = (++limbIdx%7);
      //      println(limbIdx);
    }
  }

  float getSmoothing() {
    return 0.9;
  }
}
```
## Github Repository
See project on: https://github.com/ForRealTeam/devart-template/tree/master/project_code
