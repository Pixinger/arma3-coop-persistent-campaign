adminPlayerTeleport = !adminPlayerTeleport;
publicVariable "adminPlayerTeleport";

if (adminPlayerTeleport) then {
	hint "Spieler können sich nun selbst teleportieren.";
} else {
	hint "Spieler können sich NICHT mehr selbst teleportieren.";
};