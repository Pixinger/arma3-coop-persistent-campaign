/* Ausrüstung entfernen */
if (!isServer || !isDedicated) then
{
	private["_tmp"];
	_tmp = [] spawn {
		waitUntil { player == player };
		/* Aktuelle Ausrüstung löschen */
		removeAllAssignedItems player;
		removeAllPrimaryWeaponItems player;
		removeAllHandgunItems player;
		removeAllWeapons player; 
		removeBackpack player;
		removeHeadgear player;
		removeVest player;
		player linkItem "ItemMap";
		player setVariable["pixLoadout", ""];		
			
		// Event Handlers
		player addEventHandler 
		[
			"Respawn", 
			{ 
				waitUntil { alive player };
				
				/* LoadOut zuweisen */
				private["_scriptFilename"];
				_scriptFilename = player getVariable "pixLoadout";		
				if (_scriptFilename != "") then
				{
					private["_result"];
					_result = [player, _scriptFilename] call compile preprocessFileLineNumbers "pixLogistic\dialogBarracks\applyLoadOut.sqf";	
				};				
			}
		];	
	};
};