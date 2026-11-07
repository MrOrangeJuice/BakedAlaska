/// @description Setup Variables

// Custom functions for player
function SetOnGround(_val = true)
{
	if _val == true
	{
		onGround = true;
		coyoteHangTimer = coyoteHangFrames;
		if(!landed && !CheckIfSlope())
		{
			landed = true;
			landing = true;
			canAirGrapple = true;
			airborne = false;
		}
	}
	else
	{
		landed = false;
		landing = false;
		onGround = false;
		coyoteHangTimer = 0;
	}
}

function CheckIfSlope()
{
	if(place_meeting(x,y + ySpd,oSlope0) || place_meeting(x,y + ySpd,oSlope1))
		return true;
	else
		return false;
}

// Controls Setup
controlsSetup();

// Sprites
idleSpr = sBlitz;
runSpr = sBlitzRun;
jumpSpr = sBlitzJump;
fallSpr = sBlitzFall;
landSpr = sBlitzLand;
runLandSpr = sBlitzRunLand;
superSpr = sBlitzGrapple;
superSprFinish = sBlitzGrapplePull;
superSprAir = sBlitzGrappleAir;
superSprAirFinish = sBlitzGrapplePullAir;
yankSpr = sBlitzYank;
shootDownSpr = sBlitzShootDown;
shootForwardSpr = sBlitzShootForward;
shootForwardSprAir = sBlitzShootForwardAir;

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
airborne = false;

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

// Attack
bullet = -1;
shootTimer = 0;
shootCooldown = 12;

// Land
landing = true;
landed = false;

// Grapple
canAirGrapple = true;
grappling = false;
yanking = false;
shootingDown = false;
shootingForward = false;