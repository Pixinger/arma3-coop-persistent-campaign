if (call fnc_Town_SupportLoadCond) then
{
	private["_vehicle"];
	_vehicle = cursorTarget;
	if (_vehicle getVariable["TC", 0] < 3) then
	{
		_vehicle setVariable["TC", 3, true];
		hint "Die Hilfsgüter wurden aufgeladen. Der LKW ist jetzt voll.";
	}
	else
	{
		hint "Der LKW ist bereits voll. Noch eine Kiste mehr und die Reifen platzen! Den Ärger tue ich mir nicht an.";
	};
};