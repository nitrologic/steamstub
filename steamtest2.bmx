' steam demo has appid 480

?Win32
Import "steam_api.a"
?MacOS
Import "-L/Users/simon/sliksvn/dev/steamstub"
Import "-lsteam_api"
?

Import "steamstub.cpp"

Extern "C"

Function OpenSteam%(gameid%)
Function ReadSteam$z()
Function GetSteamStat%(id$z)
Function SetSteamStat(id$z,value%)
Function GetSteamAchievement%(id$z)
Function SetSteamAchievement(id$z)
Function StoreSteamStats()
Function FindNumberOfCurrentPlayers()
Function FindOrCreateLeaderboard( name$z, sortmethod%, displaytype% )
Function FindLeaderboard( name$z )
Function UploadLeaderboardScore( sendmethod%, score%, details$z )
Function DownloadLeaderboardEntries( request%, start%, finish% )

End Extern

' ELeaderboardDataRequest
' type of data request, when downloading leaderboard entries

Const k_ELeaderboardDataRequestGlobal = 0
Const k_ELeaderboardDataRequestGlobalAroundUser = 1
Const k_ELeaderboardDataRequestFriends = 2

' ELeaderboardSortMethod
' the sort order of a leaderboard

Const k_ELeaderboardSortMethodNone = 0
Const k_ELeaderboardSortMethodAscending = 1	' top-score is lowest number
Const k_ELeaderboardSortMethodDescending = 2	' top-score is highest number

' ELeaderboardDisplayType
' the display type (used by the Steam Community web site) For a leaderboard

Const k_ELeaderboardDisplayTypeNone = 0 
Const k_ELeaderboardDisplayTypeNumeric = 1			' simple numerical score
Const k_ELeaderboardDisplayTypeTimeSeconds = 2		' the score represents a time, in seconds
Const k_ELeaderboardDisplayTypeTimeMilliSeconds = 3	' the score represents a time, in milliseconds

' ELeaderboardUploadScoreMethod

Const k_ELeaderboardUploadScoreMethodNone = 0
Const k_ELeaderboardUploadScoreMethodKeepBest = 1
Const k_ELeaderboardUploadScoreMethodForceUpdate = 2

Global needscores=True

Function steamtest()

	Print "steamstate="+steamstate

	steamstate=OpenSteam(480) 

'	steamstate=OpenSteam(44100)
	
	If steamstate=-1
	
		Print "Steam must be running to play this game."
		Print "OpenSteam() failed."

		Return
	
	EndIf
	
	End
	
	If steamstate=1 
		Print "Steam is online, getting stats"

'		SetSteamStat "bogeys",0
'		GetSteamStat "bogeys"
		
'		FindNumberOfCurrentPlayers()

		FindOrCreateLeaderboard("Lead1",1,k_ELeaderboardDisplayTypeNumeric)
'		FindLeaderboard("Lead1")

'		FindOrCreateLeaderboard("Track01",k_ELeaderboardSortMethodAscending,k_ELeaderboardDisplayTypeTimeSeconds)
'		DownloadLeaderboardEntries(k_ELeaderboardDataRequestGlobal,0,1024 )

	EndIf

	If steamstate=0
		Print "Steam is offline"
	EndIf
	
	Print "steamstate="+steamstate
	
	While Not KeyHit(1)
	
		a$=ReadSteam()
		
		Print "<steam>:"+a$
				
		If a="stats received!"
		
			games_played2=GetSteamStat("games_played2")
						
			games_played2=games_played2+1
			
'			SetSteamStat( "games_played2",games_played2 )			
'			StoreSteamStats()

			Print "recv: Game counter incremented to "+games_played2
		
		EndIf
		
		If a="stats stored!"
			
			games_played2=GetSteamStat("games_played2")
						
			games_played2=games_played2+1
			
			SetSteamStat( "games_played2",games_played2 )
			
			StoreSteamStats()

			Print "store: Game counter incremented to "+games_played2
			
		EndIf
	
		Delay (1000)
	
	Wend
	

End Function

Print "steam stub 1.8"

steamtest()

Print "finished, hit Return To finish"

WaitKey

