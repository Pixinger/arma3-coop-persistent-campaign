if (call fnc_Town_SupportHelpStartCond) then
{
	private["_vehicle"];
	_vehicle = cursorTarget;

	private["_active"];
	_active = _vehicle getVariable ["TA", false];
	if (!_active) then
	{
		_vehicle setVariable["TA", true, true];	
		hint "Die Hilfsaktion wurde gestartet.";
	};
};
