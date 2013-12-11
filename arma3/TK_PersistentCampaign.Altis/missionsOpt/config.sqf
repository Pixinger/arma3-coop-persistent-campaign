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
	6, /*"vehicleAPC",			/* 0 */
	8, /*"vehiclesAntiAir",		/* 1 */
	8, /*"vehiclesArtillery",	/* 2 */
	8, /*"vehiclesArmored",		/* 3 */
	4, /*"checkpoint",			/* 4 */
	6, /*"buildingTower",		/* 5 */
	6, /*"buildingBunker",		/* 6 */
	6, /*"ammobox",				/* 7 */
	6, /*"killOfficer",			/* 8 */
	6, /*"retrieveIntel"		/* 9 */
	6 /*"killOfficerBuilding"	/* 10 */
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