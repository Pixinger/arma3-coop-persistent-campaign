#define ATTACHPOINT_INDEX			0
#define ATTACHROTATION_INDEX		1
#define DETACHHEIGHT_INDEX 			2
#define BUILDSPEED_INDEX			3
#define REQUIREDRESOURCES_INDEX		4

if (!isNil "logisticBuild") exitWith { hint "Du schlimmer Schelm. Du denkst wohl so geht es schneller? hä?!"; logisticBuild = false;};
// -------------------------------------------------------
private _object = _this select 0;

// -------------------------------------------------------
private _direction = _this select 1;

// -------------------------------------------------------
// _config übernehmen / laden
private _config = [];
if (count _this >= 3) then 
{
	_config = _this select 2;
}
else 
{
	private _configIndex = logisticBuildables find (typeof(_object));
	if (_configIndex != -1) exitWith {_config = logisticBuildableConfigs select _configIndex;};
};
if (count _config == 0) exitWith 
{ 
	hint "Dieses Objekt kann nicht verändert werden.";
};
// -------------------------------------------------------


private _position = getPosATL _object;
private _buildSpeed = _config select BUILDSPEED_INDEX;
private _downPosition = [((getPos _object) select 0), ((getPos _object) select 1), (_config select DETACHHEIGHT_INDEX)];
private _classname = typeof _object;

private _actionMenu = player addAction [("<t color=""#dddd00"">Bauen abschliessen</t>"), { logisticBuild = false; }, nil, 5, true, true];
		
private _autoStop = false;
if (_direction > 0) then
{
	if (_position select 2 < -0.5) then {_autoStop = true;};	
}
else
{
	if (_position select 2 > 0.5) then {_autoStop = true;};	
};

// Globales Objekt nach unten setzen, damit es nicht mehr im Weg ist.
_object setPosATL _downPosition;

// Lokales Objekt erzeugen
private _objectLocal = _classname createVehicleLocal _position;
waitUntil {!isNil "_objectLocal"};
_objectLocal setPosATL _position;
_objectLocal setDir (getDir _object);

// Animation starten
call fnc_Logistic_WorkAnimationStart;

// Lokales Objekt verändern (hoch oder runter)
#define SLEEP_TIME	2
logisticBuild = true;
while {(logisticBuild) && (alive player) } do
{
	_position = getPosATL _objectLocal;
	_position = [_position select 0, _position select 1, (_position select 2) + ((_buildSpeed / (60/SLEEP_TIME)) * _direction)];
	if (_autoStop) then
	{
		if (_direction > 0) then
		{
			if (_position select 2 > 0) then
			{
				logisticBuild = false;
				_position set [2,0];
			};	
		}
		else
		{
			if (_position select 2 < 0) then
			{
				logisticBuild = false;
				_position set [2,0];
			};	
		};
	};
	player sidechat format["height: %1", _position select 2];
	_objectLocal setPosATL _position;

	// Erst am Ende Warten, sonst wird bei Abbruch noch einmal zuviel ausgebaut.
	Sleep SLEEP_TIME;
};
call fnc_Logistic_WorkAnimationEnd;

// Lokales Objekt löschen
deleteVehicle _objectLocal;

// Globales Objekt auf richtige Position schieben
_object setPosATL _position;

player removeAction _actionMenu;
logisticBuild = nil;