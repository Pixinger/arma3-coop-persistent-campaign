private["_zoneIndex"];
_zoneIndex = _this select 0;

private["_result"];
_result = [[0,0,0],0,[0,0,0],0]; /* [position, direction, obfuscatedPosition, obfuscatedRadius] */
private["_missionRadius"];
_missionRadius = 50;
private["_location"]; /*[[0,0,0],0]*/
_location = [_zoneIndex, _missionRadius, [0,0,0], 0, -10, -80] call PC_fnc_GetRandomLocationZoneWater; /* min 10 max 80 deep */
if (str(_location) != "[[0,0,0],0]") then
{
	/* Diese Mission findet am Meeresboden statt */
	private["_depth"];
	_depth = getTerrainHeightASL (_location select 0); 
	(_location select 0) set [2, _depth];

	private["_obfuscatedLocation"]; /*[[0,0,0],0]*/
	_obfuscatedLocation = [(_location select 0), _missionRadius] call PC_fnc_GetObfuscatedMarker;
	if (str(_obfuscatedLocation) != "[[0,0,0],0]") then
	{
		_result = [_location select 0, _location select 1, _obfuscatedLocation select 0, _obfuscatedLocation select 1];
	};
};
	
_result