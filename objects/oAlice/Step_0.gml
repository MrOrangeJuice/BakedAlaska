/// @description Update Physics


if(!global.paused && !global.hitPause)
{
	image_speed = 1;
	
	getControls();

	// X Movement
	moveDir = rightKey - leftKey;
	// Get my face
	if (moveDir != 0 && !slashing && !dashing)
		face = moveDir;

	// Get XSpd
	if(xSpd == 0 && moveDir != 0 && !slashing && !dashing)
		image_index = 0;
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
	else
	{
		airborne = true;
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

	y += ySpd;
	
	// Attack
	if (attackKeyBuffered && canSlash)
	{
		// Reset Buffer
		attackKeyBuffered = false;
		attackKeyBufferTimer = 0;
		canSlash = false;
		PlayRandomSwordSound();
		slashing = true;
		alarm[0] = room_speed * 0.125;
		image_index = 0;
	}
	
	// Attack hitbox
	if(slashing && canSpawnHitbox)
	{
		if(face == 1)
		{
			if(!instance_exists(oSlashHitbox))
			{
				instance_create_layer(x,y,"Instances",oSlashHitbox);
			}
		}
		else if(face == -1)
		{
			if(!instance_exists(oSlashHitboxLeft))
			{
				instance_create_layer(x,y,"Instances",oSlashHitboxLeft);
			}
		}
	}
	
	// Dash
	if (superKeyBuffered)
	{
		// Reset Buffer
		superKeyBuffered = false;
		superKeyBufferTimer = 0;
		
		if(airborne)
			canAirDash = false;
			
		dashing = true;
	}
	
	// Switch
	if(switchKeyPressed && !slashing)
	{
		newPlayer = instance_create_layer(x,y,"Instances",oBlitz);	
		newPlayer.xSpd = xSpd;
		newPlayer.ySpd = ySpd;
		newPlayer.face = face;
		if(instance_exists(oSlashHitbox)) instance_destroy(oSlashHitbox);
		if(instance_exists(oSlashHitboxLeft)) instance_destroy(oSlashHitboxLeft);
		instance_destroy();
	}
}
else
{
	image_speed = 0;
	alarm[0]++;
}

// Sprite Control
if(abs(xSpd) > 0)
{	
	if(slashing)
		sprite_index = slashSpr;
	else if(landing)
		sprite_index = landSpr;	
	else
		sprite_index = runSpr;	
}
if(xSpd == 0)
{
	if(slashing)
		sprite_index = slashSpr;
	else if(landing)
		sprite_index = landSpr;	
	else
		sprite_index = idleSpr;
}
if(!onGround)
{
	if(slashing)
		sprite_index = slashSpr;
	else
		if(ySpd > 0)
			sprite_index = fallSpr;
		else
			sprite_index = jumpSpr;
}