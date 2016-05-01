// Achtung! Diese Funktion darf nur aufgerufen werden, wenn auch wirklich etwas in der Queue drin ist.
// Eigentlich müsste das hier noch einmal geprüft werden, aber aus performance Gründen sparen wir das ein.
//----------------------------
// Diese Funktion entnimmt die älteste Nachricht aus der Queue.
// Zusätzlich wird geprüft, ob es noch andere Nachrichten für die gleiche Zone gibt.
// Diese werden dann alle entfernt und nur der letzte Aktivierungszustand zurückgegeben. 
// Dadurch verhindern wir, dass wir durch schnelles bewegen durch die Zonen mit dem aktivieren und deaktivieren nicht mehr nach kommen, denn die doppelten Anweisungen werden ja gleich unterdrückt.
diag_log format["fnc_dacZones_MessageQueuePop: count dacZonesMessageQueue: %1 | %2", count dacZonesMessageQueue, dacZonesMessageQueue];
private["_message"];
_message = dacZonesMessageQueue select 0;
dacZonesMessageQueue deleteAt 0;
private["_zoneId"];
_zoneId = _message select 0;	
private["_lasteState"];
_lasteState = _message select 1;

private["_i"];
_i = 0;
private["_c"];
_c = count dacZonesMessageQueue - 1;
while { _i < _c } do
{
	_message = dacZonesMessageQueue select _i;
	
	if (_message select 0 == _zoneId) then
	{
		diag_log format["fnc_dacZones_MessageQueuePop: skip douplicate at index %1: %2", _i, _message];
		_lasteState = _message select 1;
		dacZonesMessageQueue deleteAt _i;
	}
	else
	{
		_i = _i + 1;
	};
};

diag_log format["fnc_dacZones_MessageQueuePop: result=%1", [_zoneId, _lasteState]];
[_zoneId, _lasteState];