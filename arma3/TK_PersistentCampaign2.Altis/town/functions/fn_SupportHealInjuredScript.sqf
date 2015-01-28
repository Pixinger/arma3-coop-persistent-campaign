if (call fnc_Town_SupportHealInjuredCond) then
{
	private["_units"];
	_units = (position player) nearObjects [pixTown_ConfigBaseClassCiv, 2];
	{	
		if (alive _x) then
		{
			_x setVariable ["TI", 0, true];
		};
	} foreach _units;	

	player sidechat format["%1 wurde(n) medizinisch versorgt.", _units];
};