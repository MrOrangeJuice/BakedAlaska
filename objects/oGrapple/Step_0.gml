if(!global.paused && !global.hitPause)
{
	hsp += decel;

	x += (hsp * xdir);
	
	if(grappleTarget != -1)
	{
		grappleTarget.x += (hsp * xdir);
	}
}