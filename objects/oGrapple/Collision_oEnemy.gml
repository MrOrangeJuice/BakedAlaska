if(grappleTarget == -1 && other.shieldHp <= 0)
{
	hsp = 0;
	other.grappled = true;
	instance_create_layer(x,y,"Instances",oHitstop);
	grappleTarget = other;
	
	ScreenShake(2,10);
	other.flash = 5;
	audio_play_sound(snd_Hit,5,false);
	if(xdir = 1)
	{
		instance_create_layer(other.x-10,other.y,"VFX",oHitStabVFX);
		for(var i = 0; i < 5; i++)
		{
			instance_create_layer(other.x,other.y,"VFX",oParticleStabVFXRight);
		}
	}
	else if(xdir = -1)
	{
		instance_create_layer(other.x+10,other.y,"VFX",oHitStabVFXLeft);
		for(var i = 0; i < 5; i++)
		{
			instance_create_layer(other.x,other.y,"VFX",oParticleStabVFXLeft);
		}
	}
}