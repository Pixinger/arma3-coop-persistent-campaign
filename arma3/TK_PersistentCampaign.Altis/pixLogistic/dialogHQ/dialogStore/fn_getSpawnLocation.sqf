private["_cargoType"];
_cargoType = _this select 0;

private["_result"];
_result = "";

if (pixLogisticDialogHqStore_AdminSpawn) then
{
	_result = player;
}
else
{
	/* Map öffnen */
	openMap [true, true] ;

	/* Mapclick freigeben */
	player globalChat "Bitte gewünschte Lieferstelle anklicken...";
	pixLogisticMapClick = nil;		
	onMapSingleClick "pixLogisticMapClick = _pos; onMapSingleClick ''; openMap [true, false]; openMap [false, false]; true;";

	/* warten bis geklickt wurde */
	waitUntil { !(isNil "pixLogisticMapClick") };

	/* Spawnzone suchen */
	private["_objects"];
	_objects = pixLogisticMapClick nearObjects ["Land_JumpTarget_F", 100];
	if (count _objects > 0) then
	{
		private["_object"];
		_object = _objects select 0;
		
		private["_type"];
		_type = _object getVariable "pixLogisticStoreType";
		if (!isNil "_type") then
		{
			if (_type >= _cargoType) then
			{
				_result = _object;
			};
		};
	};

	/* Aufräumen */
	pixLogisticMapClick = nil;		
};

_result;
