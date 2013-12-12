/*-------------------------------------------------------*/
/* Hier wird bestimmt, welche Missionen es generell gibt */
/* [Foldername, Exercisename/description]
/*-------------------------------------------------------*/
missionsOpt_Missions = [
	"vehicleAPC",			/* 0 */
	"vehiclesAntiAir",		/* 1 */
	"vehiclesArtillery",	/* 2 */
	"vehiclesArmored",		/* 3 */
	"checkpoint",			/* 4 */
	"buildingTower",		/* 5 */
	"buildingBunker",		/* 6 */
	"ammobox",				/* 7 */
	"killOfficer",			/* 8 */
	"retrieveIntel",		/* 9 */
	"killOfficerBuilding"	/* 10 */
	/*"inspect"*/
	];

missionsOpt_MissionPlayers = [
	7, /*"vehicleAPC",			/* 0 */
	9, /*"vehiclesAntiAir",		/* 1 */
	9, /*"vehiclesArtillery",	/* 2 */
	9, /*"vehiclesArmored",		/* 3 */
	5, /*"checkpoint",			/* 4 */
	7, /*"buildingTower",		/* 5 */
	7, /*"buildingBunker",		/* 6 */
	7, /*"ammobox",				/* 7 */
	7, /*"killOfficer",			/* 8 */
	7, /*"retrieveIntel"		/* 9 */
	7 /*"killOfficerBuilding"	/* 10 */
	/*6  /*"inspect"				/* 11 */
];

IF (isServer && !isDedicated) then 
{	/* debug modus */
	missionsOpt_DefaultMarkerRadius = 10;
}
else
{
	missionsOpt_DefaultMarkerRadius = 500;
};