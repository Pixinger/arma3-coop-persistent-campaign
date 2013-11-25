/*
 Prüft ob eine bestimmte Zone von den OpFor Kräften angegriffen werden kann.
 Result: Ein Array mit den Red-Zones welche die Green-Zone angreifen können.
		 Das Array ist leer, wenn ein Angriff nicht möglich ist.
*/

private["_greenZoneIndex"];
_greenZoneIndex = _this select 0; /* Der zu prüfende Green-ZonenIndex */

/* Gesprochen prüfen wir hier folgendes: _greenZoneIndex can be engaged from OpFor when Zones [zone1Index,zone2Index,..] are RED.*/
private["_redZones"];
_redZones = pixZones_ZoneOpForEngagementConditions select _zoneIndex;

private["_result"];
_result = [];
{
	if (_x < 3) then
	{ 
		_result = _result + [_x];
	};
} foreach _redZones;

_result;