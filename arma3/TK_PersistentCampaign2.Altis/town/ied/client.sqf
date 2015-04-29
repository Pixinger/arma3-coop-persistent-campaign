if (hasInterface) then
{
	private["_iedClassnames"];
	_iedClassnames = ["ModuleExplosive_IEDUrbanSmall_F", "ModuleExplosive_IEDLandSmall_F", "ModuleExplosive_IEDUrbanBig_F", "ModuleExplosive_IEDLandBig_F"];
	
	private["_delay"];
	_delay = 5;
	
	while { true } do
	{
		private["_ieds"];
		_ieds = (getPos player) nearEntities [_iedClassnames, 30];
		if (count _ieds > 0) then
		{
			{
				if (_x distance (getPos player) < 5) then
				{						
					if ((stance player != "PRONE") || {(count ((getPos _x) nearEntities ["SoldierEB", 50]) > 0)}) then
					{			
						private["_ied"];
						_ied = createVehicle ["Bo_GBU12_LGB", (getPos _x), [], 0, "NONE"]; // Bo_GBU12_LGB: 5000;1100
						deleteVehicle _x;
					};
				};
			} foreach _ieds;
			_delay = 1;
		}
		else
		{
			_delay = 5;
		};

		Sleep _delay;
	};
};
