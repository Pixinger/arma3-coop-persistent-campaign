private["_zoneIndex"];
_zoneIndex = _this select 0;

private["_result"];
_result = [[0,0,0],0,[0,0,0],0]; /* [position, direction(buildingtype), obfuscatedPosition, obfuscatedRadius] */

private["_location"]; /*[[0,0,0],0]*/
_location = [_zoneIndex, missionsOpt_DefaultMarkerRadius] call PC_fnc_GetRandomLocationZoneCity;
if (str(_location) != "[[0,0,0],0]") then
{
	_result = [_location select 0, _location select 1, _location select 0, 300];
};
	
_result