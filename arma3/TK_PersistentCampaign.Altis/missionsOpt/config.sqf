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

/* Gibt an, ob diese Mission gespielt werden darf, wenn die Missionen ohne AI gespielt werden. */
missionsOpt_ValidFor_NoAI = [
	true,   /*"zeus",					0 */
	true, 	/*"vehicle",				1 */
	true, 	/*"vehicles",				2 */
	false, 	/*"checkpoint",	 			3 */
	true, 	/*"building",				4 */
	true, 	/*"ammobox",				5 */
	true, 	/*"killOfficer",			6 */
	true, 	/*"retrieveIntel",			7 */
	true, 	/*"killOfficerBuilding",	8 */
	true, 	/*"captureOfficer",			9 */
	true, 	/*"captureScientist",		10 */
	true, 	/*"vehicleCapture"			11 */
	false, 	/*"cqb"						12 */
	true,	/*"diveCapture"				13 */
	true	/*"diveDestroy"				14 */
	];

/* Gibt an, ob diese Mission gespielt werden darf, wenn ein ZonePreset gestartet wird. */
missionsOpt_ValidFor_Preset = [
	false,   /*"zeus",					0 */
	true, 	/*"vehicle",				1 */
	true, 	/*"vehicles",				2 */
	true, 	/*"checkpoint",	 			3 */
	true, 	/*"building",				4 */
	true, 	/*"ammobox",				5 */
	true, 	/*"killOfficer",			6 */
	true, 	/*"retrieveIntel",			7 */
	true, 	/*"killOfficerBuilding",	8 */
	true, 	/*"captureOfficer",			9 */
	true, 	/*"captureScientist",		10 */
	true, 	/*"vehicleCapture"			11 */
	true, 	/*"cqb"						12 */
	true,	/*"diveCapture"				13 */
	true	/*"diveDestroy"				14 */
	];
	
IF (isServer && !isDedicated) then 
{	/* debug modus */
	missionsOpt_DefaultMarkerRadius = 10;
}
else
{
	missionsOpt_DefaultMarkerRadius = 500;
};