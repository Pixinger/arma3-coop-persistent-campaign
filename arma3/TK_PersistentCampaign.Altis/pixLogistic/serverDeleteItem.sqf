if (isServer) then
{
	private["_item"];
	_item = _this select 0;

	waitUntil { !pixlogisticDbMutex };
	pixlogisticDbMutex = true;

	/*-----------------------------------*/
	/* Prüfen, ob in der Liste vorhanden */
	/*-----------------------------------*/
	if (pixlogisticDbItems find _item != -1) then
	{		
		/*-------------------------------------*/
		/* Aus der Überwachungsliste entfernen */
		/*-------------------------------------*/
		pixlogisticDbItems = pixlogisticDbItems - [_item];

		/*----------------------------*/
		/* Vehicle aus Arma entfernen */
		/*----------------------------*/
		deleteVehicle _item;
	}
	else
	{
		player globalChat "pixLogistic: Error: unable to delete item";
		diag_log "pixLogistic: Error: unable to delete item";
	};

	pixlogisticDbMutex = false;
};