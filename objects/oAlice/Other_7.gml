if(sprite_index == landSpr)
{
	landing = false;
}

if(slashing || stabbing)
{
	slashing = false;	
	stabbing = false;
	canSlash = true;
	if(instance_exists(oEnemy)) oEnemy.canHit = true;
	if(instance_exists(oTarget)) oTarget.canHit = true;
	if(instance_exists(oSlashHitbox)) instance_destroy(oSlashHitbox);
	if(instance_exists(oSlashHitboxLeft)) instance_destroy(oSlashHitboxLeft);
	if(instance_exists(oStabHitbox)) instance_destroy(oStabHitbox);
	if(instance_exists(oStabHitboxLeft)) instance_destroy(oStabHitboxLeft);
	canSpawnHitbox = false;
}