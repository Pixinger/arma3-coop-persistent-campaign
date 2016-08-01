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
		{
			private _object = _x;

			// Objekt entladen
			detach _object;
			
			// Freien Platz suchen
			private _position = [(position player), typeof _object] call PIX_fnc_FindEmptyPositionClosest;
			
			// Auf freien Platz setzen
			_object setPos _position;
			
			hint localize "str_pc3_ObjectWillBeUnloaded";
			Sleep 1;
		} foreach _attachedObjects;
		
		hint format[localize "str_pc3_TheWholeCargoWasSuccessfullyUnloaded_ARG1_ObjectsTotal", _count];
	}
	else
	{
		hint localize "str_pc3_TheCargoWasAlreadyEmpty_ToBeSureWeUnloadedAgain";
	};
};