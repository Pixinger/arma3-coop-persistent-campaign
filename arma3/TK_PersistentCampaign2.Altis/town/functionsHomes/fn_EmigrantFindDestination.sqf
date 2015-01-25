/*
Parameter:
	_townCenter: _this select 0;
	
Result:
	townname oder ""
	*/

private["_townCenter"];
_townCenter = _this select 0;

private["_towns"];
_towns = _townCenter nearEntities [pixTown_ConfigObjectClassname, 5000];
{
	private["_townName"];
	_townName = _x getVariable ["townName", ""];
	if (_townName != "") then
	{
	//	// [name, civ, red, injured, mood, food, water, maxpeople]
	//	private["_status"];
	//	_status = missionNamespace getVariable [format["T1_%1", _townName], ["unknown", 0,0,0,0,0,0,0]];
		
	};		
} foreach _towns;
	
"";
