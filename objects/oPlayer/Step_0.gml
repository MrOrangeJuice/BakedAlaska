/// @description Update Physics

getControls();

// X Movement
moveDir = rightKey - leftKey;

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
ySpd += grav;

// Jump
if(jumpKeyBuffered && onGround)
{
	// Reset Buffer
	jumpKeyBuffered = false;
	jumpKeyBufferTimer = 0;
	ySpd = jspd;
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
	
	// "Collide"
	ySpd = 0;
}

// Check if on ground
if(place_meeting(x,y+1,oWall))
{
	onGround = true;	
}
else
{
	onGround = false;	
}

y += ySpd;