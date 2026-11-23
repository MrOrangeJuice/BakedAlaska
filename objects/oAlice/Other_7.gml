if(sprite_index == landSpr)
{
	landing = false;
}

if(sprite_index == slashSpr)
{
	slashing = false;	
	canSlash = true;
	if(instance_exists(oEnemy)) oEnemy.canHit = true;
	if(instance_exists(oSlashHitbox)) instance_destroy(oSlashHitbox);
	if(instance_exists(oSlashHitboxLeft)) instance_destroy(oSlashHitboxLeft);
	canSpawnHitbox = false;
}