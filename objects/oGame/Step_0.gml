if(keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(0,gp_start))
{
	if(global.paused)
	{
		global.paused = false;
		audio_play_sound(snd_PauseOut,5,false);
	}
	else if(!global.paused)
	{
		global.paused = true;
		audio_play_sound(snd_PauseIn,5,false);
	}
}