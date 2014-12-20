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
	if (!isNull (_x select 0)) then 
	{
		if ((_x select 0) getVariable ["fsmtick", 0] < _timeoutTick) then
		{	
			diag_log format["fsmtick timed out. FSM restart for unit: %1", _x select 0];
			(_x select 0) doFSM ["town\fsm\civHome.fsm", [0,0,0], (_x select 0)];			
		};
	};
} foreach _unitsActive;

true;