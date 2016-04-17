#define ATTACHPOINT_INDEX			0
#define ATTACHROTATION_INDEX		1
#define DETACHHEIGHT_INDEX 			2
#define BUILDSPEED_INDEX			3
#define REQUIREDRESOURCES_INDEX		4

private["_classname"];
_classname = _this select 0;

private["_config"];
_config = [_classname, true] call fnc_logistic_CanBuild;
if (count _config > 0) then
{
	// Position suchen
	private["_position"];
	_position = (position player) findEmptyPosition [0, 1000, _classname];

	// Objekt erstellen
	private["_object"];
	_object = _classname createVehicleLocal _position;
	waitUntil {!isNil "_object"};
	_object allowDamage false;
	
	// Jetzt fangen wir an das Objekt zu bewegen
	_object attachTo [player, _config select ATTACHPOINT_INDEX];

	private["_actionMenu"];
	_actionMenu = player addAction [("<t color=""#dddd00"">Bauen starten</t>"), { logisticDecision = 0; logisticMoveObject = objNull; }, nil, 5, true, true];
	private["_actionMenu2"];
	_actionMenu2 = player addAction [("<t color=""#dddd00"">Bauen abbrechen</t>"), { logisticDecision = 1; logisticMoveObject = objNull; }, nil, 5, true, true];

	// Verschiedene Überwachungen
	logisticMoveObject = _object;
	logisticDecision = 1;
	while {!(isNull logisticMoveObject) && (alive player)} do
	{
		if (vehicle player != player) then
		{
			player action ["eject", vehicle player];
			sleep 1;
		};

		sleep 0.25;
	};

	player removeAction _actionMenu;
	player removeAction _actionMenu2;
	if (logisticDecision == 0) then
	{
		// Das Object soll gebaut werden		
		private["_direction"];
		_direction = getDir _object;
		_position = [((getPos _object) select 0), ((getPos _object) select 1), (_config select DETACHHEIGHT_INDEX)];
		deleteVehicle _object;
		
		// Objekt erstellen
		private["_object"];
		_object = _classname createVehicle _position;
		waitUntil {!isNil "_object"};
		_object setPos _position;
		_object setDir _direction;
	
		// Mit dem Bauen beginnen
		[_object, 1] spawn fnc_logistic_BuildUpDown;
	}
	else
	{
		// Das Object soll nicht gebaut werden		
		deleteVehicle _object;		
	};
	logisticMoveObject = nil;
	logisticDecision = nil; 
};