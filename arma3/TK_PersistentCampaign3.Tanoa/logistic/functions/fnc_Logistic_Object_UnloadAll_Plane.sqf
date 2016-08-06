if (call fnc_Logistic_CanObject_UnloadAll_Plane) then
{	
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
			private _object = _x;
			_object allowDamage false;

			// Objekt entladen
			detach _object;
			
			private _position = getPos _aircraft;
			_position set [2, (_position select 2) - 5];
			
			// Auf freien Platz setzen
			_object setPos _position;
			
			[_object] spawn {
				params["_object"];
				
				private _position = getPos _object;

				//Fallschirm erstellen
				private _parachute = "B_Parachute_02_F" createVehicle [0,0,0];
				_parachute setPosATL _position;
				_object attachTo [_parachute,[0, 0, -1.2]];

				// Rauchgranate
				_smoke = "SmokeShellYellow" createVehicle position _object;
				_smoke attachto [_object,[0,0,0]];

				// Nach 10 Sekunden den Rauch löschen und neuen erstellen
				Sleep 10;
				_smoke setDamage 1;
				deleteVehicle _smoke;

				// Rauchgranate
				_smoke = "SmokeShellYellow" createVehicle position _object;
				_smoke attachto [_object,[0,0,0]];

				// Warten bis die Lieferung sich nicht mehr bewegt
				private _height = 9999;
				while { _height != ((getPos _object) select 2) } do { Sleep 1; _height = ((getPos _object) select 2); };
				
				// Detachen
				detach _object;
				Sleep 5;
				deleteVehicle _parachute;
				
				// Nochmal ordentlich smoken !!!
				_smoke = "SmokeShellYellow" createVehicle position _object;
				_smoke attachto [_object,[0,0,0]];
				Sleep 10;
				_smoke setDamage 1;
				deleteVehicle _smoke;
				_object allowDamage true;				
			};					
			
			player globalChat localize "str_pc3_ObjectWillBeUnloaded";
			Sleep 1;
		} foreach _attachedObjects;		
		
		_aircraft allowDamage false;
	};
};