if(canHit)
{
	canHit = false;
	
	var hitBlocked = false;
	
	// Create VFX
	if(other.object_index == oSlashHitbox)
	{
		hp -= 2;
		shieldHp -= 2;
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
		hp -= 2;
		shieldHp -= 2;
		flash = 5;
		PlayRandomSwordHitSound();
		instance_create_layer(x,y,"Instances",oHitstopQuick);
		instance_create_layer(x+14,y,"VFX",oHitStabGreenVFXLeft);
		for(var i = 0; i < 5; i++)
		{
			instance_create_layer(x,y,"VFX",oParticleStabGreenVFXLeft);
		}
	}
	if(other.object_index == oStabHitbox)
	{
		instance_create_layer(x-14,y,"VFX",oHitStabOrangeVFX);
		if(shieldBroken)
		{
			hp -= 6;
			flash = 5;
			PlayRandomStabHitSound();
			for(var i = 0; i < 5; i++)
			{
				instance_create_layer(x,y,"VFX",oParticleStabVFXRight);
			}
		}
		else
		{
			hitBlocked = true;	
		}
	}
	if(other.object_index == oStabHitboxLeft)
	{
		instance_create_layer(x+14,y,"VFX",oHitStabVFXLeft);
		if(shieldBroken)
		{
			hp -= 6;
			flash = 5;
			PlayRandomStabHitSound();
			for(var i = 0; i < 5; i++)
			{
				instance_create_layer(x,y,"VFX",oParticleStabVFXLeft);
			}
		}
		else
		{
			hitBlocked = true;
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
	else
	{
		if(!hitBlocked)
		{
			instance_create_layer(x,y,"Instances",oHitstopQuick);
			ScreenShake(2,10);
		}
		else
		{
			audio_play_sound(snd_Klang,5,false);	
		}
	}
}