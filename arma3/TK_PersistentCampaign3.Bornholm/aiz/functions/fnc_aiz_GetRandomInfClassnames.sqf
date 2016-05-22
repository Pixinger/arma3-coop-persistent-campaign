private _unitCount = if (count _this == 0) then { (2 + floor (random 9)) } else { (_this select 0) };

if (_unitCount == 1) exitWith
{
	[
		["O_recon_TL_F"], 
		["O_spotter_F"], 
		["O_recon_JTAC_F"]
	] call fnc_aiz_RandomElement;
};

if (_unitCount == 2) exitWith
{
	[
		["O_recon_TL_F","O_recon_M_F"], 
		["O_spotter_F","O_sniper_F"], 
		["O_recon_JTAC_F", "O_recon_F"]
	] call fnc_aiz_RandomElement;
};

if (_unitCount == 3) exitWith
{
	[
		["O_Soldier_TL_F", "O_Soldier_AR_F", "O_medic_F"], 
		["O_Soldier_TL_F", "O_Soldier_AT_F", "O_medic_F"], 
		["O_Soldier_TL_F", "O_soldier_M_F", "O_medic_F"]
	] call fnc_aiz_RandomElement;
};

if (_unitCount == 4) exitWith
{
	[
		["O_Soldier_TL_F", "O_Soldier_AR_F", "O_medic_F", "O_Soldier_GL_F"], 
		["O_Soldier_TL_F", "O_Soldier_AT_F", "O_medic_F", "O_Soldier_GL_F"], 
		["O_Soldier_TL_F", "O_soldier_M_F", "O_medic_F", "O_Soldier_GL_F"]
	] call fnc_aiz_RandomElement;
};

if (_unitCount == 5) exitWith
{
	[
		["O_Soldier_TL_F", "O_Soldier_AR_F", "O_medic_F", "O_Soldier_GL_F", "O_Soldier_AR_F"], 
		["O_Soldier_TL_F", "O_Soldier_AT_F", "O_medic_F", "O_Soldier_GL_F", "O_Soldier_AR_F"], 
		["O_Soldier_TL_F", "O_soldier_M_F", "O_medic_F", "O_Soldier_GL_F", "O_Soldier_AR_F"]
	] call fnc_aiz_RandomElement;
};

private _result = [
		["O_officer_F", "O_Soldier_AR_F", "O_medic_F", "O_Soldier_GL_F", "O_Soldier_SL_F"], 
		["O_officer_F", "O_Soldier_AT_F", "O_medic_F", "O_Soldier_GL_F", "O_Soldier_SL_F"], 
		["O_officer_F", "O_soldier_M_F", "O_medic_F", "O_Soldier_GL_F", "O_Soldier_SL_F"]
	] call fnc_aiz_RandomElement;

for "_i" from 6 to _unitCount do
{
	_result pushBack ([	"O_soldier_M_F",
						"O_Soldier_AR_F",
						"O_Soldier_GL_F",
						"O_Soldier_LAT_F",
						"O_medic_F",
						"O_soldier_exp_F",
						"O_Soldier_A_F",
						"O_Soldier_AT_F",
						"O_engineer_F",
						"O_soldier_repair_F",
						"O_soldier_UAV_F"] call fnc_aiz_RandomElement);
};

_result;

/*
O_officer_F
O_Soldier_SL_F
O_Soldier_TL_F


O_soldier_M_F	// Marksman
O_Soldier_AR_F // MG
O_Soldier_GL_F // Gren
O_Soldier_LAT_F
O_medic_F
O_soldier_exp_F
O_Soldier_A_F // AmooBearere
O_Soldier_AT_F
O_Soldier_AA_F
O_engineer_F
O_soldier_repair_F
O_crew_F
O_soldier_UAV_F
o_soldier_unarmed_f

// Specop
O_spotter_F
O_sniper_F
O_recon_F
O_recon_M_F
O_recon_LAT_F
O_recon_medic_F
O_recon_exp_F
O_recon_JTAC_F
O_recon_TL_F
O_Soldier_AAR_F
O_Soldier_AAT_F
O_Soldier_AAA_F
O_support_MG_F

// Urban
O_soldierU_F
O_soldierU_AR_F
O_soldierU_AAR_F
O_soldierU_LAT_F
O_soldierU_AT_F
O_soldierU_AAT_F
O_soldierU_AA_F
O_soldierU_AAA_F
O_soldierU_TL_F
O_SoldierU_SL_F
O_soldierU_medic_F
O_soldierU_repair_F
O_soldierU_exp_F
O_engineer_U_F
O_soldierU_M_F
O_soldierU_A_F
O_SoldierU_GL_F
*/