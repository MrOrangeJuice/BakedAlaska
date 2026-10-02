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
downSlopeSemiSolid = noone;
if (ySpd >= 0 && !place_meeting(x + xSpd, y + 1, oWall) && place_meeting(x + xSpd, y + abs(xSpd) + 1, oWall))
{
	// Check for a semisolid in the way
	downSlopeSemiSolid = CheckForSemiSolidPlatform(x + xSpd, y + abs(xSpd) + 1);
	// Precisely move down slope if there isn't a semisolid in the way
	if (!instance_exists(downSlopeSemiSolid))
	{
		while (!place_meeting(x + xSpd, y + _subPixel, oWall))
		{
			y += _subPixel;	
		}
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

// Initiate Jump
// Check for solid floor
var _floorIsSolid = false;
if ((instance_exists(myFloorPlat)) && (myFloorPlat.object_index == oWall || object_is_ancestor(myFloorPlat.object_index, oWall)))
{
	_floorIsSolid = true;	
}

if(jumpKeyBuffered && jumpCount < jumpMax && (!downKey || _floorIsSolid))
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
/*
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
*/

// Check for solid and semisolid platforms below me
var _clampYSpd = max(0, ySpd);
var _list = ds_list_create(); // Create a list to store all of the objects we run into
var _array = array_create(0);
array_push(_array, oWall, oSemisolidWall);

// Do the actual check and add objects to list
var _listSize = instance_place_list(x, y + 1 + _clampYSpd + termVel, _array, _list, false);

// Fix for high resolution
var _yCheck = y + 1 + _clampYSpd;
if (instance_exists(myFloorPlat))
{
	_yCheck += max(0, myFloorPlat.ySpd);	
}
var _semiSolid = CheckForSemiSolidPlatform(x, _yCheck);

// Loop through colliding instances and only return one if its top is below the player
for(var i = 0; i < _listSize; i++)
{
	// Get an instance of oWall or oSemiSolidWall from the list
	var _listInst = _list[| i];
	
	// Avoid magentism
	if((_listInst != forgetSemiSolid) && ((_listInst.ySpd <= ySpd || instance_exists(myFloorPlat)) && (_listInst.ySpd > 0 || place_meeting(x, y + 1 + _clampYSpd, _listInst))) || (_listInst == _semiSolid))
	{
		// Return a solid wall or any semisolid walls that are below the player
		if (_listInst.object_index == oWall || object_is_ancestor(_listInst.object_index, oWall) || floor(bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.ySpd))
		{
			// Return the highest wall object
			if (!instance_exists(myFloorPlat) || _listInst.bbox_top + _listInst.ySpd <= myFloorPlat.bbox_top + myFloorPlat.ySpd || _listInst.bbox_top + _listInst.ySpd <= bbox_bottom)
			{
				myFloorPlat = _listInst;	
			}
		}
	}
}

// Destroy the list
ds_list_destroy(_list);

// Downslope semisolid for making sure we don't miss semisolids while going down slopes
if (instance_exists(downSlopeSemiSolid))
{
	myFloorPlat = downSlopeSemiSolid;	
}

// One last check to make sure the floor platform is actually below us
if(instance_exists(myFloorPlat) && !place_meeting(x, y + termVel, myFloorPlat))
{
	myFloorPlat = noone;
}

// Land on the ground platform is there is one
if(instance_exists(myFloorPlat))
{
	// Scoot up to wall precisely
	var _subPixel = .1;
	while (!place_meeting(x,y +_subPixel,myFloorPlat) && !place_meeting(x,y,oWall))
	{
		y += _subPixel;	
	}
	
	// Make sure we don't end up below the top of a semisolid
	if (myFloorPlat.object_index == oSemisolidWall || object_is_ancestor(myFloorPlat.object_index, oSemisolidWall))
	{
		while(place_meeting(x,y,myFloorPlat))
		{
			y -= _subPixel;	
		}
	}
	// Floor the y variable
	y = floor(y);
	
	// Collide with the ground
	ySpd = 0;
	SetOnGround();
}

// Manually fall through a semisolid platform
if (downKey && jumpKeyPressed)
{
	// Make sure we have a floor platform that's a semisolid	
	if(instance_exists(myFloorPlat) && (myFloorPlat.object_index == oSemisolidWall || object_is_ancestor(myFloorPlat.object_index, oSemisolidWall)))
	{
		// Check if we CAN go below the semisolid
		var _yCheck = max(1, myFloorPlat.ySpd + 1);
		if(!place_meeting(x, y + _yCheck, oWall))
		{
			// Move below the platform
			y += 1;
			
			// Inherit any downward speed from my floor platform so it doesn't catch me
			ySpd = _yCheck - 1;
			
			// Forget this platform for a time
			forgetSemiSolid = myFloorPlat;
			
			// No more floor platform
			SetOnGround(false);
		}
	}
}

// Move
y += ySpd;

// Reset forgetSemiSolid variable
if (instance_exists(forgetSemiSolid) && !place_meeting(x, y, forgetSemiSolid))
{
	forgetSemiSolid = noone;	
}

// Final moving platform collisions and movement

// X - movePlatXSpd and collision
movePlatXSpd = 0;
if(instance_exists(myFloorPlat))
{
	movePlatXSpd = myFloorPlat.xSpd;
}

if (place_meeting(x + movePlatXSpd, y, oWall))
{
	// Scoot up to wall precisely
	var _subPixel = .1;
	var _pixelCheck = _subPixel * sign(movePlatXSpd);
	while (!place_meeting(x + _pixelCheck, y, oWall))
	{
		x += _pixelCheck;
	}
	
	// Set movePlatXSpd to 0
	movePlatXSpd = 0;
}
// Move
x += movePlatXSpd;

// Y - Snap to myFloorPlat
if(instance_exists(myFloorPlat) && (myFloorPlat.ySpd != 0 || myFloorPlat.object_index == oSemisolidMovingWall || object_is_ancestor(myFloorPlat.object_index, oSemisolidMovingWall)))
{
	// Snap to the top of the floor platform (unfloor our y variable so it's not choppy)
	if(!place_meeting(x,myFloorPlat.bbox_top,oWall) && myFloorPlat.bbox_top >= bbox_bottom-termVel)
	{
		y = myFloorPlat.bbox_top;
	}
	
	// Going up into a solid wall while on a semisolid platform
	if (myFloorPlat.ySpd < 0 && place_meeting(x, y + myFloorPlat.ySpd, oWall))
	{
		// Get pushed down through the semisolid floor platform
		if (myFloorPlat.object_index == oSemisolidWall || object_is_ancestor(myFloorPlat.object_index, oSemisolidWall))
		{
			// Get pushed down
			var _subPixel = .1;
			while(place_meeting(x,y + myFloorPlat.ySpd, oWall))
			{
				y += _subPixel;
			}
			// If we got pushed into a solid wall while going downwards, push ourselves back out
			while(place_meeting(x,y,oWall))
			{
				y -= _subPixel;
			}
			y = round(y);
		}
		
		// Cancel the myFloorPlat variable
		SetOnGround(false);
	}
}

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