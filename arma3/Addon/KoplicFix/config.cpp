class CfgPatches
{
	class koplicFix
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"Koplic"};
	};
};
class CfgWorlds
{
class DefaultLighting;
class DefaultWorld;
class CAWorld;
class Koplic: CAWorld
	{
		delete Weather;
		delete Lighting;
	};
};