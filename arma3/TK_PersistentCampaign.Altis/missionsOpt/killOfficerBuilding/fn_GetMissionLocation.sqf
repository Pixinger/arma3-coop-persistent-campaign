private["_zoneIndex"];
_zoneIndex = _this select 0;

private["_result"];
_result = [[0,0,0],0,[0,0,0],0];

private["_location"]; /*[[0,0,0],0]*/
_location = [_zoneIndex, missionsOpt_DefaultMarkerRadius] call PC_fnc_GetRandomLocationZoneHouse;
if (str(_location) != "[[0,0,0],0]") then
{
	private["_obfuscatedLocation"]; /*[[0,0,0],0]*/
	_obfuscatedLocation = [(_location select 0), missionsOpt_DefaultMarkerRadius] call PC_fnc_GetObfuscatedMarker;
	if (str(_obfuscatedLocation) != "[[0,0,0],0]") then
	{
		_result = [_location select 0, _location select 1, _obfuscatedLocation select 0, _obfuscatedLocation select 1];
	};
};
	
_result