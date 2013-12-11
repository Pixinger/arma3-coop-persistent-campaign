player globalChat format["pu: %1", allUnits];
/* Alle verfügbaren Gruppen auflisten */
private["_groups"];
_groups = [];
{
	if (!((group _x) in _groups)) then
	{
		_groups = _groups + [group _x];
	};
} foreach playableUnits;
player globalChat "B";


{
	[format["Groups: %1 / %2", _x, leader _x]] call PC_fnc_Debug;
} foreach _groups;

player globalChat "C";

if (count _groups > 0) then
{
	[player] join grpNull;
	Sleep 1;
	[player] join (_groups select 0);
	player globalChat "joined group";
};

player globalChat "D";
