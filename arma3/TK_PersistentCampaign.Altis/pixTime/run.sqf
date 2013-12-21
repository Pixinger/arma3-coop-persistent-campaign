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
	
	/* Zeit einmalig auf dem Server setzen. Ab jetzt l‰uft sie selbstst‰ndig */
	setDate [2013, 5, 1, _newDate, 0];
	
	/* Die Clienten regelm‰ﬂig informieren */
	while {true} do
	{
		pvehPixlogisticInsertItem = date;
		publicVariable "pvehPixlogisticInsertItem";
		Sleep (60*5);
	};
};