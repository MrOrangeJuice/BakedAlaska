/// @description Move

dir += rotSpd;

// Get our target position
var _targetX = xstart + lengthdir_x(radius,dir);
var _targetY = ystart + lengthdir_y(radius,dir);

// Get our xSpd and ySpd
xSpd = _targetX - x;
ySpd = _targetY - y;

// Move
x += xSpd;
y += ySpd;