cfgAizDbPrefix = "PC3AIZTANOA";
cfgAizZoneCount = 27;

cfgAizSupportForceCampSearchRadius = 1000;
cfgAizCampTownClassnames = ["Land_Laptop_unfolded_F","Land_SatellitePhone_F"];
cfgAizCampTownMinRespawnDistance = 150;

cfgAizCampFieldClassnames = ["Land_TentDome_F", "Land_TentA_F"];
cfgAizCampFieldMinRespawnDistance = 250;
cfgAizCampFieldRadius = 50;

cfgAizGroupSizeMin = paramsArray select 0;
if (pixDebug) then { cfgAizGroupSizeMin = 2;};
diag_log format["INFO: cfgAizGroupSizeMin: %1", cfgAizGroupSizeMin];

cfgAizGroupSizeMax = paramsArray select 1;
if (pixDebug) then { cfgAizGroupSizeMax = 2;};
diag_log format["INFO: cfgAizGroupSizeMax: %1", cfgAizGroupSizeMax];

cfgAizAISkillMin = 0.5;
cfgAizAISkillMax = 0.5;

cfgAizForceCheckpointRecreation = paramsArray select 2;
cfgAizForceCheckpointRecreation = if (cfgAizForceCheckpointRecreation == 1) then { true } else { false };
if (pixDebug) then { cfgAizForceCheckpointRecreation = true;};
diag_log format["INFO: cfgAizForceCheckpointRecreation: %1", cfgAizForceCheckpointRecreation];

cfgAizShowFinishedZones = paramsArray select 3;
cfgAizShowFinishedZones = if (cfgAizShowFinishedZones == 1) then { true } else { false };
if (pixDebug) then { cfgAizShowFinishedZones = true;};
diag_log format["INFO: cfgAizShowFinishedZones: %1", cfgAizShowFinishedZones];

// ------------------------------------------------------------------------------
// Runtime Variablen initialisieren (nicht verändern!)
aizZonesSaving = false;
aizZoneInitCompleted = false;
aizZoneActive = [];
aizZoneActiveCounter = 0;

aizGroupMarkerCounter = 0; //TODO: Remove later