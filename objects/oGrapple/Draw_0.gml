/// @description Draw Line

draw_self();

if(instance_exists(oPlayer))
{
	draw_line_width_colour(x+(-5*xdir),y,oPlayer.x+(oPlayer.face * 4),oPlayer.y-6,2,c_black,c_black);	
}