/// @description Update Physics

// Get Inputs
rightKey = keyboard_check(vk_right);
leftKey = keyboard_check(vk_left);
jumpKeyPressed = keyboard_check_pressed(vk_space);

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
	
// Cap falling speed
if (ySpd > termVel)
{
	ySpd = termVel;	
}

// Jump
if(jumpKeyPressed && place_meeting(x,y+1,oWall))
{
	ySpd = jspd;
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

y += ySpd;