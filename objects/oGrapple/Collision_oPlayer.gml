if(hsp <= 0)
{
	oPlayer.grappling = false;
	if(grappleTarget != -1)
	{
		enemyProj = instance_create_layer(grappleTarget.x,grappleTarget.y,"Instances",oEnemyProj);
		enemyProj.xdir = xdir;
		enemyProj.image_xscale = xdir;
		audio_play_sound(snd_Die,5,false);
		ScreenShake(4,20);
		instance_create_layer(x,y,"Instances",oHitstop);
		if(xdir = 1)
		{
			instance_create_layer(grappleTarget.x-10,grappleTarget.y,"VFX",oHitStabVFX);
			for(var i = 0; i < 20; i++)
			{
				instance_create_layer(grappleTarget.x,grappleTarget.y,"VFX",oParticleStabVFXRight);
			}
		}
		else if(xdir = -1)
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