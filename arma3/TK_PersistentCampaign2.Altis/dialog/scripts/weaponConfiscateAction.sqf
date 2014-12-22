if (cursorTarget isKindOf "GroundWeaponHolder") then  
{ 
	deleteVehicle cursorTarget;
	hint "Die Waffen wurden konfisziert.";
} 
else 
{ 
	hint "Es wurden keine Waffen gefunden.";
};