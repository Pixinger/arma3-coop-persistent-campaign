private["_vehicle"];
_vehicle = cursorTarget;
if ((_vehicle isKindOf pixTown_ConfigSaniClassname) && ((_vehicle distance player) < 10)) then 
{
	if ((count nearestObjects[(getPos _vehicle), pixTown_ConfigReSupplyClassnames, 100]) > 0) then
	{
		if (_vehicle getVariable["content", 0] < 3) then
		{
			_vehicle setVariable["content", 3];
			hint "Die Hilfsgüter wurden aufgeladen. Der LKW ist jetzt voll.";
		}
		else
		{
			hint "Der LKW ist bereits voll. Noch eine Kiste mehr und die Reifen platzen! Den Ärger tue ich mir nicht an.";
		};
	};
};