Mirroring 
Before we start to make movement variations we need to create a baseline. The DoppelGänger is mirroring the movements of the user by tracking user 3d movements using Kinect and an Arduino controlling the prototype's servo. The first few times some robotic limbs were flying all over the studio (we needed a stronger build:) and we had an issue with smoothing the robot’s movements that we had to solve by using a low pass filter on the perceived user’s limbs 3D location. Some tweaking was needed for the low pass smoothing, as too big a smoothing factor would make the robot feel unresponsive, whilst small smoothing factor eliminated the smoothing.
We finally got it up and running(!) and it became an instant hit (Tomer’s kids loved it!) - we found ourselves jumping around like children ‘making faces’ in front of Doppel (we call our robot Doppel ;). the servo engines are reacting quite fast, though using the kinect presents limitations - we hate it when it throws the arms randomly when it can’t detect arms. It might be fixed by an overhead camera but we are not sure it's worthwhile at the moment. 

https://www.youtube.com/watch?v=_etYu8Y2yU0&list=PLVFHt_u7b7bGriRHce8GBIDgBDPLjIj0p