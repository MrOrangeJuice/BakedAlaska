function PlayRandomSwordSound()
{
	var rand = irandom_range(1,9);
	
	switch(rand)
	{
		case 1:
			audio_play_sound(sndJump1,5,false);
			break;
		case 2:
			audio_play_sound(sndJump2,5,false);
			break;
		case 3:
			audio_play_sound(sndJump3,5,false);
			break;
		case 4:
			audio_play_sound(sndJump4,5,false);
			break;
		case 5:
			audio_play_sound(sndJump5,5,false);
			break;
		case 6:
			audio_play_sound(sndJump6,5,false);
			break;
		case 7:
			audio_play_sound(sndJump7,5,false);
			break;
		case 8:
			audio_play_sound(sndJump8,5,false);
			break;
		case 9:
			audio_play_sound(sndJump9,5,false);
			break;
			
	}
}