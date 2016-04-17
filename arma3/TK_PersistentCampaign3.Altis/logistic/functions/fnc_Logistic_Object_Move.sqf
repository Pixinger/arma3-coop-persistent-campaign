private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

if (_cursorTargetType in logisticObjectsMoveable) then 
{
	// Objekt Konfiguration auslesen
	private["_objectIndex"];
	_objectIndex = logisticObjectsMoveable find _cursorTargetType;
	private["_objectConfig"];
	_objectConfig = logisticObjectsMoveableConfig select _objectIndex;
	private["_objectAttachPoint"];
	_objectAttachPoint = _objectConfig select 0;

	/*--------------------------------------------------------------------*/
	/* Jetzt fangen wir an das Objekt zu bewegen*/
	_cursorTarget attachTo [player, _objectAttachPoint];

	private["_actionMenu"];
	_actionMenu = player addAction [("<t color=""#dddd00"">Ablegen</t>"), { logisticMoveObject = objNull; }, nil, 5, true, true];

	/*--------------------------------------------------------------------*/
	/* Verschiedene Überwachungen*/
	logisticMoveObject = _cursorTarget;
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
	logisticMoveObject = objNull;

	/*--------------------------------------------------------------------*/
	/* Das Object soll abgelegt werden oder der Spieler ist tot*/
	if (!isNull _cursorTarget) then
	{
		detach _cursorTarget;
		_cursorTarget setPos [getPos _cursorTarget select 0, getPos _cursorTarget select 1, 0];
		_cursorTarget setVelocity [0, 0, 0];				
	};	
};