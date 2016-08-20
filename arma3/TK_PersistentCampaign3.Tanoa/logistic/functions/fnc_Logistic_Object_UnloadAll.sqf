private _cursorTarget = cursorTarget;
private _cursorTargetType = typeof _cursorTarget;

if (_cursorTargetType in logisticTransporters) then
{
	// Als erstes geben wir den Laderaum frei (das machen wir zur Sicherheit gleich am Anfang, damit bei Verwendung dieser Funktion auch wirklich der LKW leer ist).
	_cursorTarget setVariable ["pixLoad", 0, true];
	
	// ...danach detachen wir alles was attached ist.
	private _attachedObjects = (attachedObjects _cursorTarget);
	private _count = count _attachedObjects;
	
	if (_count > 0) then
	{
		_cursorTarget allowDamage false;

		{
			private _object = _x;
			_object allowDamage false;

			// Objekt entladen
			detach _object;
			
			// Freien Platz suchen
			//private _position = [(position player), sizeOf (typeof _object), 20] call PIX_fnc_FindEmptyPositionClosest;
			private _position = [position player, 1, _distance, sizeOf (typeof _object), 0, 5, 0] call BIS_fnc_findSafePos;
			if (count _position > 0) then
			{		
				_position set [2,0];
				_object setPosATL _position;
				hint localize "str_pc3_ObjectUnloaded";
			}
			else
			{
				hint localize "str_pc3_ERRORNoFreeLocationFound";
				player globalChat localize "str_pc3_ERRORNoFreeLocationFound";
			};
			Sleep 3;
			_object allowDamage true;
		} foreach _attachedObjects;
		
		hint format[localize "str_pc3_TheWholeCargoWasSuccessfullyUnloaded_ARG1_ObjectsTotal", _count];

		_cursorTarget allowDamage true;
	}
	else
	{
		hint localize "str_pc3_TheCargoWasAlreadyEmpty_ToBeSureWeUnloadedAgain";
	};
};