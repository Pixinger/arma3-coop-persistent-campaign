if (isServer) then
{
	StaticCuratorModule addCuratorEditableObjects [(allMissionObjects "Man"), false];
	Sleep 1;
	{ StaticCuratorModule addCuratorEditableObjects [[_x], true]; } forEach allUnits;					
	Sleep 1;
	StaticCuratorModule addCuratorEditableObjects [vehicles, false];
	Sleep 1;
	StaticCuratorModule addCuratorEditableObjects [(allMissionObjects "Air"), true];
	Sleep 1;
	StaticCuratorModule addCuratorEditableObjects [(allMissionObjects "Static"), false];
	Sleep 1;
	//Sleep 1;
	//StaticCuratorModule addCuratorEditableObjects [(allMissionObjects "Thing"), false];
	//Sleep 1;
	//StaticCuratorModule addCuratorEditableObjects [(allMissionObjects "Ammo"), false];	
}
else
{
	remoteExec ["fnc_Admin_ZeusObjectRefresh", 2]; // 2= only server
};