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
			private _unloadCenter = _cursorTarget modelToWorld [0,-10,0];
				
			/* -----------------------------*/
			/* Entladen Alte Version */
			/* -----------------------------*/
			// private _position = [(position player), sizeOf (typeof _object), 20] call PIX_fnc_FindEmptyPositionClosest;

			/* -----------------------------*/
			/* Entladen hinter dem Fahrzeug */
			/* -----------------------------*/
			// private _position = _unloadCenter isFlatEmpty [
				// sizeOf (typeof _object),// 1: minDistance (Optional): Number - Objects within 50m cannot be closer than minDistance. -1 to ignore proximity check. Default: -1
				// -1,						// 2: mode (Optional): Number - Position check mode (ALWAYS USE DEFAULT VALUE!). Default: -1
				// -1, 					// 3: maxGradient (Optional): Number - Maximum terrain steepness allowed. -1 to ignore. Default: -1
				// 1, 						// 4: maxGradientRadius (Optional): Number - How far to extend gradient check. Default: 1
				// 0, 						// 5: overLandOrWater (Optional): Number - 0: position cannot be over water; 2: position cannot be over land. -1 to ignore. Default: 0
				// false, 					// 6: shoreLine (Optional): Boolean - true: position is over shoreline (< ~25 m from water). false to ignore. Default: false
				// objNull					// 7: ignoreObject (Optional): Object - Object to ignore in proximity checks. objNull to ignore. Default: objNull
				// ];
			/* -------------------------------------------*/
			/* Entladen hinter dem Fahrzeug (Zufallradius)*/
			/* -------------------------------------------*/
			private _position = [
				_unloadCenter, 			// _this select 0: center position (Array). Note: passing [] (empty Array), the world's safePositionAnchor entry will be used.
				1, 						// _this select 1: minimum distance from the center position (Number)
				8,  					// _this select 2: maximum distance from the center position (Number). Note: passing -1, the world's safePositionRadius entry will be used.
				sizeOf (typeof _object),// _this select 3: minimum distance from the nearest object (Number)
				0, 						// _this select 4: water mode (Number).	0=cannot be in water. 1=can either be in water or not. 2=must be in water
				5, 						// _this select 5: maximum terrain gradient (average altitude difference in meters - Number)
				0						// _this select 6: shore mode (Number):	0=does not have to be at a shore.	1=must be at a shore
				] call BIS_fnc_findSafePos;
				
				
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