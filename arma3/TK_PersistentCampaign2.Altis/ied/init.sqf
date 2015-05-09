if (isServer) then
{
	for "_i" from 1 to 30 do
	{
		[] spawn compile preprocessFileLineNumbers "ied\createLandIEDs.sqf";	
	};
};

if (hasInterface) then
{
	private["_tmp"];
	_tmp = [] execVM "ied\client.sqf";
};