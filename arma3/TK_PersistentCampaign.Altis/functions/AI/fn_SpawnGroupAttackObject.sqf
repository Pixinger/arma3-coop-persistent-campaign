/* 
	Diese Funktion löscht alle Einheiten einer Gruppe. 
		Optinal werden alle defekten Fahrzeuge in die Logistik eingebunden.
	
Parameter:
	cfgGroupNames:	Ein Array das die CfgGroups-Namen enthält, die zur Erstellung diese AI-Gruppe verwendet werden können (aus der Config). 					
	zoneIndex:		ZonenIndex der Start-Zone.
	attackPosition: Die Position die angegriffen werden soll.
	(optional)zoneSafetyBorder: Sicherheitsabstand zum Rand der StartZone.
	
Return: 
	GroupInfo Array: [group, vehicles]
	If failed: []
/*-------------------------------------------------------------------*/

if (!isServer) exitWith {[]};

private["_cfgGroupNames"];
_cfgGroupNames = [_this, 0, [], [[]]] call BIS_fnc_param;
if (count _cfgGroupNames == 0) exitwith {["Empty _cfgGroupNames parameter"] call BIS_fnc_error; []};

private["_zoneIndex"];
_zoneIndex = [_this, 1, 0, [0]] call BIS_fnc_param;

private["_attackPosition"];
_attackPosition = [_this, 2, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
if (str(_attackPosition) == "[0,0,0]") exitwith {["Empty position parameter"] call BIS_fnc_error; []};

private["_zoneSafetyBorder"];
_zoneSafetyBorder = [_this, 3, 25, [0]] call BIS_fnc_param;
if (_zoneSafetyBorder < 0) then { _zoneSafetyBorder = 0; };

private["_attackDelay"];
_attackDelay = [_this, 4, -1, [0]] call BIS_fnc_param;
if (_attackDelay < 0) then { _attackDelay = 0; };

/*-------------------------------------------------------------------*/

/* Startpunkt in der Nähe des Objektes suchen */
private["_location"];
_location = [_zoneIndex, _zoneSafetyBorder] call PC_fnc_GetRandomLocationZoneField;
if (str(_location) == "[[0,0,0],0]") exitwith {["Unable to find start location"] call BIS_fnc_error; []};

/* Gruppe erstellen */
private["_groupInfos"];
_groupInfos = [_cfgGroupNames, (_location select 0)] call PC_fnc_SpawnGroup;
if (count _groupInfos == 0) exitwith {["PC_fnc_SpawnGroup failed"] call BIS_fnc_error; []};

/* Angriffsverzögerung */
if (_attackDelay > 0) then
{
	[_attackDelay, _groupInfos, _attackPosition] spawn {
		private["_attackDelay"];
		_attackDelay = _this select 0;
		private["_groupInfos"];
		_groupInfos = _this select 1;
		private["_attackPosition"];
		_attackPosition = _this select 2;
		
		private["_cnt"];
		_cnt = (60 * _attackDelay); 
		while { _cnt > 0 } do
		{
			Sleep 1;
			_cnt = _cnt - 1;
		};
		
		[_groupInfos select 0, _attackPosition] call PC_fnc_AttackObject;
	};
}
else
{
	[_groupInfos select 0, _attackPosition] call PC_fnc_AttackObject;
};

/* Im Debug die Gruppe mit einem Marker tracken */
if (!isDedicated) then { [_groupInfos select 0, true, "ColorRed","AO"] spawn PC_fnc_TrackGroup; };

_groupInfos