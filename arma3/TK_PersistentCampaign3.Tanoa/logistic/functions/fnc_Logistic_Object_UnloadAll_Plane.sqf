if (call fnc_Logistic_CanObject_UnloadAll_Plane) then
{	
	private _aircraft = (vehicle player);
	_aircraft spawn 
	{
		// Luftfahrzeug speichern
		private _aircraft = vehicle player;
		_aircraft allowDamage false;

		// Als erstes geben wir den Laderaum frei (das machen wir zur Sicherheit gleich am Anfang, damit bei Verwendung dieser Funktion auch wirklich der LKW leer ist).
		_aircraft setVariable ["pixLoad", 0, true];
		
		// ...danach detachen wir alles was attached ist.
		private _attachedObjects = (attachedObjects _aircraft);

		{
			private _position = _aircraft modelToWorld [0,-15,-15];
			//private _position = getPosATL _aircraft;
			//_position set [2, (_position select 2) - 15];

			private _object = _x;
			_object allowDamage false;

			// Objekt entladen
			detach _object;
			_object allowDamage false;
			_object setPosATL _position;
			
			player globalChat localize "str_pc3_ObjectUnloaded";
			Sleep 1;

			[_object] spawn {
				params["_object"];
				
				private _position = getPosATL _object;
				
				//Fallschirm erstellen
				private _parachute = "B_Parachute_02_F" createVehicle [0,0,0];
				_parachute setPosATL _position;
				_parachute allowDamage false;
				_object attachTo [_parachute,[0, 0, -2]];

				// Warten bis am Boden
				waitUntil {(getPos _object) select 2 < 2};

				detach _object;
				private _position = getposATL _object;
				_position set [2,0];
				_object setPosATL _position;
				deleteVehicle _parachute;				

				_object allowDamage true;				
			};					
			
		} foreach _attachedObjects;		
		
		_aircraft allowDamage true;
	};
};