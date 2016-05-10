////////////////////////////////////////////////////////////////////////////////
//  _____                           _       _    _____      _ _
// |_   _|                         (_)     | |  / ____|    | | |
//   | |  _ __ ___  _ __   ___ _ __ _  __ _| | | |     ___ | | | ___  __ _  ___
//   | | | '_ ` _ \| '_ \ / _ \ '__| |/ _` | | | |    / _ \| | |/ _ \/ _` |/ _ \
//  _| |_| | | | | | |_) |  __/ |  | | (_| | | | |___| (_) | | |  __/ (_| |  __/
// |_____|_| |_| |_| .__/ \___|_|  |_|\__,_|_|  \_____\___/|_|_|\___|\__, |\___|
//                 | |                                                __/ |
//                 |_|                                               |___/
//  _                     _
// | |                   | |
// | |     ___  _ __   __| | ___  _ __
// | |    / _ \| '_ \ / _` |/ _ \| '_ \
// | |___| (_) | | | | (_| | (_) | | | |
// |______\___/|_| |_|\__,_|\___/|_| |_|
//
////////////////////////////////////////////////////////////////////////////////
//  File:           gameengine.c
//  Description:    game engine for the pong/brickbreaker hybrid
//  By:             Aufar Laksana
////////////////////////////////////////////////////////////////////////////////
// This hardware block recieves the y co-ordinate of a red and blue object
// and uses it within the game to control the position of the spaceships.
// it outputs the positions of the spaceship and the meteor. It also outputs
// the state of the 8 planets for each player.
////////////////////////////////////////////////////////////////////////////////

#include "stdio.h"
#include "ac_int.h"


#define COLOR_WL           10
#define PIXEL_WL          (3*COLOR_WL)

#define  COORD_WL          11

#define LEFT 0
#define LEFTUP 1
#define LEFTDOWN 2
#define RIGHT 3
#define RIGHTUP 4
#define RIGHTDOWN 5
#define UP 6 //only used for testing
#define DOWN 7 //only used for testing . Should really make stop 6 so that we would only need 3 bits instead of 4
#define STOP 8

#define X_CENTRE 639
#define Y_CENTRE 511

#define SCREEN_HEIGHT 1023
#define SCREEN_WIDTH 1279

#define PLAYER_HEIGHT 50
#define PLAYER_WIDTH 20 
#define PLAYER1_X 149
#define PLAYER2_X 1089

#define BALL_RADIUS 15

#define PLANET_HEIGHT 63
#define PLANET_WIDTH 30
#define PLANET_P1_X 49
#define PLANET_P2_X 1229

#define PLANET1 63
#define PLANET2 191
#define PLANET3 319
#define PLANET4 447
#define PLANET5 575
#define PLANET6 703
#define PLANET7 831
#define PLANET8 959

#define MOVE 1
#define SPEED 1 

#define MYNUMBER 25000; //how fast ball mvoes essentially
#pragma hls_design top

struct ship {

	ac_int<(COORD_WL), false> x, y;
	ac_int<(COORD_WL), false> height, width;
	ac_int<(1), false> player; // 1 = player 1 on the left, 0 = player 2 on the right         

} player1, player2;

struct meteor {

	ac_int<(COORD_WL), false> x, y;
	ac_int<(COORD_WL), false> radius;
	ac_int<(4), false> direction;

} ameteor;

struct planet {

	ac_int<(COORD_WL), false> x, y;
	ac_int<(1), false> player; //1 = player 1 on the left, 0 = player 2 on the right
	ac_int<(1), false> state; //1 = exists, 0 = dead

};

planet planet1, planet2, planet3, planet4, planet5, planet6, planet7, planet8; //player 1s planets
planet planet21, planet22, planet23, planet24, planet25, planet26, planet27, planet28; //player 2 planets


static ac_int<(20), false> count;




bool ship_meteor_collision(ship ship1, meteor meteor1);
bool wall_meteor_collision(meteor meteor1);
bool planet_meteor_collision(planet planet1, meteor meteor1);

