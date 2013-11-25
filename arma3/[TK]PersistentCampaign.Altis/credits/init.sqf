if (!isServer || !isDedicated) then
{
	waitUntil {!isNull player && player == player};	
	if(player diarySubjectExists "Credits") exitwith{};
	player createDiarySubject ["Credits","Credits"];
	player createDiaryRecord["Credits",["Credits","[TK]Persistent Campaign is a mission created by [TK]Pix.<br/>
					<br/>
					Even if - allmost - all scripts are written by myself, the roots from most of the ideas are located in the community.<br/>
					<br/>
					There are great scripts out there, like =BTC=Logistic or [R3F]Logistc and many others, that inspired my code. 
					To fully understand those scripts I started to reimplement them, adding my own ideas.<br/>
					<br/>
					As I have to admit, during all the days reading through the community, that I have lost control over what idea exactly belongs to which initial author.
					I will give you a short list of the ones I still remember and really hope that I do not forgot someone.<br/>
					<br/>
					If you feel yourself missing, please let me know.</br>
					<br/>
					<br/>
					[TK]ACE5th<br/>
					[TK]Judge<br/>
					[TK]OneTwo<br/>
					[TK]Tetet<br/>
					[TK]Pix<br/>
					Giallustio's =BTC=Logistic (Lift/Cargo)<br/>
					[R3F]Logistic<br/>
					Arma2Net<br/>
					Farooq's Revive<br/>
					Kronzky's Urban Patrol Script<br/>
					JW Custom's Ultra Simple Patrol Script<br/>
					Tonic's VAS<br/>
					I34dKarma's Roadblock-Script<br/>
					Sidemissions from ???<br/>
					"]
	];
};