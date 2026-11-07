if(yankTarget != -1)
{
	oPlayer.yanking = false;
	oPlayer.grappling = false;
	
	oPlayer.x = yankTarget.x - (4 * xdir);
	oPlayer.y = yankTarget.y - 8;
	
	// Pop player
	with(oPlayer)
	{
		jumpKeyBuffered = false;
		jumpKeyBufferTimer = 0;
	
		jumpCount++;
	
		ySpd = jspd * 2;
		
		SetOnGround(false);
		
		alarm[0] = room_speed * 0.2;
		shootingDown = true;
	}
	
	audio_play_sound(snd_Hit,5,false);
	audio_play_sound(snd_Shoot,5,false);
	audio_play_sound(snd_Die,5,false);
	ScreenShake(2,10);
	yankTarget.flash = 5;
	yankTarget.hp--;
	
	for(var i = 0; i < 20; i++)
	{
		instance_create_layer(yankTarget.x,yankTarget.y,"VFX",oParticleStabVFXDown);
	}
	
	instance_create_layer(x,y,"Instances",oHitstop);
	
	instance_destroy();
}
else
{
	if(hsp <= 0)
	{
		with(oPlayer)
		{
			grappling = false;
			shootingForward = true;
			alarm[0] = room_speed * 0.2;
		}
		
		if(grappleTarget != -1)
		{
			enemyProj = instance_create_layer(grappleTarget.x,grappleTarget.y,"Instances",oEnemyProj);
			enemyProj.xdir = xdir;
			enemyProj.image_xscale = xdir;
			grappleTarget.flash = 5;
			audio_play_sound(snd_Hit,5,false);
			audio_play_sound(snd_Shoot,5,false);
			audio_play_sound(snd_Die,5,false);
			ScreenShake(4,20);
			instance_create_layer(x,y,"Instances",oHitstop);
			if(xdir == 1)
			{
				instance_create_layer(grappleTarget.x-10,grappleTarget.y,"VFX",oHitStabVFX);
				for(var i = 0; i < 20; i++)
				{
					instance_create_layer(grappleTarget.x,grappleTarget.y,"VFX",oParticleStabVFXRight);
				}
			}
			else if(xdir == -1)
			{
				instance_create_layer(grappleTarget.x+10,grappleTarget.y,"VFX",oHitStabVFXLeft);
				for(var i = 0; i < 20; i++)
				{
					instance_create_layer(grappleTarget.x,grappleTarget.y,"VFX",oParticleStabVFXLeft);
				}
			}
		
			instance_destroy(grappleTarget);
			grappleTarget = -1;
		}
		instance_destroy();
	}
}