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
			private _distance = 5;
			private _position = (position player) findEmptyPosition [0, _distance, typeof _object];
			while { count _position == 0 } do
			{
				_distance = _distance + 5;
				_position = (position player) findEmptyPosition [0, _distance, typeof _object];
			};
			
			// Auf freien Platz setzen
			_object setPos _position;
		} foreach _attachedObjects;
		
		hint format["Der gesamte Laderaum wurde erfolgreich abgeladen. Insgesamt %1 Objekte waren geladen.", _count];
	}
	else
	{
		hint "Der Laderaum war bereits leer. Zur Sicherheit haben wir ihn noch einmal entladen...";
	};
};