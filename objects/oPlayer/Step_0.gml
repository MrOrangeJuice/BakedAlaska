/// @description Update Physics

getControls();

// X Movement
moveDir = rightKey - leftKey;
// Get my face
if (moveDir != 0)
	face = moveDir;

// Get XSpd
xSpd = moveDir * moveSpd;

// X collision
var _subPixel = .5;
if (place_meeting(x + xSpd,y,oWall))
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
var _subPixel = .5;
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

// Sprite Control
if(abs(xSpd) > 0)
{
	sprite_index = runSpr;	
}
if(xSpd == 0)
{
	sprite_index = idleSpr;	
}
if(!onGround)
{
	sprite_index = jumpSpr;
}