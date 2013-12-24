private["_timeout"];
_timeout = time + 10;
while {_timeout > time } do
{
	Sleep 1;
	if (!call haveSWRadio) then
	{
		/* Maybe there are inactive radios somewhere in the uniform */
		private["_radios"];
		_radios = call radiosList;
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

if (call haveSWRadio) then
{
	player globalChat "INFO: TFR Radio available.";
}
else
{
	player globalChat "ERROR: Unable to active TFR Radio.";
};
	