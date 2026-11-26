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
			canAirDash = true;
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
idleSpr = sAlice;
runSpr = sAliceRun;
jumpSpr = sAliceJump;
fallSpr = sAliceFall;
landSpr = sAliceLand;
slashSpr = sAliceSlash;
stabSpr = sAliceStab;
dashSpr = sAliceDash;

// Moving
face = 1;
moveDir = 0;
moveSpd = 2;
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

// Land
landing = true;
landed = false;

// Sword
canAirDash = true;
slashing = false;
canSlash = 0;
stabbing = false;
dashing = false;
canSpawnHitbox = false;
bufferedStab = false;
attackCooldown = 10;