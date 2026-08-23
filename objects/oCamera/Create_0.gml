/// @description Initialize Variables

// Camera admin
cam = view_camera[0];

follow = oPlayer;
view_w_half = camera_get_view_width(cam)/2;
view_h_half = camera_get_view_height(cam)/2;
global.cur_adjust = noone;

// Coordinates
x_to = 0;
y_to = 0;
	
// Clamp
left_clamp = false;
right_clamp = false;
top_clamp = false;
bottom_clamp = false;