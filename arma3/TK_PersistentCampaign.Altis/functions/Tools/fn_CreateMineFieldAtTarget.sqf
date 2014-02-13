/* 
	Erzeugt ein Minenfeld.
	
Parameter:
	_positionTarget: Die Position des Targets
	_types: Die zu verwendenden Minentypen: ["APERSMine"]	
			-APERSMine
			-APERSBoundingMine
			-APERSTripMine
			-ATMine
			-SLAMDirectionalMine
			-UnderwaterMine

Return: 
	Always true.

/*-------------------------------------------------------------------*/

private["_positionTarget"];
_positionTarget = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;

private["_types"];
_types = [_this, 1, [[]]] call BIS_fnc_param;

/*-------------------------------------------------------------------*/

private["_mineCount"];
_mineCount = 20 + random 40;
private["_mineDensity"];
_mineDensity = 600 + random 400;

private["_mineFieldRadius"];
_mineFieldRadius = sqrt((_mineCount*_mineDensity) / 3.1413);

private["_translationDistance"];
_translationDistance = _mineFieldRadius + 20 + random 400;
private["_translationAngle"];
_translationAngle = random 359;

private["_minePosX"];
_minePosX = (_missionPosition select 0) + (_translationDistance * cos(_translationAngle));
private["_minePosY"];
_minePosY = (_missionPosition select 1) + (_translationDistance * sin(_translationAngle));

[[_minePosX,_minePosY,0], _mineFieldRadius, _mineCount, _types] call PC_fnc_CreateMineField;

true;