/* Diese Function prüft, ob der Spieler sich selbst umbringen kann */
	
if (!alive player) exitWith { false };
if ((player getVariable "pixRevive_UNC") == 0) exitWith { false };

true