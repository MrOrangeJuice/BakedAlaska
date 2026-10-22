function PlayRandomShieldExplosionSound()
{
	var rand = irandom_range(1,2);
	
	switch(rand)
	{
		case 1:
			audio_play_sound(sndShieldExplosion1,5,false);
			break;
		case 2:
			audio_play_sound(sndShieldExplosion2,5,false);
			break;
	}
}