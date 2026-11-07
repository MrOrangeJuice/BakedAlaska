if(yankTarget == -1)
{
	hsp = 0;
	oPlayer.yanking = true;
	oPlayer.canAirGrapple = true;
	instance_create_layer(x,y,"Instances",oHitstop);
	
	yankTarget = other;
	
	ScreenShake(2,10);
	audio_play_sound(snd_Hit,5,false);
	other.flash = 5;
	
	if(xdir = 1)
	{
		instance_create_layer(other.x-12,other.y,"VFX",oHitStabVFX);
		for(var i = 0; i < 5; i++)
		{
			instance_create_layer(other.x+2,other.y,"VFX",oParticleStabVFXRight);
		}
	}
	else if(xdir = -1)
	{
		instance_create_layer(other.x+12,other.y,"VFX",oHitStabVFXLeft);
		for(var i = 0; i < 5; i++)
		{
			instance_create_layer(other.x-2,other.y,"VFX",oParticleStabVFXLeft);
		}
	}
}