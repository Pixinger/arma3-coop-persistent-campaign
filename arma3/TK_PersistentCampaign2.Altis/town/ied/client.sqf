if (hasInterface) then
{
	private["_iedClassnames"];
	_iedClassnames = ["ModuleExplosive_IEDUrbanSmall_F", "ModuleExplosive_IEDLandSmall_F", "ModuleExplosive_IEDUrbanBig_F", "ModuleExplosive_IEDLandBig_F"];
	
	private["_delay"];
	_delay = 5;
	
	while { true } do
	{
		if (!(player getVariable ['AGM_IsEOD', false])) then
		{
			private["_ieds"];
			_ieds = (getPos player) nearEntities [_iedClassnames, 50];
			if (count _ieds > 0) then
			{
				{
					if (_x distance (getPos player) < 5) then
					{
						//tankyied = createVehicle ["ARTY_R_120mm_HE_Rocket", [_iedxpos, _iedypos], [], 0, "NONE"];
						//tankyied = createVehicle ["Sh_85_AP", [_iedxpos, _iedypos], [], 0, "NONE"];//NOISE (camel is silent)
						//tankyied = createVehicle ["G_Camel_HE", [_iedxpos, _iedypos], [], 0, "NONE"];//SPLODE 
						//tankyied = createVehicle ["M_CRV7_FAT", [_iedxpos, _iedypos], [], 0, "NONE"];
						private["_ied"];
						_ied = createVehicle ["Bo_GBU12_LGB", (getPos _x), [], 0, "NONE"];
						deleteVehicle _x;
					};
				} foreach _ieds;				
				
				_delay = 1;
			};

			Sleep _delay;
		}
		else
		{
			Sleep 30;
		};
	};
};
