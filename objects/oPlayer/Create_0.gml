/// @description Setup Variables

// Custom functions for player
function SetOnGround(_val = true)
{
	if _val == true
	{
		onGround = true;
		coyoteHangTimer = coyoteHangFrames;
		if(!landed)
		{
			landed = true;
			landing = true;
			//instance_create_layer(x,y,"VFX",oLandVFX);
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

// Controls Setup
controlsSetup();

// Sprites
idleSpr = sBlitz;
runSpr = sBlitzRun;
jumpSpr = sBlitzJump;
fallSpr = sBlitzFall;
landSpr = sBlitzLand;

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

// Attack
bullet = -1;
shootTimer = 0;
shootCooldown = 12;

// Land
landing = true;
landed = false;