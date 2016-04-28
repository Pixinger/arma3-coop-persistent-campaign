
waituntil{time > 1};
player sidechat "time > 0";

waituntil {(DAC_Basic_Value > 0)};
player sidechat "DAC_Basic_Value > 0";

["z1",[1,0,0,0],[8,2,50,8],[ ],[ ],[ ],[0,0,0,0,0]] spawn DAC_Zone;

/*


[position,sizeX,sizeY,type,direction,parameter] call DAC_fNewZone

[(position player),250,150,0,0,parameter] call DAC_fNewZone

waituntil{DAC_NewZone == 0};
_values = ["z1",[1,0,0],[5,2,50,8],[],[],[],[1,1,1,1]];
[(position player),250,150,0,0,_values] call DAC_fNewZone


waituntil{DAC_NewZone == 0};
["zone1","zone2","zone3","zone4"] call DAC_fDeleteZone
*/