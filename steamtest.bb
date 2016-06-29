Function steamtest()

	steamstate=OpenSteam(19200)
	
	If steamstate=-1
	
		Print "Steam must be running to play this game."
		Print "OpenSteam() failed."

		Return
	
	EndIf
	
	If steamstate=1 
		Print "Steam is online"
	EndIf

	If steamstate=0
		Print "Steam is offline"
	EndIf
	
	Print "steamstate="+steamstate

	
	While Not KeyHit(1)
	
		a$=ReadSteam()
		
		Print "<steam>:"+a$
		
		If a="stats received!"
		
			games_played=GetSteamStat("games_played")
						
			games_played=games_played+1
			
			SetSteamStat( "games_played",games_played )
			
			StoreSteamStats()

			Print "Game counter incremented to "+games_played
		
		EndIf
		
		If a="stats stored!"
			
			games_played=GetSteamStat("games_played")
						
			games_played=games_played+1
			
			SetSteamStat( "games_played",games_played )
			
			StoreSteamStats()

			Print "Game counter incremented to "+games_played
			
		EndIf
	
		Delay (1000)
	
	Wend
	

End Function

Print "steam stub 1.0"

steamtest()

Print "finished, hit Return To finish"

WaitKey