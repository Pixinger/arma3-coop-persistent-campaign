//[5] call fnc_aiz_ZoneInit;

if (isServer) then
{
	for "_i" from 0 to 65 do 
	{
		[_i] call fnc_aiz_ZoneInit;
	};
};
