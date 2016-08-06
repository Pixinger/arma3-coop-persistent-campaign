private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

if (_cursorTargetType in logisticObjectsMoveables) then 
{
	// Objekt Konfiguration auslesen
	private["_objectIndex"];
	_objectIndex = logisticObjectsMoveables find _cursorTargetType;
	private["_objectConfig"];
	_objectConfig = logisticObjectsMoveableConfigs select _objectIndex;
	private["_objectAttachPoint"];
	_objectAttachPoint = _objectConfig select 0;

	/*--------------------------------------------------------------------*/
	/* Jetzt fangen wir an das Objekt zu bewegen*/
	_cursorTarget attachTo [player, _objectAttachPoint];

	private["_actionMenu"];
	_actionMenu = player addAction [format["<t color=""#dddd00"">%1</t>", localize "str_pc3_Drop"], { logisticMoveObject = objNull; }, nil, 5, true, true];

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
		
		if ([0,0,0] distance (velocity player) > 2.8) then
		{
			player playMove "AmovPpneMstpSnonWnonDnon";
		};		

		sleep 0.25;
	};

	player removeAction _actionMenu;
	logisticMoveObject = nil;

	/*--------------------------------------------------------------------*/
	/* Das Object soll abgelegt werden oder der Spieler ist tot*/
	detach _cursorTarget;
	_cursorTarget setPos [getPos _cursorTarget select 0, getPos _cursorTarget select 1, 0];
	_cursorTarget setVelocity [0, 0, 0];				
};