
if (isServer && !isDedicated) then
{
	X39_MedSys_var_Action_CheckUnit_OutputRealValues = true;
};

// Ohrstöpsel
X39_MedSys_var_Settings_playEarRingingSound = true;
X39_MedSys_var_Hearing_CureValue = -0.01;					//-1e-005	//Use this to manipulate how fast youre deafness will disappear
X39_MedSys_var_Hearing_Multiplicator = 1; 					//1			//Use this to manipulate how fast you can get deaf !ONLY APPLIED ON X39_MedSys_fnc_addUnitHearing!
X39_MedSys_var_Hearing_earPlugManipulationValue = 0.8;	 		//0.8 		//Controls how much the earplugs affecting the hearing ability of a unit (1=keine Verringerung, 0=vollständige Verringerung)
X39_MedSys_var_Hearing_enable = true;						//true		//Allow the mod to "simulate" the human ear in ArmA (when someone shoots directly close to your ear it will be damaged over time)

// Damage
X39_MedSys_var_maxDamage = 20;											//10: stop whining ... what you think happens if youre hit by a grenade? damage goes up to ~20 + well placed bullets are also generating the same here ... well now the max is 10
X39_MedSys_var_DamageMultiplicator = 1.5;								//1.5: manipulates overall received damage (only damage received via HandleDamage!)
X39_MedSys_var_Generic_DamageBeforeDead = 8;								//8: Damage limit until a perma knockOut will happen (you still can be revived epi)
X39_MedSys_var_Generic_DamageBeforeKnockOut = 4;							//4: Damage limit until a temporary knockOut will happen
X39_MedSys_var_Generic_DamageBeforePermaKnockOut = 5;						//5: Damage limit until a perma knockOut will happen (you still can be revived epi)
X39_MedSys_var_Healing_BandageHealValue= 0.1;								//0.1: TrueDamage healed by bandage
X39_MedSys_var_Healing_BloodPackValue= 0.2;								//0.2: TrueDamage healed by BloodPack
X39_MedSys_var_Healing_MedKitValue= 5;									//5: TrueDamage healed by MedKit
X39_MedSys_var_Legs_DamageBeforeProneOnly = 0.5;							//0.5: The damage the legs need to take until the units are only able to move prone
X39_MedSys_var_Legs_DamageMultiplicator = 0.4;							//0.2: Multiplicator for leg damage (calculated like so "damageReceived * Multiplicator")


// Bluten
X39_MedSys_var_BandageBleedingHeal = 7;									//7: Healead bleeding for each bandage
X39_MedSys_var_Bleeding_Allow = true;									//(dis)allow bleeding =
X39_MedSys_var_Bleeding_BloodLossPerTickModificator = 0.3;					//1: Multiplicator for bloodloss (calculated like so ;damageReceived * Multiplicator;)
X39_MedSys_var_Bleeding_KnockOutBloodLimit = 1200; 						//1200: Blood limit before the unit will get knocked out
X39_MedSys_var_Bleeding_StartBloodAtMinDamageValueX = 0.25;				//0.25: Defines the minimum of damage that needs to be received to start bleeding (meaning if you get hit by 0.1 dmg and the limit is 0.2 you wont start bleeding) 
X39_MedSys_var_Bleeding_StartingBlood = 6000;								//6000: Blood value you start with (also defines the MAX)
X39_MedSys_var_Bleeding_Tourniquet_DamagePerTick = 0.001;					//0.001: DamagePerTick added to player when tourniquet is on him
X39_MedSys_var_Bleeding_maxBleeding = 10;								//10: Bleeding per tick?
X39_MedSys_var_BloodPackValue = 3000;									//1500: Blood added when bloodPack is used

// action timeouts
X39_MedSys_var_actionTimeout_BandageUnit = 3;
X39_MedSys_var_actionTimeout_BloodUnit = 5;
X39_MedSys_var_actionTimeout_CheckUnitStatus = 1;
X39_MedSys_var_actionTimeout_DephibrilateUnit = 7;
X39_MedSys_var_actionTimeout_EpinephrineUnit = 1;
X39_MedSys_var_actionTimeout_MorphineUnit = 1;
X39_MedSys_var_actionTimeout_PutTourniquet = 4;
X39_MedSys_var_actionTimeout_Stabilize = 20;
X39_MedSys_var_actionTimeout_UseMedkitOnUnit = 5;

// Sonstiges
X39_MedSys_var_TickRate = 0.25; 										//0.25: to change tickRate (min. time between ticks)

X39_MedSys_var_LifeTime = 600;											//600: should be self explaining ^^ but to say it: when youre dead you will be revivable for the time set in here
X39_MedSys_var_Display_TimeBeforeRespawnAvailable_Death = 30;				//300: Time before respawn is available after death (-1 to disable)	
X39_MedSys_var_Display_TimeBeforeRespawnAvailable_NormalKnockout = 60;		//60: Time before respawn is available after perma knockOut (-1 to disable)

X39_MedSys_var_enableCarry = true;										//Enables/Disables the carry option of the actionUi
X39_MedSys_var_enableDrag = true;										//Enables/Disables the drag option of the actionUi

X39_MedSys_var_KnockOut_showAbortButton = true;							//true: Enable/Disable the abort button (if false it is hidden!) [ http://feedback.vbundeswehr.de/view.php?id=34 ]
X39_MedSys_var_KnockOut_showRespawnButton = false;						//true: Enable/Disable the respawn button (if false it is hidden!) [ http://feedback.vbundeswehr.de/view.php?id=15 ]


