/* Diese Funktion erstellt ein MissionsInfo-Array, dass dann in der Regel in die Variable "pvehPixZones_MissionInfos" geschrieben wird. */

private["_result"];
_result = [];
if (isServer) then
{
	private["_reverseAttack"];
	_reverseAttack = _this select 0; /* true/false */
	
	/* Weil es ein Preset ist, wird hier noch der Index der eigentlich aufgerufenen Zone angegeben */
	private["_zoneIndex"]; 
	_zoneIndex = _this select 1;
	
	/* Aufruf der besseren Übersicht halber an die entsprechende Datei weiterleiten */
	if (_reverseAttack) then
	{
		_result  = [_zoneIndex] call compile preprocessFileLineNumbers "pixZones\Preset1\fn_GetReverseAttackArray.sqf";
	}
	else
	{
		_result  = [_zoneIndex] call compile preprocessFileLineNumbers "pixZones\Preset1\fn_GetNormalAttackArray.sqf";
	};
};
_result;