private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;


/*--------------------------------------------------------------------*/
/* Jetzt fangen wir an das Objekt zu bewegen*/
_object attachTo [player, [
	0,
	10,
	0]
];

private["_actionMenu"];
_actionMenu = player addAction [("<t color=""#dddd00"">Ablegen</t>"), "pixLogistic\clientReleaseObject.sqf", nil, 5, true, true];


/*--------------------------------------------------------------------*/
/* Verschiedene Überwachungen*/
while {!(isNull pixlogisticMovingObject) && (alive player)} do
{
	if (vehicle player != player) then
	{
		player action ["eject", vehicle player];
		sleep 1;
	};

	sleep 0.25;
};


player removeAction _actionMenu;
pixlogisticMovingObject = objNull;

/*--------------------------------------------------------------------*/
/* Das Object soll abgelegt werden oder der Spieler ist tot*/
if (!isNull _object) then
{
	detach _object;
	_object setPos [getPos _object select 0, getPos _object select 1, 0];
	_object setVelocity [0, 0, 0];				
	_object setVariable ["pixlogisticIsMoving", objNull, true];
};	