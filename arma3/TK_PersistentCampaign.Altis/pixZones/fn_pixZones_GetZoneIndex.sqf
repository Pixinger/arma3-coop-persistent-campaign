private["_posX","_posY"];
_posX = _this select 0;
_posY = _this select 1;

private["_result"];
_result = -1;
private["_index"];
_index = 0;
{
	/* kombinierte if's sind in arma nicht performant, deshalb alle einzeln schachteln*/
	if (_posX >= (_x select 0)) then
	{
		if (_posY >= (_x select 1)) then 
		{
			if (_posX <= (_x select 2)) then
			{
				if (_posY <= (_x select 3)) exitWith { _result = _index; };
			};
		};
	};
	_index = _index + 1;
} foreach pixZones_ZoneCoordinates;

_result;