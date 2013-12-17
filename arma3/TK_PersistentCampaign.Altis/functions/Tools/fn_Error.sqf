/* 
Parameter:
	_this select 0: Debugausgabe (string, number,...)

Return: 
	nix

/*-------------------------------------------------------------------*/

if (count _this == 1) then
{
	player globalChat format["Error: %1", _this select 0];
	(_this select 0) call BIS_fnc_error;		
};