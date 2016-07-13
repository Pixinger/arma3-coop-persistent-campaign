/*
I_C_Soldier_Para_1_F	Gewehr
I_C_Soldier_Para_2_F	Gewehr
I_C_Soldier_Para_3_F	Sani
I_C_Soldier_Para_4_F	MG
I_C_Soldier_Para_5_F	AT
I_C_Soldier_Para_6_F	Greni
I_C_Soldier_Para_7_F	Gewehr
I_C_Soldier_Para_8_F	Spreng/Mine

I_C_Soldier_Bandit_1_F	Sani
I_C_Soldier_Bandit_2_F	AT
I_C_Soldier_Bandit_3_F	MG
I_C_Soldier_Bandit_4_F	Gewehr
I_C_Soldier_Bandit_5_F	Gewehr
I_C_Soldier_Bandit_6_F	Greni
I_C_Soldier_Bandit_7_F	Gewehr
I_C_Soldier_Bandit_8_F	Spreng/Mine
*/

#define	OFFICER			"I_C_Soldier_Camo_F"

#define	BANDIT_GEWEHR1	"I_C_Soldier_Bandit_4_F"
#define	BANDIT_GEWEHR2	"I_C_Soldier_Bandit_5_F"
#define	BANDIT_GEWEHR3	"I_C_Soldier_Bandit_7_F"
#define	BANDIT_SANI		"I_C_Soldier_Bandit_1_F"
#define	BANDIT_GRENI	"I_C_Soldier_Bandit_6_F"
#define	BANDIT_MG		"I_C_Soldier_Bandit_3_F"
#define	BANDIT_AT		"I_C_Soldier_Bandit_2_F"
#define	BANDIT_EXP		"I_C_Soldier_Bandit_8_F"

#define	PARA_GEWEHR1	"I_C_Soldier_Para_1_F"
#define	PARA_GEWEHR2	"I_C_Soldier_Para_2_F"
#define	PARA_GEWEHR3	"I_C_Soldier_Para_7_F"
#define	PARA_SANI		"I_C_Soldier_Para_3_F"
#define	PARA_GRENI		"I_C_Soldier_Para_6_F"
#define	PARA_MG			"I_C_Soldier_Para_4_F"
#define	PARA_AT			"I_C_Soldier_Para_5_F"
#define	PARA_EXP		"I_C_Soldier_Para_8_F"


private _unitCount = if (count _this > 0) then { (_this select 0) } else { ([cfgAizGroupSizeMin, cfgAizGroupSizeMax] call BIS_fnc_randomInt) };

if (_unitCount == 1) exitWith
{
	[
		[BANDIT_GEWEHR1], 
		[BANDIT_GEWEHR2], 
		[BANDIT_GEWEHR3],
		[PARA_GEWEHR1], 
		[PARA_GEWEHR2], 
		[PARA_GEWEHR3]
	] call PIX_fnc_RandomElement;
};

if (_unitCount == 2) exitWith
{
	[
		[BANDIT_GEWEHR1, BANDIT_GRENI], 
		[BANDIT_GEWEHR1, BANDIT_SANI], 
		[BANDIT_GEWEHR2, BANDIT_MG], 
		[BANDIT_GEWEHR3, BANDIT_AT],
		[PARA_GEWEHR1, PARA_GRENI], 
		[PARA_GEWEHR1, PARA_SANI], 
		[PARA_GEWEHR2, PARA_MG], 
		[PARA_GEWEHR3, PARA_AT]
	] call PIX_fnc_RandomElement;
};

if (_unitCount == 3) exitWith
{
	[
		[BANDIT_GEWEHR1, BANDIT_MG, BANDIT_SANI], 
		[BANDIT_GEWEHR2, BANDIT_AT, BANDIT_SANI], 
		[BANDIT_GEWEHR3, BANDIT_GRENI, BANDIT_SANI], 
		[PARA_GEWEHR1, PARA_MG, PARA_SANI], 
		[PARA_GEWEHR2, PARA_AT, PARA_SANI], 
		[PARA_GEWEHR3, PARA_GRENI, PARA_SANI]
	] call PIX_fnc_RandomElement;
};

if (_unitCount == 4) exitWith
{
	[
		[BANDIT_GEWEHR1, BANDIT_MG, BANDIT_SANI, BANDIT_GRENI], 
		[BANDIT_GEWEHR2, BANDIT_AT, BANDIT_SANI, BANDIT_GRENI], 
		[BANDIT_GEWEHR3, BANDIT_MG, BANDIT_SANI, BANDIT_GRENI], 
		[PARA_GEWEHR1, PARA_MG, PARA_SANI, PARA_GRENI], 
		[PARA_GEWEHR2, PARA_AT, PARA_SANI, PARA_GRENI], 
		[PARA_GEWEHR3, PARA_MG, PARA_SANI, PARA_GRENI]
	] call PIX_fnc_RandomElement;
};

private _result = [
		[BANDIT_GEWEHR1, BANDIT_MG, BANDIT_SANI, BANDIT_GRENI], 
		[BANDIT_GEWEHR2, BANDIT_AT, BANDIT_SANI, BANDIT_GRENI], 
		[BANDIT_GEWEHR3, BANDIT_MG, BANDIT_SANI, BANDIT_GRENI], 
		[PARA_GEWEHR1, PARA_MG, PARA_SANI, PARA_GRENI], 
		[PARA_GEWEHR2, PARA_AT, PARA_SANI, PARA_GRENI], 
		[PARA_GEWEHR3, PARA_MG, PARA_SANI, PARA_GRENI]
	] call PIX_fnc_RandomElement;

for "_i" from 6 to _unitCount do
{
	_result pushBack ([	BANDIT_GEWEHR1,
						BANDIT_GEWEHR2,
						BANDIT_GEWEHR3,
						BANDIT_MG,
						BANDIT_AT,
						BANDIT_EXP,
						BANDIT_SANI,
						PARA_GEWEHR1,
						PARA_GEWEHR2,
						PARA_GEWEHR3,
						PARA_MG,
						PARA_AT,
						PARA_EXP,
						PARA_SANI] call PIX_fnc_RandomElement);
};

_result;

