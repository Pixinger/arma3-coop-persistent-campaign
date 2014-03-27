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
	"killOfficerBuilding",	/* 7 */
	"captureOfficer",		/* 8 */
	"captureScientist",		/* 9 */
	"vehicleCapture"		/* 10 */
	];

missionsOpt_MissionPlayers = [
	7, /*"vehicle",				0 */
	9, /*"vehicles",			1 */
	9, /*"checkpoint",	 		2 */
	9, /*"building",			3 */
	5, /*"ammobox",				4 */
	7, /*"killOfficer",			5 */
	7, /*"retrieveIntel",		6 */
	7, /*"killOfficerBuilding",	7 */
	9, /*"captureOfficer",		8 */
	9, /*"captureScientist",	9 */
	9  /*"vehicleCapture"		10 */
];

IF (isServer && !isDedicated) then 
{	/* debug modus */
	missionsOpt_DefaultMarkerRadius = 10;
}
else
{
	missionsOpt_DefaultMarkerRadius = 500;
};