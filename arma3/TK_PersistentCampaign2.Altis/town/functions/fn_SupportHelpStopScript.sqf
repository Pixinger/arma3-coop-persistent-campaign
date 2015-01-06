if (call fnc_Town_SupportHelpStopCond) then
{
	private["_vehicle"];
	_vehicle = cursorTarget;

	private["_active"];
	_active = _vehicle getVariable ["TA", false];
	if (_active) then
	{
		_vehicle setVariable["TA", false, true];	
		hint "Die Hilfsaktion wurde beendet.";
	};
};
