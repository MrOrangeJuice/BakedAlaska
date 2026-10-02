/// @description Setup Variables

// Custom functions for player
function SetOnGround(_val = true)
{
	if _val == true
	{
		onGround = true;
		coyoteHangTimer = coyoteHangFrames;
	}
	else
	{
		onGround = false;
		myFloorPlat = noone;
		coyoteHangTimer = 0;
	}
}

function CheckForSemiSolidPlatform(_x,_y)
{
	// Create a return variable
	var _rtrn = noone;
	
	// We must not be moving upwards, then we check for a normal collision
	if (ySpd >= 0 && place_meeting(_x,_y, oSemisolidWall))
	{
		// Create a ds list to store all colliding instances of oSemiSolidWall
		var _list = ds_list_create();
		var _listSize = instance_place_list(_x,_y,oSemisolidWall,_list,false);
		
		// Loop through the colliding instances and only return one if its top is below the player
		for (var i = 0; i < _listSize; i++)
		{
			var _listInst = _list[| i];
			
			if((!_listInst != forgetSemiSolid) && (floor(bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.ySpd)))
			{
				_rtrn = _listInst;
				i = _listSize;
			}
		}
		
		ds_list_destroy(_list);
	}
	
	return _rtrn;
}

// Controls Setup
controlsSetup();

// Sprites
idleSpr = sBlitz;
runSpr = sBlitzRun;
jumpSpr = sBlitzJump;

// Moving
face = 1;
moveDir = 0;
moveSpd = 2.25;
xSpd = 0;
ySpd = 0;

// Jumping
grav = 0.275;
termVel = 4;
jspd = -5.5;
jumpMax = 1;
jumpCount = 0;
onGround = true;

if(!instance_exists(oPlayerPixel))
{
	instance_create_layer(x,y,layer,oPlayerPixel);	
}

// Coyote Time
// Hang Time
coyoteHangFrames = 5;
coyoteHangTimer = 0;
// Jump buffer time
coyoteJumpFrames = 10;
coyoteJumpTimer = 0;

// Moving platforms
myFloorPlat = noone;
downSlopeSemiSolid = noone;
forgetSemiSolid = noone;
movePlatXSpd = 0;