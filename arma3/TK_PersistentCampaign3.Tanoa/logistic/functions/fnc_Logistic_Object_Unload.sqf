private _cursorTarget = cursorTarget;
private _cursorTargetType = typeof _cursorTarget;

if (_cursorTargetType in logisticTransporters) then
{
	private _attachedObjects = (attachedObjects _cursorTarget);
	if (count _attachedObjects > 0) then
	{
		if (!isEngineOn _cursorTarget) then
		{
			_cursorTarget allowDamage false;
			
			// Objekt festlegen
			private _object = (_attachedObjects select ((count _attachedObjects) -1));
			
			// Freien Platz suchen
			private _unloadCenter = _cursorTarget modelToWorld [0,-10,0];
			
			if ((_cursorTarget isKindOf "VTOL_01_base_F")) then
			{
				_unloadCenter = _cursorTarget modelToWorld [0,-12,0];
			};
			if ((_cursorTarget isKindOf "Ship")) then
			{
				_unloadCenter = _cursorTarget modelToWorld [0,-20,0];
			};
			
			/* -----------------------------*/
			/* Immer hinter dem Fahrzeug 	*/
			/* -----------------------------*/
			private _position = _unloadCenter;
			
			/* -----------------------------*/
			/* Entladen Alte Version */
			/* -----------------------------*/
			//private _position = [(position player), typeof _object] call PIX_fnc_FindEmptyPositionClosest;

			/* -----------------------------*/
			/* Entladen hinter dem Fahrzeug */
			/* -----------------------------*/
			// private _position = _unloadCenter isFlatEmpty [
				// sizeOf (typeof _object),// 1: minDistance (Optional): Number - Objects within 50m cannot be closer than minDistance. -1 to ignore proximity check. Default: -1
				// 0,						// 2: mode (Optional): Number - Position check mode (ALWAYS USE DEFAULT VALUE!). Default: -1
				// -1, 					// 3: maxGradient (Optional): Number - Maximum terrain steepness allowed. -1 to ignore. Default: -1
				// 1, 						// 4: maxGradientRadius (Optional): Number - How far to extend gradient check. Default: 1
				// 0, 						// 5: overLandOrWater (Optional): Number - 0: position cannot be over water; 2: position cannot be over land. -1 to ignore. Default: 0
				// false, 					// 6: shoreLine (Optional): Boolean - true: position is over shoreline (< ~25 m from water). false to ignore. Default: false
				// objNull					// 7: ignoreObject (Optional): Object - Object to ignore in proximity checks. objNull to ignore. Default: objNull
				// ];
			/* -------------------------------------------*/
			/* Entladen hinter dem Fahrzeug (Zufallradius)*/
			/* -------------------------------------------*/
			 // private _position = [
				 // _unloadCenter, 			// _this select 0: center position (Array). Note: passing [] (empty Array), the world's safePositionAnchor entry will be used.
				 // 1, 						// _this select 1: minimum distance from the center position (Number)
				 // 8, 					// _this select 2: maximum distance from the center position (Number). Note: passing -1, the world's safePositionRadius entry will be used.
				 // sizeOf (typeof _object),// _this select 3: minimum distance from the nearest object (Number)
				 // 0, 						// _this select 4: water mode (Number).	0=cannot be in water. 1=can either be in water or not. 2=must be in water
				 // 5, 						// _this select 5: maximum terrain gradient (average altitude difference in meters - Number)
				 // 0						// _this select 6: shore mode (Number):	0=does not have to be at a shore.	1=must be at a shore
				// ] call BIS_fnc_findSafePos;
				
			// Prüfen ob Position gefunden wurde
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