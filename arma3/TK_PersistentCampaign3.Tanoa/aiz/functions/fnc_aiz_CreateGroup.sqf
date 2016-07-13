/* 
	Erzeugt eine Gruppe von Infantristen
	
Parameter:
	unitGroup: Gruppe
	unitPosition: [0,0,0]
	unitClassnames: Array mit den verfügbaren Classnames
	unitCount: Anzahl der Einheiten

Return: 
	_units - Array

/*-------------------------------------------------------------------*/

private["_unitGroup"];
_unitGroup = _this select 0;

private["_unitPosition"];
_unitPosition = _this select 1;

private["_unitClassnames"];
_unitClassnames = _this select 2;

private["_unitCount"];
_unitCount = _this select 3;

private["_units"];
_units = [];
for "_i" from 1 to _unitCount do
{
	private["_unit"];
	_unit = _unitGroup createUnit [_unitClassnames call PIX_fnc_RandomElement, _unitPosition, [], 0, "FORM"];
	Sleep 0.5;
	_units pushBack _unit;
};
_units;