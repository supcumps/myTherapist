#tag Class
Protected Class EmpatheticChatbot
	#tag Method, Flags = &h21
		Private Sub AddToHistory(entry As String)
		  // Add to history with timestamp
		  mConversationHistory.Append(DateTime.Now.ToString + ": " + entry)
		  
		  // Keep track of recent exchanges for context
		  mRecentExchanges.Append(entry)
		  If mRecentExchanges.Ubound > 10 Then
		    mRecentExchanges.Remove(0)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearHistory()
		  Redim mConversationHistory(-1)
		  mEmotionalPatterns.RemoveAll
		  mKeyTopics.RemoveAll
		  mSpecificSituations.RemoveAll
		  Redim mRecentExchanges(-1)
		  mRecentResponses.RemoveAll
		  mSessionStartTime = DateTime.Now
		  mTurnCount = 0
		  mLastEmotion = ""
		  mEmotionalIntensity = 0
		  mConversationPhase = "opening"
		  mUserSharedDetails.RemoveAll
		  mLastResponseType = ""
		  mCurrentSituation = ""
		  mLastUserInput = ""
		  AddToHistory("New session started at " + mSessionStartTime.ToString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  mSessionStartTime = DateTime.Now
		  Redim mConversationHistory(-1)
		  mEmotionalPatterns = New Dictionary
		  mKeyTopics = New Dictionary
		  mSpecificSituations = New Dictionary
		  mRecentResponses = New Dictionary
		  Redim mRecentExchanges(-1)
		  mUserSharedDetails = New Dictionary
		  mTurnCount = 0
		  mLastEmotion = ""
		  mEmotionalIntensity = 0
		  mConversationPhase = "opening"
		  mLastResponseType = ""
		  mCurrentSituation = ""
		  mLastUserInput = ""
		  
		  AddToHistory("Session started at " + mSessionStartTime.ToString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateResponse(userInput As String) As String
		  AddToHistory("User: " + userInput)
		  mTurnCount = mTurnCount + 1
		  
		  // Check for boundaries first
		  Var boundaryResponse As String = ValidateUserBoundary(userInput)
		  If boundaryResponse <> "" Then
		    AddToHistory("Bot: " + boundaryResponse)
		    Return boundaryResponse
		  End If
		  
		  // Store last user input for context
		  mLastUserInput = userInput.Lowercase
		  
		  // Update conversation phase
		  mConversationPhase = DetermineConversationPhase()
		  
		  // Detect emotion and situation
		  Var currentEmotion As String = DetectEmotion(userInput)
		  Var specificSituation As String = AnalyzeSpecificSituation(userInput)
		  
		  // Track emotional patterns
		  TrackEmotionalPattern(currentEmotion)
		  
		  // Generate contextual response - this is the main logic
		  Var response As String = CreateSmartResponse(userInput, currentEmotion, specificSituation)
		  
		  // Ensure we don't repeat responses
		  response = EnsureUniqueResponse(response, userInput)
		  
		  // Track this response to prevent future repetition
		  TrackResponse(response)
		  
		  mLastResponse = response
		  AddToHistory("Bot: " + response)
		  
		  Return response
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateSmartResponse(userInput As String, emotion As String, specificSituation As String) As String
		  Var lowerInput As String = userInput.Lowercase
		  Var response As String = ""
		  
		  // Handle very specific situations first
		  If InStr(lowerInput, "medical test") > 0 Or InStr(lowerInput, "blood test") > 0 Then
		    mCurrentSituation = "waiting_for_medical_results"
		    Return "Medical tests can create such anxiety while we wait. The uncertainty is really hard to sit with. What kind of tests are you waiting for results on?"
		  End If
		  
		  If InStr(lowerInput, "doctor") > 0 And (InStr(lowerInput, "didn't call") > 0 Or InStr(lowerInput, "haven't seen") > 0) Then
		    Return "That silence from your doctor must feel really unsettling. When did you have the tests done? Sometimes the waiting feels endless when it's about our health."
		  End If
		  
		  If InStr(lowerInput, "can't sleep") > 0 Then
		    If mCurrentSituation = "waiting_for_medical_results" Then
		      Return "The worry about your test results is keeping you awake - your mind won't quiet down, will it? What thoughts are cycling through when you're lying there?"
		    Else
		      Return "Sleep troubles often signal that our minds are wrestling with something. What's keeping your thoughts spinning at night?"
		    End If
		  End If
		  
		  If InStr(lowerInput, "haven't seen them") > 0 And mCurrentSituation = "waiting_for_medical_results" Then
		    Return "Not seeing your results yet... that waiting period can feel like torture. How long has it been since the tests? Are you imagining different scenarios about what they might show?"
		  End If
		  
		  // Handle brief responses that need follow-up
		  If userInput.Length < 30 Then
		    If lowerInput = "yes" Or lowerInput = "yeah" Or lowerInput = "exactly" Then
		      Return "Tell me more about that. What's the hardest part of this situation for you?"
		    ElseIf InStr(lowerInput, "worried") > 0 Or InStr(lowerInput, "scared") > 0 Then
		      Return "That worry is really weighing on you. What specifically are you most concerned about?"
		    ElseIf InStr(lowerInput, "don't know") > 0 Then
		      Return "Not knowing can be the most difficult part. What would help you feel even slightly more settled while you wait?"
		    End If
		  End If
		  
		  // Phase-based responses with context
		  Select Case mConversationPhase
		  Case "opening"
		    If emotion = "worried" Or emotion = "scared" Then
		      response = "I can hear the " + emotion + " in what you're sharing. " + GetContextualValidation(emotion, specificSituation)
		    Else
		      response = "Thank you for sharing this with me. " + GetOpeningQuestion(specificSituation)
		    End If
		    
		  Case "exploration"
		    response = GetExplorationResponse(userInput, emotion, specificSituation)
		    
		  Case "deepening"
		    response = GetDeepeningResponse(userInput, emotion, specificSituation)
		    
		  Case "supporting"
		    response = GetSupportingResponse(userInput, emotion, specificSituation)
		    
		  End Select
		  
		  Return response
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetContextualValidation(emotion As String, situation As String) As String
		  Select Case emotion
		  Case "worried", "scared"
		    If situation = "waiting_for_medical_results" Then
		      Return "Health concerns touch on our deepest fears about the unknown. That anxiety makes complete sense."
		    Else
		      Return "Worry has a way of taking over our thoughts. What you're feeling is completely understandable."
		    End If
		  Case "frustrated"
		    Return "That frustration tells me something important isn't happening the way it should. You have every right to feel that way."
		  Case "sad"
		    Return "There's real pain in what you're carrying. That sadness deserves space to be felt."
		  Else
		    Return "What you're experiencing sounds really challenging."
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetOpeningQuestion(situation As String) As String
		  Select Case situation
		  Case "waiting_for_medical_results"
		    Return "What's been going through your mind while you wait?"
		  Case "communication_issues"
		    Return "Help me understand what's happening with this communication breakdown."
		  Else
		    Return "What brought you here to talk today?"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetExplorationResponse(userInput As String, emotion As String, situation As String) As String
		  Var lowerInput As String = userInput.Lowercase
		  
		  // Build on what they just shared
		  If InStr(lowerInput, "results") > 0 Then
		    Return "The wait for results can feel endless. What's your mind telling you might be wrong? Are you preparing for the worst or trying to stay hopeful?"
		  ElseIf InStr(lowerInput, "doctor") > 0 Then
		    Return "When doctors don't communicate, we're left filling in those blanks ourselves. What story is your mind creating about their silence?"
		  Else
		    Select Case emotion
		    Case "worried"
		      Return "This worry seems to be taking up a lot of space in your mind. What would you need to know or hear to feel even a little more at peace?"
		    Case "frustrated"
		      Return "That frustration is building up. What would need to change for you to feel more in control of this situation?"
		    Else
		      Return "What aspect of this feels most overwhelming right now?"
		    End Select
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetDeepeningResponse(userInput As String, emotion As String, situation As String) As String
		  If situation = "waiting_for_medical_results" Then
		    Return "This waiting... it's like being suspended between your current life and whatever might come next. How are you coping with that uncertainty day by day?"
		  ElseIf emotion = "worried" And mEmotionalIntensity > 6 Then
		    Return "This level of worry can be exhausting. It sounds like your mind won't give you a break from these thoughts. What helps, even for a few minutes?"
		  Else
		    Return "There are layers to what you're experiencing. Which part feels most urgent to address right now?"
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetSupportingResponse(userInput As String, emotion As String, situation As String) As String
		  Var lowerInput As String = userInput.Lowercase
		  
		  If InStr(lowerInput, "what can i do") > 0 Then
		    If situation = "waiting_for_medical_results" Then
		      Return "It's completely reasonable to call the doctor's office and ask about when results typically come back. You have a right to information about your own health."
		    Else
		      Return "The fact that you're asking that question shows you haven't given up. What's one small step that feels manageable today?"
		    End If
		  Else
		    If situation = "waiting_for_medical_results" Then
		      Return "This health uncertainty is draining. While you wait, what helps you stay grounded? Sometimes we need survival strategies for these in-between times."
		    Else
		      Return "You're handling something really difficult. What support do you have around you during this?"
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function EnsureUniqueResponse(proposedResponse As String, userInput As String) As String
		  // Check if we've used this response recently
		  If mRecentResponses.HasKey(proposedResponse) Then
		    // Generate an alternative response
		    Var lowerInput As String = userInput.Lowercase
		    
		    If InStr(lowerInput, "can't sleep") > 0 Then
		      Return "The sleeplessness must be making everything feel harder to handle. What goes through your mind during those wakeful hours?"
		    ElseIf InStr(lowerInput, "medical") > 0 Or InStr(lowerInput, "test") > 0 Then
		      Return "Waiting for medical news puts us in such a vulnerable place. How are you taking care of yourself while you wait?"
		    ElseIf InStr(lowerInput, "doctor") > 0 Then
		      Return "That lack of communication from your healthcare provider would frustrate anyone. Have you been able to reach out to their office?"
		    Else
		      // Generic alternatives that acknowledge what they said
		      Var alternatives() As String = Array( _
		      "I hear you. Can you help me understand more about what this feels like?", _
		      "That sounds really difficult. What's the most challenging part of this for you?", _
		      "Thank you for sharing that with me. What would feel helpful right now?" _
		      )
		      Return alternatives(System.Random.InRange(0, alternatives.Ubound))
		    End If
		  End If
		  
		  Return proposedResponse
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TrackResponse(response As String)
		  // Store response with timestamp to avoid immediate repetition
		  mRecentResponses.Value(response) = Str(DateTime.Now.SecondsFrom1970)
		  
		  // Clean out old responses (older than 10 minutes)
		  Var keysToRemove() As String
		  For Each key As String In mRecentResponses.Keys
		    If (DateTime.Now.SecondsFrom1970 - Val(mRecentResponses.Value(key))) > 600 Then
		      keysToRemove.Append(key)
		    End If
		  Next
		  
		  For Each key As String In keysToRemove
		    mRecentResponses.Remove(key)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AnalyzeSpecificSituation(userInput As String) As String
		  Var lowerInput As String = userInput.Lowercase
		  
		  // Medical situations
		  If InStr(lowerInput, "medical test") > 0 Or InStr(lowerInput, "blood test") > 0 Or _
		     InStr(lowerInput, "test results") > 0 Then
		    Return "waiting_for_medical_results"
		  End If
		  
		  If InStr(lowerInput, "doctor") > 0 And (InStr(lowerInput, "didn't call") > 0 Or _
		     InStr(lowerInput, "haven't heard") > 0) Then
		    Return "doctor_communication_delay"
		  End If
		  
		  // Communication issues
		  If InStr(lowerInput, "doesn't listen") > 0 Or InStr(lowerInput, "won't listen") > 0 Then
		    Return "communication_issues"
		  End If
		  
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetectEmotion(input As String) As String
		  Var lowerInput As String = input.Lowercase
		  mEmotionalIntensity = 5 // Default
		  
		  If InStr(lowerInput, "concerned") > 0 Or InStr(lowerInput, "worried") > 0 Then
		    mEmotionalIntensity = 6
		    Return "worried"
		  ElseIf InStr(lowerInput, "can't sleep") > 0 Then
		    mEmotionalIntensity = 7
		    Return "anxious"
		  ElseIf InStr(lowerInput, "scared") > 0 Or InStr(lowerInput, "afraid") > 0 Then
		    mEmotionalIntensity = 7
		    Return "scared"
		  ElseIf InStr(lowerInput, "frustrated") > 0 Then
		    mEmotionalIntensity = 6
		    Return "frustrated"
		  ElseIf InStr(lowerInput, "haven't seen") > 0 And InStr(lowerInput, "results") > 0 Then
		    mEmotionalIntensity = 6
		    Return "worried"
		  End If
		  
		  Return "uncertain"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TrackEmotionalPattern(emotion As String)
		  If emotion = "" Then Return
		  
		  If Not mEmotionalPatterns.HasKey(emotion) Then
		    mEmotionalPatterns.Value(emotion) = "1"
		  Else
		    Var count As Integer = Val(mEmotionalPatterns.Value(emotion))
		    mEmotionalPatterns.Value(emotion) = Str(count + 1)
		  End If
		  
		  mLastEmotion = emotion
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetermineConversationPhase() As String
		  If mTurnCount <= 2 Then
		    Return "opening"
		  ElseIf mTurnCount <= 4 Then
		    Return "exploration"
		  ElseIf mTurnCount <= 8 Then
		    Return "deepening"
		  Else
		    Return "supporting"
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidateUserBoundary(input As String) As String
		  Var lowerInput As String = input.Lowercase
		  
		  If InStr(lowerInput, "stop talking") > 0 Or InStr(lowerInput, "stop asking") > 0 Then
		    Return "I understand. I'll give you space. I'm here if you need me."
		  ElseIf InStr(lowerInput, "don't want to talk") > 0 Then
		    Return "That's completely okay. You don't have to talk about anything you're not ready to share."
		  ElseIf lowerInput = "stop" Or lowerInput = "enough" Then
		    Return "Okay. I'm here when you're ready."
		  End If
		  
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConversationHistory() As String()
		  Return mConversationHistory
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEmotionalProfile() As String
		  If mEmotionalPatterns.KeyCount = 0 Then Return "No emotional patterns identified yet."
		  
		  Var profile As String = "Emotional patterns detected:" + EndOfLine
		  For Each emotion As String In mEmotionalPatterns.Keys
		    Var count As Integer = Val(mEmotionalPatterns.Value(emotion))
		    profile = profile + "- " + emotion + " (detected " + Str(count) + " times)" + EndOfLine
		  Next
		  
		  profile = profile + EndOfLine + "Current emotional intensity: " + Str(mEmotionalIntensity) + "/10" + EndOfLine
		  profile = profile + "Most recent emotion: " + mLastEmotion + EndOfLine
		  profile = profile + "Conversation phase: " + mConversationPhase + EndOfLine
		  profile = profile + "Current situation: " + mCurrentSituation + EndOfLine
		  
		  Return profile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSessionSummary() As String
		  Var summary As String = "Session Summary:" + EndOfLine
		  summary = summary + "Started: " + mSessionStartTime.ToString + EndOfLine
		  summary = summary + "Duration: " + Str((DateTime.Now.SecondsFrom1970 - mSessionStartTime.SecondsFrom1970) / 60) + " minutes" + EndOfLine
		  summary = summary + "Exchanges: " + Str(mTurnCount) + EndOfLine
		  summary = summary + "Peak emotional intensity: " + Str(mEmotionalIntensity) + "/10" + EndOfLine
		  summary = summary + "Current phase: " + mConversationPhase + EndOfLine
		  summary = summary + "Situation identified: " + mCurrentSituation + EndOfLine
		  
		  Return summary
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetUserName() As String
		  Return mUserName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTerminal(cols As Integer, rows As Integer)
		  stdout.Write(Chr(27) + "[8;" + Str(rows) + ";" + Str(cols) + "t")
		  stdout.Flush
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetScreenColours()
		  Var kLightBlue As String = Chr(27) + "[104m"
		  Var kCyan As String = Chr(27) + "[106m"
		  Var kClearScreen As String = Chr(27) + "[2J"
		  Var kHomeCursor As String = Chr(27) + "[H"
		  Var kWhiteText As String = Chr(27) + "[97m"
		  
		  stdout.Write(kLightBlue + kClearScreen + kHomeCursor + kWhiteText)
		  stdout.Flush
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetUserName(name As String)
		  mUserName = name
		End Sub
	#tag EndMethod

	#tag Property, Flags = &h21
	Private mConversationHistory() As String
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mRecentExchanges() As String
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mEmotionalPatterns As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mKeyTopics As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mSpecificSituations As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mRecentResponses As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mUserSharedDetails As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mSessionStartTime As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mTurnCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mLastEmotion As String
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mEmotionalIntensity As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mConversationPhase As String
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mLastResponseType As String
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mLastResponse As String
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mCurrentSituation As String
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mLastUserInput As String
	#tag EndProperty

	#tag Property, Flags = &h21
	Private mUserName As String
	#tag EndProperty

End Class
#tag EndClass