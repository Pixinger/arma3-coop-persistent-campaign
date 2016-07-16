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
	
	call fnc_Logistic_WorkAnimationStart;
	if (pixDebug) then { Sleep 2; } else { Sleep _duration; };
	call fnc_Logistic_WorkAnimationEnd;
	
	logisticBuild = true;
	private _actionMenu = player addAction [("<t color=""#dddd00"">Reparatur abbrechen</t>"), { logisticBuild = false; }, nil, 5, true, true];
	private _timeout = if (pixDebug) then { time + 2; } else { time + (2 * 60); };
	while { (logisticBuild) && (alive player) && (time < _timeout) } do { Sleep 1; };
	call fnc_Logistic_WorkAnimationEnd;

	player removeAction _actionMenu;

	if ((logisticBuild) && (alive player)) then
	{
		private _position = getPosATL _cursorTarget;
		private _direction = getDir _cursorTarget;
		
		// Fahrzeug löschen...
		deleteVehicle _cursorTarget;
		// ...warten...
		Sleep 2;
		// ... und neu erstellen.
		[_replacementClass, _position, _direction] call fnc_logisticDb_CreateVehicleCorrected;		
	};
};
	

	