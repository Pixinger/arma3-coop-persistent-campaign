/* Ausr�stung entfernen */
if (!isServer || !isDedicated) then
{
	private["_tmp"];
	_tmp = [] spawn {
		waitUntil { player == player };
		Sleep 2;
		/* Aktuelle Ausr�stung l�schen */
		removeAllAssignedItems player;
		removeAllPrimaryWeaponItems player;
		removeAllHandgunItems player;
		removeAllWeapons player; 
		removeBackpack player;
		removeHeadgear player;
		removeVest player;
		removeUniform player;
		removeGoggles player;
		player addUniform "U_C_Poloshirt_redwhite";
	};
};