private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

private["_objectIndex"];
_objectIndex = logisticObjectsTransportables find _cursorTargetType;
if (_objectIndex >= 0) then 
{
	private["_vehicles"];
	_vehicles = nearestObjects [player, logisticTransporters, 20];
	if (count _vehicles > 0) then 
	{
		// Zielfahrzeug für die Ladung suchen und den _vehicleIndex auslesen.
		private["_vehicle"];
		_vehicle = _vehicles select 0;
		private["_vehicleIndex"];
		_vehicleIndex = logisticTransporters find typeof(_vehicle);

		// Attach-Punkte des Fahrzeugs auslesen
		private["_attachPoints"];
		_attachPoints = logisticTransporterConfigs	select _vehicleIndex;
		
		// Objekt Konfiguration auslesen
		private["_objectConfig"];
		_objectConfig = logisticObjectsTransportablesConfig select _objectIndex;
		private["_objectSize"];
		_objectSize = _objectConfig select 0;

		// Aktuelle Ladung auslesen
		private["_load"];
		_load = _vehicle getVariable ["pixLoad", 0];
		player globalChat format["count _attachPoints = %1 / _load=%2 / _objectSize=%3", count _attachPoints, _load, _objectSize];

		// Auf dem entsprechenden AttachPoint attachen, wenn genug Platz vorhanden ist.
		if (_load + _objectSize <= count _attachPoints) then
		{
			private["_attachPoint"];
			_attachPoint = _attachPoints select _load;

			private["_objectAttachOffset"];
			_objectAttachOffset = _objectConfig select 1;
			private["_objectAttachRotation"];
			_objectAttachRotation = _objectConfig select 2;			

			private["_finalAttachPoint"];
			_finalAttachPoint = [(_attachPoint select 0) + (_objectAttachOffset select 0), (_attachPoint select 1) + (_objectAttachOffset select 1), (_objectAttachOffset select 2)];

			_cursorTarget attachTo [_vehicle, _finalAttachPoint];		
			_cursorTarget setVectorDirAndUp [[1,0,0],[0,0,1]];
	
			_load = _load + _objectSize;
			_vehicle setVariable ["pixLoad", _load, true];
		}
		else
		{
			player globalChat format["count _attachPoints: %1 / %2", count _attachPoints, _objectSize];
			hint "Kein Platz mehr auf dem Fahrzeug!";
		};		
	};
};
