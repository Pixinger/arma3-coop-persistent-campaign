private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

private _sellableIndex = logisticRepairables find _cursorTargetType;
if (_sellableIndex >= 0) then 
{
	// Repairable Config lesen
	private _repairableConfig = (logisticRepairablesConfigs select _sellableIndex);
	_repairableConfig params ["_duration", "_replacementClass"];
	if (pixDebug) then { _duration = 2; };
	
	call fnc_Logistic_WorkAnimationStart;
	logisticBuild = true;
	private _actionMenu = player addAction [(localize "str_pc3_AbortRepairing"), { logisticBuild = false; }, nil, 5, true, true];
	private _exitTime = time + _duration;
	while { (logisticBuild) && (alive player) && (time < _exitTime) } do { Sleep 1; };
	call fnc_Logistic_WorkAnimationEnd;
	player removeAction _actionMenu;

	if ((logisticBuild) && (alive player)) then
	{
		private _position = getPosATL _cursorTarget;
		private _direction = getDir _cursorTarget;
		private _dbVar = _cursorTarget getVariable ["dbVar", []];
		
		// Fahrzeug löschen...
		deleteVehicle _cursorTarget;
		// ...warten...
		Sleep 2;
		// ... und neu erstellen.
		private _vehicle = [_replacementClass, _position, _direction] call fnc_logisticDb_CreateVehicleCorrected;
		if (str(_dbVar) != "[]") then 
		{ 
			_vehicle setVariable ["dbVar", _dbVar, true];
			player globalChat format["Updated dbVar: %1", _dbVar];
		};
	};
};
	

	