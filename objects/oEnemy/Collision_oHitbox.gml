if(canHit)
{
	canHit = false;
	
	var hitBlocked = false;
	
	// Create VFX
	if(other.object_index == oSlashHitbox)
	{
		hp--;
		shieldHp--;
		flash = 5;
		PlayRandomSwordHitSound();
		instance_create_layer(x,y,"Instances",oHitstopQuick);
		instance_create_layer(x-14,y,"VFX",oHitStabGreenVFX);
		for(var i = 0; i < 5; i++)
		{
			instance_create_layer(x,y,"VFX",oParticleStabGreenVFXRight);
		}
	}
	if(other.object_index == oSlashHitboxLeft)
	{
		hp--;
		shieldHp--;
		flash = 5;
		PlayRandomSwordHitSound();
		instance_create_layer(x,y,"Instances",oHitstopQuick);
		instance_create_layer(x+14,y,"VFX",oHitStabGreenVFXLeft);
		for(var i = 0; i < 5; i++)
		{
			instance_create_layer(x,y,"VFX",oParticleStabGreenVFXLeft);
		}
	}
	if(hp <= 0)
	{
		for(var i = 0; i < 20; i++)
		{
			instance_create_layer(x,y,"VFX",oParticleExplode);
		}
		instance_create_layer(x,y,"Instances",oHitstopLong);
		ScreenShake(5,20);
		instance_create_layer(x,y,"VFX",oDeathVFX);
		audio_play_sound(snd_Die,5,false);
		instance_destroy();
	}
	else if(shieldHp <= 0 && !shieldBroken)
	{
		for(var i = 0; i < 20; i++)
		{
			instance_create_layer(x,y,"VFX",oParticleExplode);
		}
		instance_create_layer(x,y,"Instances",oHitstopLong);
		ScreenShake(4,20);
		PlayRandomShieldExplosionSound();
		shieldBroken = true;
	}
}