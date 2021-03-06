Connecting the Kinect 
Our next challenge was to connect the kinect camera so it could recognise the users movement and translate it to the robots movement. 

Kinect has wonderful user tracking abilities in 3d, utilizing its depth sensors, but we quickly faced some apparent limitations. It seems the Kinect may lose track of user’s hands when they are in front of the body or behind the head.
Some 3D vector manipulation was used to isolate the angels that we wanted to observe changing. Here’s a snapshot of our processing sketch monitoring Zvika’s movement in 3d and displaying the angles between limbs.

[project_images/processing.png]]

Our prototype is using a combination of Processing sketch with SimpleOpenNI to track user’s movement and a single Arduino to control all servos. The PC is connected to Arduino using Serial over USB, with a simple half-duplex protocol that transmits a servo number and its corresponding angle.
Starting with the hip joint, we sent the angle we calculated in the processing sketch to the Arduino controlling in real time using serial connection. It’s amazing to see how much fun it is and how much even one moving part that actually reacts to you in real time makes a difference. 

https://www.youtube.com/watch?v=c5e8hlZefwg&list=PLVFHt_u7b7bGriRHce8GBIDgBDPLjIj0p&index=3

Our next step will be to fully mirror user’s movement with all servos!
