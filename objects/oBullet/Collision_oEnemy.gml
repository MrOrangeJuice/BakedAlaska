/// @description Hit

ScreenShake(2,10);
other.hp -= damage;
other.shieldHp -= damage;
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
if(other.shieldHp <= 0 && !other.shieldBroken)
{
	for(var i = 0; i < 20; i++)
	{
		instance_create_layer(other.x,other.y,"VFX",oParticleExplode);
	}
	ScreenShake(2,10);
	PlayRandomShieldExplosionSound();
	other.shieldBroken = true;
}
if(other.hp <= 0)
{
	audio_play_sound(snd_Die,5,false);
	ScreenShake(4,20);
	for(var i = 0; i < 20; i++)
	{
		instance_create_layer(other.x,other.y,"VFX",oParticleExplode);
	}
	instance_destroy(other);
}


instance_destroy();
