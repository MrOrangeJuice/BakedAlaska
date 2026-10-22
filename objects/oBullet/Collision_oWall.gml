/// @description Destroy

if(xdir = 1)
{
	instance_create_layer(x,y,"VFX",oHitStabVFX);
}
else if(xdir = -1)
{
	instance_create_layer(x,y,"VFX",oHitStabVFXLeft);
}

instance_destroy();