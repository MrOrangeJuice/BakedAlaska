/// @description Hit

ScreenShake(2,10);
other.hp--;
other.flash = 5;
audio_play_sound(snd_Hit,5,false);
if(xdir = 1)
{
	instance_create_layer(other.x-2,other.y+8,"VFX",oHitStabVFX);
	for(var i = 0; i < 5; i++)
	{
		instance_create_layer(other.x+8,other.y+8,"VFX",oParticleStabVFXRight);
	}
}
else if(xdir = -1)
{
	instance_create_layer(other.x+18,other.y+8,"VFX",oHitStabVFXLeft);
	for(var i = 0; i < 5; i++)
	{
		instance_create_layer(other.x+8,other.y+8,"VFX",oParticleStabVFXLeft);
	}
}
if(other.hp <= 0)
{
	audio_play_sound(snd_Die,5,false);
	for(var i = 0; i < 20; i++)
	{
		instance_create_layer(other.x+8,other.y+8,"VFX",oParticleExplode);
	}
	instance_destroy(other);
}

instance_destroy();
