//diag_log format["fnc_aiz_GroupReduce: _this=%1", _this];
private _group = _this select 0;

if ((count units _group) == 0) exitWith {};

private _unitsWithoutLeader = (units _group) - [leader _group];
private _unitInfos = [];
{
	if (alive _x) then
	{
		_unitInfos pushBack [
			typeof _x, 
			0, // TODO: Read weapon loadout
			skill _x, 
			[_x] call fnc_aiz_GetUnitDamageArray];
		
		deleteVehicle _x;
	};
} foreach _unitsWithoutLeader;

Sleep 1;

// Alle übriggebliebenen auf langsam gehen setzn (das sollte eigentlich nur der Leader sein).
{ 
	_x setSpeedMode "LIMITED"; 
	_x setBehaviour "CARELESS";
} foreach (units _group);

[_group] spawn {
	Sleep 3;
	{ 
		_x setBehaviour "CARELESS";
	} foreach (units (_this select 0));
};	

//diag_log format["fnc_aiz_GroupReduce: _unitInfos=%1", _unitInfos];
_unitInfos;