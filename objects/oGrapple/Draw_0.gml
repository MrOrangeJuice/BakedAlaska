/// @description Draw Line

draw_self();

if(instance_exists(oBlitz))
{
	draw_line_width_colour(x+(-5*xdir),y,oBlitz.x+(oBlitz.face * 4),oBlitz.y-6,2,#16171A,#16171A);	
}