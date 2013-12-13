if (!isServer || !isDedicated) then
{	
	pixRevive_IsDragging = true;

	private ["_target"];
	_target = _this select 0;
	
	_target attachTo [player, [0, 1.1, 0.092]];
	_target setDir 180;
	_target setVariable ["pixRevive_DRG", 1, true];
	
	player playMoveNow "AcinPknlMstpSrasWrflDnon";
	
	/* Rotation fix */
	pvehPixReviveDragging = _target;
	publicVariable "pvehPixReviveDragging";
	
	/* Add release action and save its id so it can be removed */
	private["_menuId"];
	_menuId = player addAction ["<t color=""#C90000"">" + "Release" + "</t>", "pixRevive\actionRelease.sqf", [], 10, true, true, "", "true"];	
	hint "Press 'C' if you can't move.";
	
	/* Das ziehen überwachen, bis es abgebrochen werden soll. Das können viele Gründe sein */
	while { 
		(alive player) && 
		((player getVariable "pixRevive_UNC") == 0) &&
		(alive _target) &&
		((_target getVariable "pixRevive_UNC") == 1) &&
		(pixRevive_IsDragging) && 
		((_target getVariable "pixRevive_DRG") == !) } do
	{
		Sleep 1;
	};

	/* Signalisieren, dass das Draggen beendet ist */
	pixRevive_IsDragging = false;
	
	/* Wenn es noch ein Target gibt und das auch noch lebt, dann normal ablegen */
	if (!isNull _target && alive _target) then
	{
		_target switchMove "AinjPpneMstpSnonWrflDnon";
		_target setVariable ["pixRevive_DRG", 0, true];
	};
	
	/* detachen */
	detach _target;
	
	/* Menu entfernen */
	player removeAction _menuId;
};