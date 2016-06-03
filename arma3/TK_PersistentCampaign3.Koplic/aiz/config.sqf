aizDbPrefix = "PC3AIZ";
aizZoneCount = 16;

aizCampTownClassnames = ["Land_Laptop_unfolded_F","Land_DataTerminal_01_F","Land_SatellitePhone_F"];
aizCampTownMinRespawnDistance = 150;

aizCampFieldClassnames = ["Land_TentDome_F", "Land_TentA_F"];
aizCampFieldMinRespawnDistance = 250;
aizCampFieldRadius = 50;

aizAISkillMin = 0.5;
aizAISkillMax = 0.5;

aizGroupSizeMin = 2;
aizGroupSizeMax = 5;

// ------------------------------------------------------------------------------
// Runtime Variablen initialisieren (nicht verändern!)
aizZonesSaving = false;
aizZoneInitCompleted = false;
aizZoneActive = [];
aizZoneActiveCounter = 0;

aizGroupMarkerCounter = 0; //TODO: Remove later