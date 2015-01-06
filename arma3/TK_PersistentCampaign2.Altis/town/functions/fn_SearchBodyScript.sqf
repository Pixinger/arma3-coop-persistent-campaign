if (call fnc_Town_SearchBodyCond) then
{
	private["_units"];
	_units = (position player) nearObjects ["CAManBase", 2];

	if (count _units > 0) then
	{
		{
			if (!alive _x) then { deleteVehicle _x; };
		} foreach _units;
		hint "Die Person wurde bestattet. Die Bevölkerung findet das gut. Informationen haben Sie keine gefunden.";
	};
};