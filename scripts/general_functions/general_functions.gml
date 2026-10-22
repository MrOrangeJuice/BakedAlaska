function controlsSetup()
{
	jumpBufferTime = 10;
	
	jumpKeyBuffered = 0;
	jumpKeyBufferTimer = 0;
	
	superBufferTime = 10;
	
	superKeyBuffered = 0;
	superKeyBufferTimer = 0;
}

function getControls()
{
	// Get Inputs
	// Directional Inputs
	rightKey = keyboard_check(vk_right) || keyboard_check(ord("D")) || gamepad_button_check(0,gp_padr);
	leftKey = keyboard_check(vk_left) || keyboard_check(ord("A")) || gamepad_button_check(0,gp_padl);
	
	// Action Inputs
	jumpKeyPressed = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0,gp_face1) || keyboard_check_pressed(ord("P")) || keyboard_check_pressed(ord("Z"));
	jumpKey = keyboard_check(vk_space) || gamepad_button_check(0,gp_face1) || keyboard_check(ord("P")) || keyboard_check(ord("Z"));
	attackKey = keyboard_check(ord("O")) || keyboard_check(ord("X")) || mouse_check_button(mb_left) || gamepad_button_check(0,gp_face2);
	superKeyPressed = keyboard_check_pressed(ord("I")) || keyboard_check_pressed(vk_lshift) || mouse_check_button_pressed(mb_right) || gamepad_button_check_pressed(0,gp_face3); 
	
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