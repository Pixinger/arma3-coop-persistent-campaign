/*if (ExecuteHeadlessCode) then
{
	townInitialized = false;
	publicVariable "townInitialized";

	private["_towns"];
	_towns = entities pixTown_ConfigObjectClassname;
	{
		if (_foreachIndex < 10) then
		{
			[_x] execVM "town\run.sqf";
		};
	} foreach _towns;

	townInitialized = true;
	publicVariable "townInitialized";
};

if (hasInterface) then
{
	waitUntil { !(isNil "townInitialized") };
};
*/