void GameUnit(ac_int<(1), false> restart, ac_int<(16), false> random, ac_int<(COORD_WL), false>  redobjecty, ac_int<(COORD_WL), false>  blueobjecty, ac_int<(COORD_WL), false>  meteorpx, ac_int<(COORD_WL), false>  meteorpy,
	ac_int<(4), false> meteordirectionin, ac_int<(8), false> p1planets, ac_int<(8), false> p2planets, ac_int<(4), false> *meteordirectionout, ac_int<(COORD_WL), false> * player1y,
	ac_int<(COORD_WL), false> * player2y, ac_int<(COORD_WL), false>  * meteorpxout, ac_int<(COORD_WL), false> * meteorpyout,
	ac_int<(1), false> * p1p1, ac_int<(1), false> * p1p2, ac_int<(1), false> * p1p3, ac_int<(1), false> * p1p4, ac_int<(1), false> * p1p5, ac_int<(1), false> * p1p6, ac_int<(1), false> * p1p7, ac_int<(1), false> * p1p8,
	ac_int<(1), false> * p2p1, ac_int<(1), false> * p2p2, ac_int<(1), false> * p2p3, ac_int<(1), false> * p2p4, ac_int<(1), false> * p2p5, ac_int<(1), false> * p2p6, ac_int<(1), false> * p2p7, ac_int<(1), false> * p2p8,
	ac_int<(1), false> * player1score, ac_int<(1), false> * player2score)
{


	ac_int<(20), false> NUMBERBOYS = MYNUMBER;

	int randomnumber = random;


	if (restart == 1) {

		player1.player = 1;
		player1.x = PLAYER1_X;
		player1.y = Y_CENTRE;
		player1.height = PLAYER_HEIGHT;
		player1.width = PLAYER_WIDTH;

		player2.player = 0;
		player2.x = PLAYER2_X;
		player2.y = Y_CENTRE;
		player2.height = PLAYER_HEIGHT;
		player2.width = PLAYER_WIDTH;

		ameteor.x = X_CENTRE;
		ameteor.y = Y_CENTRE;
		ameteor.radius = BALL_RADIUS;
		ameteor.direction = STOP;

		//player1 planets
		planet1.x = PLANET_P1_X;
		planet1.y = PLANET1;
		planet1.player = 1;
		planet1.state = 1;

		planet2.x = PLANET_P1_X;
		planet2.y = PLANET2;
		planet2.player = 1;
		planet2.state = 1;

		planet3.x = PLANET_P1_X;
		planet3.y = PLANET3;
		planet3.player = 1;
		planet3.state = 1;

		planet4.x = PLANET_P1_X;
		planet4.y = PLANET4;
		planet4.player = 1;
		planet4.state = 1;

		planet5.x = PLANET_P1_X;
		planet5.y = PLANET5;
		planet5.player = 1;
		planet5.state = 1;

		planet6.x = PLANET_P1_X;
		planet6.y = PLANET6;
		planet6.player = 1;
		planet6.state = 1;

		planet7.x = PLANET_P1_X;
		planet7.y = PLANET7;
		planet7.player = 1;
		planet7.state = 1;

		planet8.x = PLANET_P1_X;
		planet8.y = PLANET8;
		planet8.player = 1;
		planet8.state = 1;
		//player2 planets
		planet21.x = PLANET_P2_X;
		planet21.y = PLANET1;
		planet21.player = 0;
		planet21.state = 1;

		planet22.x = PLANET_P2_X;
		planet22.y = PLANET2;
		planet22.player = 0;
		planet22.state = 1;

		planet23.x = PLANET_P2_X;
		planet23.y = PLANET3;
		planet23.player = 0;
		planet23.state = 1;

		planet24.x = PLANET_P2_X;
		planet24.y = PLANET4;
		planet24.player = 0;
		planet24.state = 1;

		planet25.x = PLANET_P2_X;
		planet25.y = PLANET5;
		planet25.player = 0;
		planet25.state = 1;

		planet26.x = PLANET_P2_X;
		planet26.y = PLANET6;
		planet26.player = 0;
		planet26.state = 1;

		planet27.x = PLANET_P2_X;
		planet27.y = PLANET7;
		planet27.player = 0;
		planet27.state = 1;

		planet28.x = PLANET_P2_X;
		planet28.y = PLANET8;
		planet28.player = 0;
		planet28.state = 1;


	}
	else {

		player1.y = redobjecty;
		player2.y = blueobjecty;

		ameteor.x = meteorpx;
		ameteor.y = meteorpy;
		ameteor.direction = meteordirectionin;

		planet1.state = (p1planets).slc<1>(0);
		planet2.state = (p1planets).slc<1>(1);
		planet3.state = (p1planets).slc<1>(2);
		planet4.state = (p1planets).slc<1>(3);
		planet5.state = (p1planets).slc<1>(4);
		planet6.state = (p1planets).slc<1>(5);
		planet7.state = (p1planets).slc<1>(6);
		planet8.state = (p1planets).slc<1>(7);

		planet21.state = (p2planets).slc<1>(0);
		planet22.state = (p2planets).slc<1>(1);
		planet23.state = (p2planets).slc<1>(2);
		planet24.state = (p2planets).slc<1>(3);
		planet25.state = (p2planets).slc<1>(4);
		planet26.state = (p2planets).slc<1>(5);
		planet27.state = (p2planets).slc<1>(6);
		planet28.state = (p2planets).slc<1>(7);


		if (planet_meteor_collision(planet1, ameteor) == true) {
			planet1.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
			ameteor.direction = random%6;   
		}
		else if (planet_meteor_collision(planet2, ameteor) == true) {
			planet2.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
			ameteor.direction = random%6;   
		}
		else if (planet_meteor_collision(planet3, ameteor) == true) {
			planet3.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
			ameteor.direction = random%6;   
		}
		else if (planet_meteor_collision(planet4, ameteor) == true) {
			planet4.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
			ameteor.direction = random%6;   
		}
		else if (planet_meteor_collision(planet5, ameteor) == true) {
			planet5.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
			ameteor.direction = random%6;   
		}
		else if (planet_meteor_collision(planet6, ameteor) == true) {
			planet6.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
		}
		else if (planet_meteor_collision(planet7, ameteor) == true) {
			planet7.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
			ameteor.direction = random%6;   
		}
		else if (planet_meteor_collision(planet8, ameteor) == true) {
			planet8.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
			ameteor.direction = random%6;   
		}
		else if (planet_meteor_collision(planet21, ameteor) == true) {
			planet21.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
			ameteor.direction = random%6;   
		}
		else if (planet_meteor_collision(planet22, ameteor) == true) {
			planet22.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
			ameteor.direction = random%6;   
		}
		else if (planet_meteor_collision(planet23, ameteor) == true) {
			planet23.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
			ameteor.direction = random%6;   
		}
		else if (planet_meteor_collision(planet24, ameteor) == true) {
			planet24.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
			ameteor.direction = random%6;   
		}
		else if (planet_meteor_collision(planet25, ameteor) == true) {
			planet25.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
			ameteor.direction = random%6;   
		}
		else if (planet_meteor_collision(planet26, ameteor) == true) {
			planet26.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
			ameteor.direction = random%6;   
		}
		else if (planet_meteor_collision(planet27, ameteor) == true) {
			planet27.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
			ameteor.direction = random%6;   
		}
		else if (planet_meteor_collision(planet28, ameteor) == true) {
			planet28.state = 0;
			ameteor.x = X_CENTRE;
			ameteor.y = Y_CENTRE;
			ameteor.direction = random%6;   
		}
		else if(ameteor.x == 0){
		    ameteor.x = X_CENTRE;
		    ameteor.y = Y_CENTRE;
		    ameteor.direction = random%6;
		    *player1score = 1;
		}
		else if(ameteor.x == SCREEN_WIDTH){
		    ameteor.x = X_CENTRE;
		    ameteor.y = Y_CENTRE;
		    ameteor.direction = random%6;
		    *player2score = 1;
		}
		else {
		    *player1score = 0;
		    *player2score = 0;
		}




		if (ameteor.direction == LEFT) {

			if (ship_meteor_collision(player1, ameteor) == true) {

				ameteor.direction = (random % 3) + 3;

			}
			else {

				if (count == NUMBERBOYS) {
					ameteor.x = ameteor.x - SPEED;
					count = 0;
				}
				else {
					count++;
				}

			}

		}
		else if (ameteor.direction == LEFTDOWN) {

			if (ship_meteor_collision(player1, ameteor) == true) {
				ameteor.direction = (random % 3) + 3;
			}
			else if (wall_meteor_collision(ameteor) == true) {
				ameteor.direction = LEFTUP;
				ameteor.x = ameteor.x - SPEED;
				ameteor.y = ameteor.y - SPEED;
			}
			else {

				if (count == NUMBERBOYS) {
					ameteor.x = ameteor.x - SPEED;
					ameteor.y = ameteor.y + SPEED;
					count = 0;
				}
				else {
					count++;
				}

			}
		}
		else if (ameteor.direction == LEFTUP) {

			if (ship_meteor_collision(player1, ameteor) == true) {
				ameteor.direction = (random % 3) + 3;
			}
			else if (wall_meteor_collision(ameteor) == true) {
				ameteor.direction = LEFTDOWN;
				ameteor.x = ameteor.x - SPEED;
				ameteor.y = ameteor.y + SPEED;
			}
			else {
				if (count == NUMBERBOYS) {
					ameteor.x = ameteor.x - SPEED;
					ameteor.y = ameteor.y - SPEED;
					count = 0;
				}
				else {
					count++;
				}
			}
		}
		else if (ameteor.direction == RIGHT) {

			if (ship_meteor_collision(player2, ameteor) == true) {
				ameteor.direction = random % 3;
			}
			else {
				if (count == NUMBERBOYS) {
					ameteor.x = ameteor.x + SPEED;
					count = 0;
				}
				else {
					count++;
				}
			}
		}
		else if (ameteor.direction == RIGHTUP) {

			if (ship_meteor_collision(player2, ameteor) == true) {
				ameteor.direction = random % 3;
			}
			else if (wall_meteor_collision(ameteor) == true) {
				ameteor.direction = RIGHTDOWN;
				ameteor.x = ameteor.x + SPEED;
				ameteor.y = ameteor.y + SPEED;
			}
			else {
				if (count == NUMBERBOYS) {
					ameteor.x = ameteor.x + SPEED;
					ameteor.y = ameteor.y - SPEED;
					count = 0;
				}
				else {
					count++;
				}
			}
		}
		else if (ameteor.direction == RIGHTDOWN) {
			if (ship_meteor_collision(player2, ameteor) == true) {
				ameteor.direction = random % 3;
			}
			else if (wall_meteor_collision(ameteor) == true) {
				ameteor.direction = RIGHTUP;
				ameteor.x = ameteor.x + SPEED;
				ameteor.y = ameteor.y - SPEED;
			}
			else {
				if (count == NUMBERBOYS) {
					ameteor.x = ameteor.x + SPEED;
					ameteor.y = ameteor.y + SPEED;
					count = 0;
				}
				else {
					count++;
				}
			}
		}
		else {
			ameteor.direction = random % 6;
		}

	}


	*player1y = player1.y;
	*player2y = player2.y;

	*meteorpxout = ameteor.x;
	*meteorpyout = ameteor.y;
	*meteordirectionout = ameteor.direction;

	*p1p1 = planet1.state;
	*p1p2 = planet2.state;
	*p1p3 = planet3.state;
	*p1p4 = planet4.state;
	*p1p5 = planet5.state;
	*p1p6 = planet6.state;
	*p1p7 = planet7.state;
	*p1p8 = planet8.state;

	*p2p1 = planet21.state;
	*p2p2 = planet22.state;
	*p2p3 = planet23.state;
	*p2p4 = planet24.state;
	*p2p5 = planet25.state;
	*p2p6 = planet26.state;
	*p2p7 = planet27.state;
	*p2p8 = planet28.state;


}







