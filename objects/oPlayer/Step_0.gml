/// @description Update Physics


if(!global.paused && !global.hitPause)
{
	image_speed = 1;
	shootTimer--;
	
	getControls();

	// X Movement
	moveDir = rightKey - leftKey;
	// Get my face
	if (moveDir != 0 && !grappling)
		face = moveDir;

	// Get XSpd
	xSpd = moveDir * moveSpd;

	// X collision
	var _subPixel = .1;
	if (place_meeting(x + xSpd,y,oWall))
	{
		// Check if there is a slope to go up
		if (!place_meeting(x + xSpd, y - abs(xSpd)-1,oWall))
		{
			while(place_meeting(x + xSpd, y, oWall))
			{
				y -= _subPixel;	
			}
		}
		// Ceiling slopes, otherwise "No slope" mode
		else
		{
			// Ceiling slopes
			if(!place_meeting(x + xSpd, y + abs(xSpd) + 1, oWall))
			{
				while (place_meeting(x + xSpd, y, oWall))
				{
					y += _subPixel;
				}
			}
			// No slope
			else
			{
				// Scoot up to wall
				var _pixelCheck = _subPixel * sign(xSpd);
				while (!place_meeting(x + _pixelCheck,y,oWall))
				{
					x += _pixelCheck;	
				}
	
				// "Collide"
				xSpd = 0;
			}
		}
	}

	// Go down slopes
	if (ySpd >= 0 && !place_meeting(x + xSpd, y + 1, oWall) && place_meeting(x + xSpd, y + abs(xSpd) + 1, oWall))
	{
		while (!place_meeting(x + xSpd, y + _subPixel, oWall))
		{
			y += _subPixel;
		}
	}

	if(grappling)
		xSpd = 0;
		
	// Move
	x += xSpd;

	// Y Movement
	// Gravity
	if(coyoteHangTimer > 0)
	{
		coyoteHangTimer--;
	}
	else
	{
		ySpd += grav;
		SetOnGround(false);
	}

	// Reset jumping variables
	if(onGround)
	{
		jumpCount = 0;
		coyoteJumpTimer = coyoteJumpFrames;
	}
	else
	{
		coyoteJumpTimer--;
		if (jumpCount == 0 && coyoteJumpTimer <= 0)
		{
			jumpCount = 1;	
		}
	}

	// Check if on ground
	if(place_meeting(x,y+1,oWall))
	{
		SetOnGround();
	}

	// Initiate Jump
	if(jumpKeyBuffered && jumpCount < jumpMax)
	{
		// Reset Buffer
		jumpKeyBuffered = false;
		jumpKeyBufferTimer = 0;
	
		jumpCount++;
	
		ySpd = jspd;
		SetOnGround(false);
		
		audio_play_sound(snd_Jump,5,false);
	}

	// Variable Jump Height
	if (ySpd < 0 && !jumpKey) //if you're moving upwards in the air but not holding down jump
	{
		ySpd *= 0.85; //essentially, divide your vertical speed
	}

	// Cap falling speed
	if (ySpd > termVel)
	{
		ySpd = termVel;	
	}

	// Y Collision
	var _subPixel = .1;
	if (place_meeting(x,y + ySpd,oWall))
	{
		// Scoot up to wall
		var _pixelCheck = _subPixel * sign(ySpd);
		while (!place_meeting(x, y + _pixelCheck, oWall))
		{
			y += _pixelCheck;	
		}
	
		// Bonk code
		if(ySpd < 0)
		{
			ySpd *= 0.85;
		}
	
		// "Collide"
		ySpd = 0;
	}
	
	if(grappling)
		ySpd = 0;

	y += ySpd;
	
	// Shoot
	if (attackKey && shootTimer <= 0)
	{
		shootTimer = shootCooldown;
		bullet = -1;
		bullet = instance_create_layer(x+(8*face),y-5,"Bullets",oBullet);
		if(rightKey)
		{
			bullet.xdir = 1;
			bullet.image_xscale = 1;
			for(var i = 0; i < 3; i++)
			{
				var vfx = instance_create_layer(x+8,y-5,"VFX",oParticleStabVFXRight);
				vfx.particleSpeed += xSpd;
			}
		}
		else if(leftKey)
		{
			bullet.xdir = -1;	
			bullet.image_xscale = -1;
			for(var i = 0; i < 3; i++)
			{
				var vfx = instance_create_layer(x-8,y-5,"VFX",oParticleStabVFXLeft);
				vfx.particleSpeed += abs(xSpd);
			}
		}
		else
		{
			if(face == 1)
			{
				bullet.xdir = 1;
				bullet.image_xscale = 1;
				for(var i = 0; i < 3; i++)
				{
					var vfx = instance_create_layer(x+8,y-5,"VFX",oParticleStabVFXRight);
					vfx.particleSpeed += xSpd;
				}
			}
			else
			{
				bullet.xdir = -1;	
				bullet.image_xscale = -1;
				for(var i = 0; i < 3; i++)
				{
					var vfx = instance_create_layer(x-8,y-5,"VFX",oParticleStabVFXLeft);
					vfx.particleSpeed += abs(xSpd);
				}
			}
		}
		audio_play_sound(snd_Shoot,5,false);
		ScreenShake(1,5);
	}
	
	// Grapple
	if (superKeyPressed && !grappling)
	{
		grappling = true;
		hook = -1;
		hook = instance_create_layer(x+(8*face),y-6,"Grapple",oGrapple);
		if(rightKey)
		{
			hook.xdir = 1;
			hook.image_xscale = 1;
			for(var i = 0; i < 3; i++)
			{
				var vfx = instance_create_layer(x+8,y-6,"VFX",oParticleStabVFXRight);
				vfx.particleSpeed += xSpd;
			}
		}
		else if(leftKey)
		{
			hook.xdir = -1;	
			hook.image_xscale = -1;
			for(var i = 0; i < 3; i++)
			{
				var vfx = instance_create_layer(x-8,y-6,"VFX",oParticleStabVFXLeft);
				vfx.particleSpeed += abs(xSpd);
			}
		}
		else
		{
			if(face == 1)
			{
				hook.xdir = 1;
				hook.image_xscale = 1;
				for(var i = 0; i < 3; i++)
				{
					var vfx = instance_create_layer(x+8,y-6,"VFX",oParticleStabVFXRight);
					vfx.particleSpeed += xSpd;
				}
			}
			else
			{
				hook.xdir = -1;	
				hook.image_xscale = -1;
				for(var i = 0; i < 3; i++)
				{
					var vfx = instance_create_layer(x-8,y-6,"VFX",oParticleStabVFXLeft);
					vfx.particleSpeed += abs(xSpd);
				}
			}
		}
		audio_play_sound(snd_Shoot,5,false);
		ScreenShake(1,5);
	}
}
else
{
	image_speed = 0;
}

// Sprite Control
if(abs(xSpd) > 0)
{
	if(grappling)
		sprite_index = superSpr;
	else if(landing)
		sprite_index = runLandSpr;	
	else
		sprite_index = runSpr;	
}
if(xSpd == 0)
{
	if(grappling)
		sprite_index = superSpr;
	else if(landing)
		sprite_index = landSpr;	
	else
		sprite_index = idleSpr;
}
if(!onGround)
{
	if(ySpd > 0)
		sprite_index = fallSpr;
	else
		sprite_index = jumpSpr;
}