#tag Class
Protected Class App
Inherits ConsoleApplication
	#tag Event
		Function Run(args() as String) As Integer
		  
		  ' Create the empathetic chatbot
		  Var therapyBot As New EmpatheticChatbot
		  
		  
		  // Adjust terminalk size and colour
		  therapyBot.resizeterminal(140,50)
		  therapyBot.setscreencolours()
		  
		  ' Welcome message
		  
		  Print("")
		  Print("🌟 Welcome to your personal support companion 🌟")
		  Print("")
		  Print("I'm here to listen with empathy and understanding.")
		  Print("You can share whatever is on your mind - there's no judgment here.")
		  Print("")
		  Print("Commands you can use:")
		  Print("  'exit' or 'quit' - End our conversation")
		  Print("  'clear' - Start fresh")
		  Print("  'summary' - See session overview")
		  Print("  'emotions' - View your emotional patterns")
		  Print("")
		  
		  ' Optional: Get user's name
		  Print("What would you like me to call you? (or just press Enter to skip)")
		  Print("")
		  Var userName As String = Input
		  If userName.Trim.Length > 0 Then
		    therapyBot.SetUserName(userName)
		    Print("")
		    Print("Nice to meet you, " + userName + ". I'm here to listen and support you.")
		  Else
		    Print("")
		    Print("That's perfectly fine. I'm here to listen and support you through whatever you're experiencing.")
		  End If
		  
		  Print("")
		  Print("What's on your mind today? Take your time - there's no rush.")
		  Print("")
		  
		  ' Main conversation loop
		  Do
		    Print("")
		    Var userInput As String = Input
		    
		    ' Check for exit commands
		    If userInput.Lowercase = "exit" Or userInput.Lowercase = "quit" Then
		      Print("")
		      Print("Thank you for sharing with me today.")
		      Print("Remember, you have the strength to handle whatever comes your way.")
		      Print("Take care of yourself. 💙")
		      Exit Do
		      
		    ElseIf userInput.Lowercase = "clear" Then
		      therapyBot.ClearHistory()
		      Print("")
		      Print("Starting fresh. What's on your mind?")
		      Print("")
		      Continue Do
		      
		    ElseIf userInput.Lowercase = "summary" Then
		      Print("")
		      Print(therapyBot.GetSessionSummary())
		      Print("")
		      Continue Do
		      
		    ElseIf userInput.Lowercase = "emotions" Then
		      Print("")
		      Print(therapyBot.GetEmotionalProfile())
		      Print("")
		      Continue Do
		      
		    ElseIf userInput.Trim.Length = 0 Then
		      Print("")
		      Print("I'm still here, listening. Take your time.")
		      Print("")
		      Continue Do
		    End If
		    
		    ' Check for boundary validation
		    Var boundaryResponse As String = therapyBot.ValidateUserBoundary(userInput)
		    If boundaryResponse.Length > 0 Then
		      Print("")
		      Print(boundaryResponse)
		      Print("")
		      Continue Do
		    End If
		    
		    ' Generate and display response
		    Var response As String = therapyBot.GenerateResponse(userInput)
		    Print("")
		    Print(response)
		    Print("")
		    
		    ' Add a small pause to make it feel more natural
		    ' You might want to add a small delay here if your environment supports it
		    ' System.YieldToNextThread() ' Uncomment if available in your Xojo version
		    
		  Loop
		  
		  
		End Function
	#tag EndEvent


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
