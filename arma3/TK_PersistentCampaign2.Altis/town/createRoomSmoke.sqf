private["_shells"];
_shells = [];
{
	private["_shell"];
	_shell = "SmokeShell" createVehicle _x; 
	waitUntil {!isNil "_shell"};
	_shell setdammage 1;
	_shells pushBack _shell;
} foreach (_this select 0);

Sleep (3);

{
	deleteVehicle _x;
} foreach _shells;
/*
ARTY_SmokeShellWhite
SmokeShell
SmokeShellRed
SmokeShellGreen
SmokeShellYellow
SmokeShellOrange
SmokeShellPurple
SmokeShellBlue 	
Chemlight_Green
*/