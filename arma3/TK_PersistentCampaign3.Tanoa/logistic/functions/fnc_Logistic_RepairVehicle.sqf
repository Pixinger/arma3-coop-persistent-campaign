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
	
	if (alive player) then
	{
		private _position = getPosATL _cursorTarget;
		private _direction = getDir _cursorTarget;
		
		// Fahrzeug löschen
		deleteVehicle _cursorTarget;

		[_replacementClass, _position, _direction] call fnc_logisticDb_CreateVehicleCorrected;		
	};
};
	

	