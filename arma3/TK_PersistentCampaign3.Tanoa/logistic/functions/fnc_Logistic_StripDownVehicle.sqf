private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

private _index = logisticStripDownables find _cursorTargetType;
if (_index >= 0) then 
{
	// Config lesen
	private _config = (logisticStripDownablesConfigs select _index);
	_config params ["_containerCount", "_duration"];
	if (pixDebug) then { _duration = 2; };
	
	logisticBuild = true;
	private _actionMenu = player addAction [("<t color=""#dddd00"">Zerlegen abbrechen</t>"), { logisticBuild = false; }, nil, 5, true, true];
	private _exitTime = time + _duration;
	while { (logisticBuild) && (alive player) && (time < _exitTime) } do { Sleep 1; };
	call fnc_Logistic_WorkAnimationEnd;
	player removeAction _actionMenu;

	if ((logisticBuild) && (alive player)) then
	{
		private _containerClassname = (logisticStripDownContainers call PIX_fnc_RandomElement);
		private _centerPosition = getPosATL _cursorTarget;
		deleteVehicle _cursorTarget;
		
		for "_i" from 1 to _containerCount do
		{
			Sleep 1;
			private _emptyPosition = [_centerPosition, _containerClassname] call PIX_fnc_FindEmptyPositionClosest;
			private _container = [_containerClassname, _emptyPosition, 0] call fnc_logisticDb_CreateVehicleCorrected;
			_container setVariable["dbVar", _cursorTargetType, true];
		};
	};
};
	

	