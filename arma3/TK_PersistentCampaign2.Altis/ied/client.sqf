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
						
						// Smoke_120mm_AMOS_White
						// ATMine_Range_Ammo:				"hit"=>2000, 	"indirecthit"=>2000, 	"indirecthitrange"=>5
						// Bo_GBU12_LGB: 					"hit"=>5000, 	"indirecthit"=>1100, 	"indirecthitrange"=>12
						// BoundingMineCore: 				"hit"=>750, 	"indirecthit"=>750, 	"indirecthitrange"=>5
						// DemoCharge_Remote_Ammo: 		"hit"=>1500, 	"indirecthit"=>1500, 	"indirecthitrange"=>10
						// G_20mm_HE:						"hit"=>8, 	"indirecthit"=>6, 	"indirecthitrange"=>4
						// G_40mm_HE:						"hit"=>10, 	"indirecthit"=>8, 	"indirecthitrange"=>6
						// G_40mm_HEDP:					"hit"=>24, 	"indirecthit"=>12, 	"indirecthitrange"=>2
						// IEDLandBig_Remote_Ammo			"hit"=>2000, 	"indirecthit"=>2000, 	"indirecthitrange"=>2
						// IEDUrbanBig_Remote_Ammo			"hit"=>1500, 	"indirecthit"=>1500, 	"indirecthitrange"=>15
						// IEDLandSmall_Remote_Ammo 		"hit"=>1000, 	"indirecthit"=>1000, 	"indirecthitrange"=>2
						// IEDUrbanSmall_Remote_Ammo 		"hit"=>500, 	"indirecthit"=>500, 	"indirecthitrange"=>5
						// SatchelCharge_Remote_Ammo 		"hit"=>2000, "indirecthit"=>2000, 	"indirecthitrange"=>20
						// M_Mo_120mm_AT 					"hit"=>600, 	"indirecthit"=>50, 	"indirecthitrange"=>2
						// M_Scalpel_AT					"hit"=>1400, 	"indirecthit"=>50, 	"indirecthitrange"=>6.5
						// TimeBombCore   				"hit"=>700, 	"indirecthit"=>700, 	"indirecthitrange"=>7
						// SLAMDirectionalMine_Wire_Ammo 	"hit"=>1000, "indirecthit"=>1000, 	"indirecthitrange"=>10
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
