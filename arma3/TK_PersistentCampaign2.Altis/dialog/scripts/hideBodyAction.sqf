private["_unit"];
_unit = cursorTarget;
if (((_unit isKindOf "SoldierGB") || (_unit isKindOf "Civilian_F")) && (!alive _unit)) then 
{	
	deleteVehicle _unit;
	hint "Die Person wurde bestattet. Die Bevölkerung findet das gut. Informationen haben Sie keine gefunden.";
};