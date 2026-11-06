if(!global.paused && !global.hitPause)
{
	if(yankTarget == -1)
	{
		hsp += decel;

		x += (hsp * xdir);
	}
	
	if(grappleTarget != -1)
	{
		grappleTarget.x += (hsp * xdir);
	}
	
	if(yankTarget != -1)
	{
		yankSpd += yankAccel;
		oPlayer.x += yankSpd * xdir;
	}
}