if(!global.paused && !global.hitPause)
{
	image_speed = 1;
	flash--;
	
	// Sprite Control
	if(grappled)
		sprite_index = hurtSpr;
	else
		sprite_index = idleSpr;
}
else
{
	image_speed = 0;	
}