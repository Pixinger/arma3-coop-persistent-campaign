/*
Überprüft eine Liste mit aktiven Einheiten, ob der jeweilige FSM tick noch aktuell ist.
Ist er veraltet, wird die FSM neu gestartet.

Parameter:
	_unitsActive: Das zu prüfende Array.

Return: 
	true
	
*/

private["_unitsActive"];
_unitsActive = _this select 0;

private["_timeoutTick"];
_timeoutTick = time;

{
	private["_unit"];
	_unit = _x select 0;
	if (!isNull _unit) then 
	{
		if ((behaviour _unit) == "CARELESS") then
		{
			if (_unit getVariable ["fsmtick", 0] < _timeoutTick) then
			{	
				diag_log format["fsmtick timed out. doFSM civHome.fsm for unit: %1", _unit];
				_unit doFSM ["town\fsm\civHome.fsm", [0,0,0], _unit];
			};
		};
	};
} foreach _unitsActive;

true;