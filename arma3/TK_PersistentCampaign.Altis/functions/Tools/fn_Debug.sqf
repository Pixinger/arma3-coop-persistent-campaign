/* 
Parameter:
	_this select 0: Debugausgabe (string, number,...)

Return: 
	nix

/*-------------------------------------------------------------------*/

if (pixDebug) then 
{
	if (count _this == 1) then
	{
		player globalChat format["Debug: %1", _this select 0];
		(_this select 0) call BIS_fnc_log;		
	};
};