bool ship_meteor_collision(ship ship1, meteor meteor1) {

	if (ship1.player == 1) { //player1

		if ((meteor1.x - meteor1.radius == ship1.x + ship1.width) && (meteor1.y >= ship1.y - ship1.height) && (meteor1.y <= ship1.y + ship1.height)) {
			return true;
		}
		else {
			return false;
		}

	}
	else { //player2
		if ((meteor1.x + meteor1.radius == ship1.x - ship1.width) && (meteor1.y >= ship1.y - ship1.height) && (meteor1.y <= ship1.y + ship1.height)) {
			return true;
		}
		else {
			return false;
		}
	}
}

bool wall_meteor_collision(meteor meteor1) {

	if ((meteor1.y - meteor1.radius == 0) || (meteor1.y + meteor1.radius == SCREEN_HEIGHT)) {
		return true;
	}
	else {
		return false;
	}

}

bool planet_meteor_collision(planet planet1, meteor meteor1) {

                
                	if (planet1.state == 1) {

		if ((planet1.player) == 1) {

			if ((meteor1.x - meteor1.radius == planet1.x + PLANET_WIDTH) && (meteor1.y >= planet1.y - PLANET_HEIGHT) && (meteor1.y <= planet1.y + PLANET_HEIGHT + 1)) {
				return true;
			}
			else {
				return false;
			}

		}
		else {

			if ((meteor1.x + meteor1.radius == planet1.x - PLANET_WIDTH) && (meteor1.y >= planet1.y - PLANET_HEIGHT) && (meteor1.y <= planet1.y + PLANET_HEIGHT + 1)) {
				return true;
			}
			else {
				return false;
			}

		}

	}
	else {

		return false;

	}
}
