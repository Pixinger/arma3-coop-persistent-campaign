if (isServer) then
{
	/* Zeit auslesen */
	private["_newDate"];	
	if (pixParamTimeSettings == 24) then
	{
		_newDate = floor (random 24);
	}
	else
	{
		_newDate = pixParamTimeSettings;		
	};
	
	/* Zeit einmalig auf dem Server setzen. Ab jetzt l�uft sie selbstst�ndig */
	setDate [2013, 5, 1, _newDate, 0];
	
	Sleep 1;

	/* Die Clienten regelm��ig informieren */
	while {true} do
	{
		pvehPixTimeUpdate = date;
		publicVariable "pvehPixTimeUpdate";
		Sleep (60*5);
	};
};