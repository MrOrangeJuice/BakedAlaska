function PlayRandomStabHitSound()
{
	var rand = irandom_range(1,6);
	
	switch(rand)
	{
		case 1:
			audio_play_sound(sndSword1,5,false);
			break;
		case 2:
			audio_play_sound(sndSword2,5,false);
			break;
		case 3:
			audio_play_sound(sndSword3,5,false);
			break;
		case 4:
			audio_play_sound(sndSword4,5,false);
			break;
		case 5:
			audio_play_sound(sndSword5,5,false);
			break;
		case 6:
			audio_play_sound(sndSword6,5,false);
			break;
	}
}