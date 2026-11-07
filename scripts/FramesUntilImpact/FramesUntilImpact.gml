function FramesUntilImpact(playerX,enemyX,grappleSpd)
{
	var distance = abs(playerX - enemyX);
	
	var frames = 0;
	var distanceClosed = 0;
	
	while(distanceClosed < distance)
	{
		distanceClosed += grappleSpd;
		grappleSpd += 0.5;
		frames++;
	}
	
	return frames;
}