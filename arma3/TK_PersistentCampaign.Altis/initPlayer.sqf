/* Ausrüstung entfernen */
if (!isServer || !isDedicated) then
{
	private["_tmp"];
	_tmp = [] spawn {
		waitUntil { player == player };
		Sleep 2;
		/* Aktuelle Ausrüstung löschen */
		removeAllAssignedItems player;
		removeAllPrimaryWeaponItems player;
		removeAllHandgunItems player;
		removeAllWeapons player; 
		removeBackpack player;
		removeHeadgear player;
		removeVest player;
	};
};