function PlayRandomSwordHitSound()
{
	var rand = irandom_range(1,5);
	
	switch(rand)
	{
		case 1:
			audio_play_sound(sndSpear1,5,false);
			break;
		case 2:
			audio_play_sound(sndSpear2,5,false);
			break;
		case 3:
			audio_play_sound(sndSpear3,5,false);
			break;
		case 4:
			audio_play_sound(sndSpear4,5,false);
			break;
		case 5:
			audio_play_sound(sndSpear5,5,false);
			break;
			
	}
}