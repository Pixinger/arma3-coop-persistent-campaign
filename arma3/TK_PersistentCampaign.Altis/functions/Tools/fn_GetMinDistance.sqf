/* 
	Diese Funktion vergleicht die Übergebene Position mit einem Location-Array und gibt die minimale Entfernung zurück. 
	
	Parameter:
		position: [0,0] oder [0,0,0]
		locations: array mit den "locations". [[[locx1,locy1,locz1],locdir1],[locx2,locy2,locz2],locdir2],...,[locxN,locyN,loczN],locdirN]] 

/*-------------------------------------------------------------------*/

private["_position"];
_position = [_this, 0, objNull, [objNull,[]],[2,3]] call BIS_fnc_param;

private["_locations"];
_locations = [_this, 1, objNull, [objNull,[]],[2,3]] call BIS_fnc_param;

private["_result"];
_result = 65000;

if ((!isNull _position) && (!isNull _locations)) then
{
	if (str(_locations) != "[]") then
	{
		private["_index"];
		_index = 0;
		private["_minDistanceIndex"];
		_minDistanceIndex = 0;
		private["_minDistance"];
		_minDistance = _position distanceSqr ((_locations select 0) select 0);
		private["_locationCount"];
		_locationCount = count _locations;
		for "_i" from 1 to (_locationCount-1) do
		{
			private["_distance"];
			_distance = _position distanceSqr ((_locations select _i) select 0);
			if (_distance < _minDistance) then
			{
				_minDistance = _distance;
				_minDistanceIndex = _i;
			};
		};

		private["_result"];
		_result = _position distance ((_locations select _minDistanceIndex) select 0);
	};
};

_result;
