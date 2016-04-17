#define ATTACHPOINT_INDEX			0
#define ATTACHROTATION_INDEX		1
#define DETACHHEIGHT_INDEX 			2
#define BUILDSPEED_INDEX			3
#define REQUIREDRESOURCES_INDEX		4

if (!isNil "logisticBuild") exitWith { hint "Du schlimmer Schelm. Du denkst wohl so geht es schneller? hä?!"; logisticBuild = false;};
// -------------------------------------------------------
private["_object"];
_object = _this select 0;

// -------------------------------------------------------
private["_direction"];
_direction = _this select 1;

// -------------------------------------------------------
// _config übernehmen / laden
private["_config"];
_config = [];
if (count _this >= 3) then 
{
	_config = _this select 2;
}
else 
{
	private["_configIndex"];
	_configIndex = logisticBuildables find (typeof(_object));
	if (_configIndex != -1) exitWith {_config = logisticBuildableConfigs select _configIndex;};
};
if (count _config == 0) exitWith 
{ 
	hint "Dieses Objekt kann nicht verändert werden.";
};
// -------------------------------------------------------


private["_position"];
_position = getPosATL _object;

private["_buildSpeed"];
_buildSpeed = _config select BUILDSPEED_INDEX;

private["_actionMenu"];
_actionMenu = player addAction [("<t color=""#dddd00"">Bauen abschliessen</t>"), { logisticBuild = false; }, nil, 5, true, true];

private["_autoStop"];
_autoStop = false;
if (_direction > 0) then
{
	if (_position select 2 < -0.5) then {_autoStop = true;};	
}
else
{
	if (_position select 2 > 0.5) then {_autoStop = true;};	
};

logisticBuild = true;
while {(logisticBuild) && (alive player) && (player distance2D _object < 5) } do
{
	Sleep 1;
	_position = getPosATL _object;
	_position = [_position select 0, _position select 1, (_position select 2) + ((_buildSpeed / 60) * _direction)];
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
	_object setPosATL _position;
};

player removeAction _actionMenu;
logisticBuild = nil;