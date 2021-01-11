//speed values
spd = 3; //max speed
spdnow = 0; //current speed
rollspd = 4; // roll speed

//values for player jumping
grav = 0.2;
jump = false;
ver = false;

//values for player rolling
roll = false;
rollnow = 0;
rollcooldown = 0;

//pre values remembered for later
horprev = 0;
prejump = 0;

//the gravity for the player if hes falling without jumping
down = 1;

//the rotation of the player
iimage_angle = image_angle;

surface_resize(application_surface, 3200, 1800);

yy = y;

//window_set_fullscreen(true);