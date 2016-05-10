# FPGAGame
First Year FPGA Project 

This is a simple Pong/Brick Breaker hybrid game which can be played on a DE0 Board. The game was coded in C/C++ using Catapult-C as a HLS Tool in order to generate RTL files, which were then put into the Quartus project.

In order to run the game, download the whole repository as a .zip and extract and run the DE0_D5M.qpf .
The actual Quartus File can be found in /student_files_2015(1)/student_files_2015/prj2/quartus_proj/DE0_CAMERA_MOUSE/DE0_D5M.qpf

![alt tag](https://raw.githubusercontent.com/alaksana96/FPGAGame/master/game.jpg)

The green paddle on the left can be controlled by a red object, whereas the blue paddle on the right can be controlled using a blue object. In our example, we have used a red and a blue coloured rugby ball. The two players should ensure that the objects can be seen by the camera, so moving the balls up and down between 30-50cm away from the camera of the DE0 board.

There is some lag as to the position of the paddle. Sometimes, the position of the paddle does not update when you move the object too quickly. Also, the paddles flicker between 2 positions, since the image processing algorithm is not very advanced.I hope to solve these issues once my first year exams are out of the way.

![alt tag](https://raw.githubusercontent.com/alaksana96/FPGAGame/master/gameschematic.png)
