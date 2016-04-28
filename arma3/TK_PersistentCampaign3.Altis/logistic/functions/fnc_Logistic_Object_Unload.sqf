private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

private["_attachedObjects"];
_attachedObjects = (attachedObjects _cursorTarget);
if (count _attachedObjects > 0) then
{
	// Objekt festlegen
	private["_object"];
	_object = (_attachedObjects select ((count _attachedObjects) -1));

	// Objekte entladen
	detach _object;
	
	// Freien Platz suchen
	private["_distance"];
	_distance = 5;
	private["_position"];
	_position = (position player) findEmptyPosition [0, _distance, typeof _object];
	while { count _position == 0 } do
	{
		_distance = _distance + 5;
		_position = (position player) findEmptyPosition [0, _distance, typeof _object];
	};
	
	// Auf freien Platz setzen
	_object setPos _position;

	// Objekt Konfiguration auslesen
	private["_objectIndex"];
	_objectIndex = logisticObjectsTransportables find (typeof _object);
	private["_objectConfig"];
	_objectConfig = logisticObjectsTransportablesConfig select _objectIndex;
	private["_objectSize"];
	_objectSize = _objectConfig select 0;
	
	// Ladungs Variable aktualisieren
	private["_load"];
	_load = _cursorTarget getVariable ["pixLoad", 0];
	_load = _load - _objectSize;
	if (_load < 0) then {_load = 0;};	
	_cursorTarget setVariable ["pixLoad", _load, true];	
};