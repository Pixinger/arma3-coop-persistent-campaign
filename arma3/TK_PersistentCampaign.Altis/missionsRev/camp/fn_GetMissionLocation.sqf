private["_zoneIndex"];
_zoneIndex = _this select 0;

private["_result"];
_result = [[0,0,0],0,[0,0],0];

private["_location"]; /*[[0,0,0],0]*/
_location = [_zoneIndex, 200] call PC_fnc_GetRandomLocationZoneField;
if (str(_location) != "[[0,0,0],0]") then
{
	_result = [_location select 0, _location select 1,[0,0,0], 0];
};
	
/*[[0,0,0],0,[0,0,0],0]*/
_result