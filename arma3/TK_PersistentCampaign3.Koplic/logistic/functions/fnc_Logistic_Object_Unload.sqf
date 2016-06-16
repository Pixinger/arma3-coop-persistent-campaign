private _cursorTarget = cursorTarget;
private _cursorTargetType = typeof _cursorTarget;

if (_cursorTargetType in logisticTransporters) then
{
	diag_log "DEBUG: Unload";
	private _attachedObjects = (attachedObjects _cursorTarget);
	if (count _attachedObjects > 0) then
	{
		diag_log "DEBUG: Unload: Found a object";
		// Objekt festlegen
		private _object = (_attachedObjects select ((count _attachedObjects) -1));

		// Objekte entladen
		detach _object;
		diag_log "DEBUG: Unload: Detached";
		
		// Freien Platz suchen
		private _position = [(position player), typeof _object] call PIX_fnc_FindEmptyPositionClosest;
		
		// Auf freien Platz setzen
		_object setPos _position;

		// Objekt Konfiguration auslesen
		diag_log "DEBUG: Unload: Reading config";
		private _objectIndex = logisticObjectsTransportables find (typeof _object);
		private _objectConfig = logisticObjectsTransportablesConfig select _objectIndex;
		private _objectSize = _objectConfig select 0;
		diag_log "DEBUG: Unload: config OK";
		
		// Ladungs Variable aktualisieren
		private _load = _cursorTarget getVariable ["pixLoad", 0];
		diag_log format["DEBUG: Unload: Current Load=%1", _load];
		_load = _load - _objectSize;
		if (_load < 0) then {_load = 0;};	
		diag_log format["DEBUG: Unload: Final Load=%1", _load];
		_cursorTarget setVariable ["pixLoad", _load, true];	
		diag_log "DEBUG: Unload: PublicVariable set";
		hint "Ein Objekt erfolgreich abgeladen";
	};
};