private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

// Animation starten
call fnc_Logistic_WorkAnimationStart;
logisticBuild = true;
private _actionMenu = player addAction [format["<t color=""#dddd00"">%1</t>", localize "str_pc3_Abort"], { logisticBuild = false; }, nil, 5, true, true];
private _exitTime = time + 120;
while { (logisticBuild) && (alive player) && (time < _exitTime) } do { Sleep 1; };
call fnc_Logistic_WorkAnimationEnd;
player removeAction _actionMenu;

// Na... noch alles klar?
if ((logisticBuild) && (alive player)) then
{
	private _direction = getDir _cursorTarget;
	private _position = getPosATL _cursorTarget;
	private _dbVar = _cursorTarget getVariable ["dbVar", []];
	private _classname = if (_cursorTargetType == "B_T_VTOL_01_vehicle_F") then { "B_T_VTOL_01_infantry_F" } else { "B_T_VTOL_01_vehicle_F" };
	
	// Fahrzeug löschen...
	deleteVehicle _cursorTarget;
	// ...warten...
	Sleep 2;
	// ... und neu erstellen.
	private _vehicle = [_classname, _position, _direction] call fnc_logisticDb_CreateVehicleCorrected;
	if (str(_dbVar) != "[]") then 
	{ 
		_vehicle setVariable ["dbVar", _dbVar, true];
	};
	
	hint localize "str_pc3_ModificationComplete";
};			
