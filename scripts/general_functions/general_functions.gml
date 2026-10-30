function controlsSetup()
{
	jumpBufferTime = 10;
	
	jumpKeyBuffered = 0;
	jumpKeyBufferTimer = 0;
	
	superBufferTime = 10;
	
	superKeyBuffered = 0;
	superKeyBufferTimer = 0;
	
	deadZone = 0.2;
}

function getControls()
{
	// Get Inputs
	// Directional Inputs
	rightKey = keyboard_check(vk_right) || keyboard_check(ord("D"));
	leftKey = keyboard_check(vk_left) || keyboard_check(ord("A"));
	
	global.controller = 0;
	
	if(gamepad_button_check(0,gp_padl) || gamepad_axis_value(0,gp_axislh) < -deadZone)
	{
		leftKey = true;
		global.controller = 1;
	}
	
	if(gamepad_button_check(0,gp_padr) || gamepad_axis_value(0,gp_axislh) > deadZone)
	{
		rightKey = true;
		global.controller = 1;
	}
	
	// Action Inputs
	jumpKeyPressed = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("P")) || keyboard_check_pressed(ord("Z"));
	jumpKey = keyboard_check(vk_space) || keyboard_check(ord("P")) || keyboard_check(ord("Z"));
	attackKey = keyboard_check(ord("O")) || keyboard_check(ord("X")) || mouse_check_button(mb_left);
	superKeyPressed = keyboard_check_pressed(ord("I")) || keyboard_check_pressed(ord("C")) || keyboard_check_pressed(vk_lshift) || mouse_check_button_pressed(mb_right); 
	
	global.controller = 0;
	
	if(gamepad_button_check_pressed(0,gp_face1))
	{
		jumpKeyPressed = true;
		global.controller = 1;
	}
	
	if(gamepad_button_check(0,gp_face1))
	{
		jumpKey = true;
		global.controller = 1;
	}
	
	if(gamepad_button_check(0,gp_face3))
	{
		attackKey = true;
		global.controller = 1;
	}
	
	if(gamepad_button_check_pressed(0,gp_face2))
	{
		superKeyPressed = true;
		global.controller = 1;
	}
	
	// Jump Key Buffering
	if(jumpKeyPressed)
	{
		jumpKeyBufferTimer = jumpBufferTime;	
	}
	if(jumpKeyBufferTimer > 0)
	{
		jumpKeyBuffered = 1;
		jumpKeyBufferTimer--;
	}
	else
	{
		jumpKeyBuffered = 0;	
	}
	
	// Super Key Buffering
	if(superKeyPressed)
	{
		superKeyBufferTimer = superBufferTime;	
	}
	if(superKeyBufferTimer > 0)
	{
		superKeyBuffered = 1;
		superKeyBufferTimer--;
	}
	else
	{
		superKeyBuffered = 0;	
	}
}