private["_unit"];
_unit = cursorTarget;
if (!alive _unit) then
{	
	if ((_unit isKindOf "SoldierGB") || (_unit isKindOf "SoldierWB") || (_unit isKindOf "Civilian_F")) then 
	{
		deleteVehicle _unit;
		hint "Die Person wurde bestattet. Die Bevölkerung findet das gut. Informationen haben Sie keine gefunden.";
	};
};