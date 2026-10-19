function controlsSetup()
{
	jumpBufferTime = 10;
	
	jumpKeyBuffered = 0;
	jumpKeyBufferTimer = 0;
}

function getControls()
{
	// Get Inputs
	// Directional Inputs
	rightKey = keyboard_check(vk_right) || keyboard_check(ord("D")) || gamepad_button_check(0,gp_padr);
	leftKey = keyboard_check(vk_left) || keyboard_check(ord("A")) || gamepad_button_check(0,gp_padl);
	
	// Action Inputs
	jumpKeyPressed = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0,gp_face1);
	jumpKey = keyboard_check(vk_space) || gamepad_button_check(0,gp_face1);
	
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
}