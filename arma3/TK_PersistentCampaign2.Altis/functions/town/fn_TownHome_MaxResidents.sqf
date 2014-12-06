/*
Diese Funktion sucht eine unbewohnte Position in dem übergebenen Home-Array.
 
Parameter:
	_homes: Das zu belegende Home-Array.

Return: 
	_maxResidents: Die maximale Anzahl der Bewohner für dieses Home-Array.
	
*/

private["_result"];
_maxResidents = 0;

private["_homes"];
_homes = _this select 0;

// Zunächst versuchen eine Position ZUFÄLLIG zu bestimmen.
private["_countHomes"];
_countHomes = count _homes;

for "_homeIndex" from 0 to _countHomes-1 do
{
	private["_home"];
	_home = _homes select _homeIndex;
	_maxResidents = _maxResidents + count (_home select 1);
};

_maxResidents;