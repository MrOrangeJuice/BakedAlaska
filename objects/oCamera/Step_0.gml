/// @description Update Camera

// Declare step variables
var _x_offset = 0;
var _x_min = view_w_half;
var _x_max = room_width - view_w_half;

var _y_offset = 0;
var _y_min = view_h_half;
var _y_max = room_height - view_h_half;

var _ca = global.cur_adjust;

// Assign adjustment
if (_ca != noone)
{
	_x_offset = _ca.x_offset;
	_y_offset = _ca.y_offset;
	
	if(_ca.left_clamp)
	{
		_x_min = _ca.x + view_w_half;	
	}
	if(_ca.right_clamp)
	{
		_x_max = _ca.x + _ca.sprite_width - view_w_half;	
	}
	if(_ca.top_clamp)
	{
		_y_min = _ca.y + view_h_half;	
	}
	if(_ca.bottom_clamp)
	{
		_y_max = _ca.y + _ca.sprite_height - view_h_half;	
	}
}

// Assign target coordinates
x_to = follow.x + _x_offset;
y_to = follow.y + _y_offset;

x_to = clamp(x_to,_x_min,_x_max);
y_to = clamp(y_to,_y_min,_y_max);

// Update camera position
var _dx = (x_to - x);
var _dy = (y_to - y);

x += _dx / 10;
y += _dy / 10;

// Keep camera in room
x = clamp(x,0+view_w_half,room_width-view_w_half);
y = clamp(y,0+view_h_half,room_height-view_h_half);

// Tell the view to follow this object's coordinates
camera_set_view_pos(cam,x-view_w_half,y-view_h_half);