/*-------------------------------------------------------*/
/* Hier wird bestimmt, welche Missionen es generell gibt */
/* [Foldername, Exercisename/description]
/*-------------------------------------------------------*/
missionsOpt_Missions = [
	"zeus",					/* 0 */
	"vehicle",				/* 1 */
	"vehicles",				/* 2 */
	"checkpoint",			/* 3 */
	"building",				/* 4 */
	"ammobox",				/* 5 */
	"killOfficer",			/* 6 */
	"retrieveIntel",		/* 7 */
	"killOfficerBuilding",	/* 8 */
	"captureOfficer",		/* 9 */
	"captureScientist",		/* 10 */
	"vehicleCapture",		/* 11 */
	"cqb",					/* 12 */
	"diveCapture",			/* 13 */
	"diveDestroy"			/* 14 */
	];

missionsOpt_MissionPlayers = [
	100,/*"zeus",					0 */
	7, 	/*"vehicle",				1 */
	9, 	/*"vehicles",				2 */
	9, 	/*"checkpoint",	 			3 */
	9, 	/*"building",				4 */
	5, 	/*"ammobox",				5 */
	7, 	/*"killOfficer",			6 */
	7, 	/*"retrieveIntel",			7 */
	7, 	/*"killOfficerBuilding",	8 */
	9, 	/*"captureOfficer",			9 */
	9, 	/*"captureScientist",		10 */
	9, 	/*"vehicleCapture"			11 */
	9, 	/*"cqb"						12 */
	9,	/*"diveCapture"				13 */
	9	/*"diveDestroy"				14 */
	];

IF (isServer && !isDedicated) then 
{	/* debug modus */
	missionsOpt_DefaultMarkerRadius = 10;
}
else
{
	missionsOpt_DefaultMarkerRadius = 500;
};