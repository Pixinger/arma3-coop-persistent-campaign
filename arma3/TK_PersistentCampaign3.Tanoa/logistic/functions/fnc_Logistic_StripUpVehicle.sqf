private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;


if (_cursorTargetType in logisticStripDownContainers) then 
{
	private _vehicleClassname = _cursorTarget getVariable ["dbVar", ""];
	private _index = logisticStripDownables find _vehicleClassname;
	if (_index >= 0) then 
	{
		// Config lesen
		private _config = (logisticStripDownablesConfigs select _index);
		_config params ["_containerCount", "_duration"];
		if (pixDebug) then { _duration = 2; };
		
		// Container suchen (vorab Untersuchung)
		private _containers = nearestObjects [_cursorTarget, logisticStripDownContainers, 30];
		private _count = 0;
		{ if (_x getVariable ["dbVar", ""] == _vehicleClassname) then { _count = _count + 1; };	} foreach _containers;

		// genug Container gefunden?
		if (_count >= _containerCount) then
		{
			// Container löschen
			_containers = nearestObjects [_cursorTarget, logisticStripDownContainers, 30];
			private _count = 0;
			{ 
				if (_x getVariable ["dbVar", ""] == _vehicleClassname) then 
				{ 
					deleteVehicle _x; 
					_count = _count + 1; 
				};	
				if (_count == _containerCount) exitWith {};	
			} foreach _containers;
			
			// Animation starten
			logisticBuild = true;
			private _actionMenu = player addAction [("<t color=""#dddd00"">Zusammenbauen abbrechen</t>"), { logisticBuild = false; }, nil, 5, true, true];
			private _exitTime = time + _duration;
			while { (logisticBuild) && (alive player) && (time < _exitTime) } do { Sleep 1; };
			call fnc_Logistic_WorkAnimationEnd;
			player removeAction _actionMenu;

			// Na... noch alles klar?
			if ((logisticBuild) && (alive player)) then
			{
				// Vehicle erstellen
				private _emptyPosition = [(getPosATL player), _vehicleClassname] call PIX_fnc_FindEmptyPositionClosest;
				[_vehicleClassname, _emptyPosition, 0] call fnc_logisticDb_CreateVehicleCorrected;
			}
			else
			{
				// Container wieder herstellen
				for "_i" from 1 to _containerCount do
				{
					Sleep 1;
					private _containerClassname = (logisticStripDownContainers call PIX_fnc_RandomElement);
					private _emptyPosition = [(getPosATL player), _containerClassname] call PIX_fnc_FindEmptyPositionClosest;
					private _container = [_containerClassname, _emptyPosition, 0] call fnc_logisticDb_CreateVehicleCorrected;
					_container setVariable["dbVar", _cursorTargetType];
				};
			};			
		};
	};	
};