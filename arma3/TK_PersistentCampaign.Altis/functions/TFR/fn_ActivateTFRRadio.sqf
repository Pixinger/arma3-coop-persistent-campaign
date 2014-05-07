waitUntil {!isNull player};
waitUntil {alive player};

private["_timeout"];
_timeout = time + 20;
while {_timeout > time } do
{
	Sleep 1;
	if (!call TFAR_fnc_haveSWRadio) then
	{
		/* Maybe there are inactive radios somewhere in the uniform */
		private["_radios"];
		_radios = call TFAR_fnc_radiosList;
		if (count _radios > 0) then
		{ 
			player assignItem (_radios select 0); 
			_timeout = 0; 
		};
	}
	else
	{
		_timeout = 0;
	};
};

if (call TFAR_fnc_haveSWRadio) then
{
	player globalChat "INFO: TFR device available.";
}
else
{
	player globalChat "ERROR: Unable to activate TFR device.";
};
	