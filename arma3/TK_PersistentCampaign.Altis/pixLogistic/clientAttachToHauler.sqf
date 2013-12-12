private["_vehicle"];
_vehicle = vehicle player;

if (driver _vehicle == player) then
{
	private["_behind"];
	_behind = _vehicle modelToWorld [0,-8,0]; 
	private["_vehicleCargo"];
	_vehicleCargo = _vehicle getVariable "pixlogisticCargo";
	if (isNil "_vehicleCargo") then 
	{
		private["_cargos"];
		_cargos = nearestObjects [_behind, pixlogisticHaulerCargos, 5];
		if (count _cargos > 0) then
		{
			private["_cargo"];
			_cargo = _cargos select 0;
			_vehicle setVariable ["pixlogisticCargo",_cargo,true];			
			
			if (_cargo isKindOf "Cargo_base_F") then /*((typeof _cargo == "B_APC_Wheeled_01_cannon_F") || (typeof _cargo == "B_MRAP_01_gmg_F")) then /*"B_MRAP_01_gmg_F"*/
			{
				_cargo attachTo [_vehicle, [0,-2.7,1]]; /*_cargo attachTo [_vehicle, [0,-2.7,1]]; */				
				/*_cargo setDir 90;*/
				/*_cargo setVectorDirAndUp [[0,1,0],[0,0,1]];  /*[[1,0,0],[0,0,1]]; */
			}
			else
			{
				private["_boundingBox"];
				_boundingBox = boundingBoxReal _cargo; /*An array with the extreme points of the model. Format [[x1,y1,z1],[x2,y2,z2]]. */
				private["_p1"];
				_p1 = _boundingBox select 0; 
				private["_p2"];
				_p2 = _boundingBox select 1; 
				private["_maxWidth"];
				_maxWidth = abs ((_p2 select 0) - (_p1 select 0)); 
				private["_maxLength"];
				_maxLength = abs ((_p2 select 1) - (_p1 select 1)); 
				private["_maxHeight"];
				_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
			
				_cargo attachTo [_vehicle, [0,-4.5 - (_maxWidth),1]]; 
				/*_cargo attachTo [_vehicle, [0,-4.5 - (_maxWidth / 2),1]]; */
				/*_cargo setVectorDirAndUp [[0,1,0],[0,1,1]];  /*[[1,0,0],[0,0,1]]; */
			};
			player globalChat "Fracht aufgeladen";
		}
	}
	else
	{
		/* Entkoppeln */
		detach _vehicleCargo;
		_vehicleCargo setPos _behind;	
		_vehicle setVariable ["pixlogisticCargo",nil,true];			
		player globalChat "Fracht abgeladen";		
	};
};

