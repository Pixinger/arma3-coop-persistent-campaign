private["_object"];
_object = _this select 0;

private["_height"];
_height = (getPos _object) select 2;
private["_speed"];
_speed = 0.09;

while {((getPos _object) select 2) > 0.1} do 
{
	_speed = (_speed * 1.1);
	_object setPos [getPos _object select 0, getPos _object select 1, _height];
	_height = _height - _speed;
	sleep 0.01;
};

