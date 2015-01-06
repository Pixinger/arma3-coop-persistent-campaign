if (call fnc_Town_HealInjuredCond) then
{
	private["_units"];
	_units = (position player) nearObjects ["CAManBase", 2];
	if (count _units > 0) then
	{	
		(_units select 0) setVariable ["TI", 0, true];
		player sidechat format["%1 wurde medizinisch versorgt.", (_units select 0)];
	};
};