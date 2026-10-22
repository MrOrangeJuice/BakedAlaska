/// @description Hitflash

if(flash > 0)
{
	shader_set(shHit);
	draw_self();
	shader_reset();
}
else
{
	if(shieldHp > 0)
	{
		shader_set(shShield);
		draw_sprite_ext(sprite_index,image_index,x,y+1,1,1,image_angle,#f0d7b1,image_alpha);
		draw_sprite_ext(sprite_index,image_index,x,y-1,1,1,image_angle,#f0d7b1,image_alpha);
		draw_sprite_ext(sprite_index,image_index,x-1,y,1,1,image_angle,#f0d7b1,image_alpha);
		draw_sprite_ext(sprite_index,image_index,x+1,y,1,1,image_angle,#f0d7b1,image_alpha);
		shader_reset();
	}
	
	draw_self();
}