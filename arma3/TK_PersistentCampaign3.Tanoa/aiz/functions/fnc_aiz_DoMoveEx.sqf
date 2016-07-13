#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

//================================================================================
// _THIS
//================================================================================
params ["_unit", "_position", ["_sit", false]];

Sleep 5;
//================================================================================
// Auf gehts
_unit doMove _position; 
_unit setBehaviour "SAFE";
_unit setSpeedMode "LIMITED";

//================================================================================
// Warten bis angekommen (oder timeout)
private _ttl = (_unit distance _position) * 1.5;
while { true } do
{
	Sleep 1;
	_ttl = _ttl - 1;
	
	if (_ttl == 0) exitWith {};
	if ((_unit distance _position) < 3) exitWith {};	
};

DEBUG_LOG_VAREX("ENDE", _unit);
//================================================================================
// Anhalten und stehen bleiben (evtl. setzen)
doStop _unit;
if (_sit) then 
{
	Sleep 0.5;
	_unit action ["SitDown", _unit];
};