private _cursorTarget = cursorTarget;
private _cursorTargetType = typeof _cursorTarget;

if (_cursorTargetType in logisticTransporters) then
{
	private _attachedObjects = (attachedObjects _cursorTarget);
	if (count _attachedObjects > 0) then
	{
		if (isEngineOn _cursorTarget) then
		{
			_cursorTarget allowDamage false;
			
			// Objekt festlegen
			private _object = (_attachedObjects select ((count _attachedObjects) -1));
			
			// Freien Platz suchen
			//private _position = [(position player), typeof _object] call PIX_fnc_FindEmptyPositionClosest;
			private _position = [position player, 1, _distance, sizeOf (typeof _object), 0, 5, 0] call BIS_fnc_findSafePos;
			if (count _position > 0) then
			{
				_position set [2,0];
				_object allowDamage false;

				// Objekte entladen
				detach _object;
				_object setPosATL _position;

				// Objekt Konfiguration auslesen
				private _objectIndex = logisticObjectsTransportables find (typeof _object);
				private _objectConfig = logisticObjectsTransportablesConfig select _objectIndex;
				private _objectSize = _objectConfig select 0;
				
				// Ladungs Variable aktualisieren
				private _load = _cursorTarget getVariable ["pixLoad", 0];
				_load = _load - _objectSize;
				if (_load < 0) then {_load = 0;};	
				_cursorTarget setVariable ["pixLoad", _load, true];	
				hint localize "str_pc3_OneObjectSuccessfullyUnloaded";
				
				_object allowDamage true;
			}
			else
			{
				hint localize "str_pc3_ERRORNoFreeLocationFound";
			};
			
			Sleep 1;
			_cursorTarget allowDamage true;
		}
		else
		{
			hint localize "str_pc3_PleaseTurnOffEngineToUnload";
			player globalChat localize "str_pc3_PleaseTurnOffEngineToUnload";
		};
	};
};