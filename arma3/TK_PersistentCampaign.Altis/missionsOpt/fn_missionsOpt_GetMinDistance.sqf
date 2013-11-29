/* Diese Funktion vergleicht die Übergebene Position mit einem Positinsarray und gibt die minimale Entfernung zurück. */
private["_position"];
_position = (_this select 0);
private["_locations"];
_locations =(_this select 1); /* [[0,0,0],0, [0,0],0] */

private["_result"];
_result = 65000;
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

_result;

