/* 
	Gibt die Anzahl der aktuell verbundenen Spieler zurück. Auf einem Client-Server ist die Anzahl festgelegt. 
 
Parameter:
	keine

Return: 
	Die Anzahl der aktuellen Spieler.

/*-------------------------------------------------------------------*/

private["_currentPlayerCount"];
_currentPlayerCount = 10;//TODO: Optimieren
if (isDedicated) then { _currentPlayerCount = count playableUnits;};
_currentPlayerCount;