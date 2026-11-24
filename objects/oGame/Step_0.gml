if(keyboard_check_pressed(vk_escape))
{
	if(global.paused)
		global.paused = false;
	else if(!global.paused)
		global.paused = true;
}