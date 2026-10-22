/// @description Hit

ScreenShake(2,10);
other.hp -= 1 + oBattleSystem.damageUpgrade;
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
if(other.hp <= 0)
{
	audio_play_sound(snd_Die,5,false);
	for(var i = 0; i < 20; i++)
	{
		instance_create_layer(other.x,other.y,"VFX",oParticleExplode);
	}
	instance_destroy(other);
	
	if(other.object_index == oTankEnemy || other.object_index == oCowboy || other.object_index == oWrenchEnemy)
	{
		global.enemiesLeft--;
	}
	
	if(global.enemiesLeft <= 0 && (other.object_index == oTankEnemy || other.object_index == oCowboy || other.object_index == oWrenchEnemy))
	{
		instance_create_layer(0,0,"Instances",oHitstopEnd);
		audio_play_sound(snd_Upgrade,5,false);
	}
}

instance_destroy();
