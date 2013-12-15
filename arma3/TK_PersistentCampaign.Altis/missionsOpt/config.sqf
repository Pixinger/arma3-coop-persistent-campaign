/*-------------------------------------------------------*/
/* Hier wird bestimmt, welche Missionen es generell gibt */
/* [Foldername, Exercisename/description]
/*-------------------------------------------------------*/
missionsOpt_Missions = [
	"vehicle",				/* 0 */
	"vehicles",				/* 1 */
	"checkpoint",			/* 2 */
	"building",				/* 3 */
	"ammobox",				/* 4 */
	"killOfficer",			/* 5 */
	"retrieveIntel",		/* 6 */
	"killOfficerBuilding"	/* 7 */
	/*"inspect"*/			/* 8 */
	];

missionsOpt_MissionPlayers = [
	7, /*"vehicle",				0 */
	9, /*"vehicles",			1 */
	9, /*"checkpoint",	 		2 */
	9, /*"building",		3 */
	3, /*"ammobox",				4 */
	7, /*"killOfficer",			5 */
	7, /*"retrieveIntel",		6 */
	7  /*"killOfficerBuilding",	7 */
	/*6  /*"inspect"			8 */
];

IF (isServer && !isDedicated) then 
{	/* debug modus */
	missionsOpt_DefaultMarkerRadius = 10;
}
else
{
	missionsOpt_DefaultMarkerRadius = 500;
};