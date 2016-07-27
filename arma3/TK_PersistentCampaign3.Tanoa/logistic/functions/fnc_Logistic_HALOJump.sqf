#define MINALT	50

[] spawn 
{
	if (isNil "haloinprogress") then 
	{
		if ((vehicle player) isKindOf "Air") then
		{
			if ((getPos (vehicle player)) select 2 > MINALT) then
			{
				haloinprogress = true;
				// save Loadout
				[player, [player, "Inventory"]] call BIS_fnc_saveInventory; 
				removeBackpack player;
				// abspringen
				player disableCollisionWith (vehicle player);
				player allowdamage false;
				player addBackPack "B_parachute";
				unassignvehicle player;
				moveout player;
				player setDir ((getDir vehicle player) + 180);
				Sleep 1;

				waitUntil { (isTouchingGround player) || (((position player) select 2) < 1) };
				player action ["eject", vehicle player];
				Sleep 1;
				[player, [player, "Inventory"]] call BIS_fnc_loadInventory;
				player allowdamage true;		
				haloinprogress = nil;
			}
			else
			{
				hint "Unter MINALT m kann nicht abgesprungen werden.";
			};
		}
		else
		{
			hint "Nicht in einem Luftfahrzeug.";
		};
	};
};