private["_button"];
_button = ["Bewohner befragen", false, true,"dialog\scripts\talkCivilianAction.sqf"];
private["_civ"];
_civ = cursorTarget;
if ((_civ isKindOf "Civilian_F") && (alive _civ) && (_civ distance player < 5)) then 
{
	_button set [1, true];
};
_button;

