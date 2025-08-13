#tag Class
Protected Class EmpatheticChatbot
	#tag Method, Flags = &h21
		Private Sub AddToHistory(entry As String)
		  // Add to history
		  mConversationHistory.Add(DateTime.Now.ToString + ": " + entry)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearHistory()
		  mConversationHistory.RemoveAll
		  mEmotionalPatterns.RemoveAll
		  mMirroredPhrases.RemoveAll
		  mSessionStartTime = DateTime.Now
		  mQuestionCount = 0
		  mReflectionCount = 0
		  mLabelingCount = 0
		  mLastEmotion = ""
		  mEmotionalIntensity = 0
		  AddToHistory("New session started at " + mSessionStartTime.ToString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  mSessionStartTime = DateTime.Now
		  var mConversationHistory() as String
		  mEmotionalPatterns = New Dictionary
		  mMirroredPhrases = New Dictionary
		  mQuestionCount = 0
		  mReflectionCount = 0
		  mLabelingCount = 0
		  mLastEmotion = ""
		  mEmotionalIntensity = 0
		  
		  AddToHistory("Session started at " + mSessionStartTime.ToString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateCalibrationQuestion(userInput As String) As String
		  ' Questions that help calibrate emotional state and create illusion of control
		  
		  Var lowerInput As String = userInput.Lowercase
		  
		  ' Calibrated questions based on emotional intensity
		  If mEmotionalIntensity > 7 Then
		    Var highIntensityQuestions() As String = Array( _
		    "On a scale of 1 to 10, how overwhelming does this feel right now?", _
		    "What would need to happen for you to feel even slightly better about this?", _
		    "Is this the worst part, or is there something else underneath this?", _
		    "What's the one thing that would make the biggest difference right now?" _
		    )
		    Return highIntensityQuestions(System.Random.InRange(0, highIntensityQuestions.Count - 1))
		  ElseIf mEmotionalIntensity > 4 Then
		    Var mediumIntensityQuestions() As String = Array( _
		    "How long have you been carrying this feeling?", _
		    "What would moving forward look like for you?", _
		    "Is this something you've dealt with before, or does it feel completely new?", _
		    "What part of this feels most within your control?" _
		    )
		    Return mediumIntensityQuestions(System.Random.InRange(0, mediumIntensityQuestions.Count - 1))
		  Else
		    Var lowIntensityQuestions() As String = Array( _
		    "What's your sense of what comes next?", _
		    "How are you thinking about approaching this?", _
		    "What options are you considering?", _
		    "What feels most important to focus on?" _
		    )
		    Return lowIntensityQuestions(System.Random.InRange(0, lowIntensityQuestions.Count - 1))
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateEmotionalLabel(emotion As String, intensity As Integer) As String
		  ' Label emotions using "It seems like..." or "It sounds like..." format
		  
		  Var labelStarters() As String = Array( _
		  "It seems like", "It sounds like", "It feels like", "It looks like", _
		  "You seem to be feeling", "There's a sense that" _
		  )
		  
		  Var starter As String = labelStarters(System.Random.InRange(0, labelStarters.Count - 1))
		  
		  ' Adjust language based on intensity
		  If intensity > 7 Then
		    Return starter + " you're really " + emotion + " about this."
		  ElseIf intensity > 4 Then
		    Return starter + " you're " + emotion + " about this situation."
		  Else
		    Return starter + " there's some " + emotion + " here for you."
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateIllusionOfControl(userInput As String) As String
		  ' Create sense of control through choice and agency
		  
		  Var controlPhrases() As String = Array( _
		  "What would you like to focus on - the immediate situation or the bigger picture?", _
		  "Would it help more to talk through what happened, or explore what you're feeling about it?", _
		  "Do you want to dig deeper into this, or would you prefer to step back and look at options?", _
		  "What feels more important right now - understanding why this happened or figuring out what to do next?", _
		  "Would you rather explore what this means to you, or talk about how you want to handle it?", _
		  "What would be most helpful - looking at this from different angles or focusing on one specific part?" _
		  )
		  
		  Return controlPhrases(System.Random.InRange(0, controlPhrases.Count - 1))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateMirror(userInput As String) As String
		  ' Mirror the last 1-3 words with upward inflection
		  
		  Var words() As String = userInput.Trim.Split(" ")
		  If words.Count = 0 Then Return ""
		  
		  Var mirrorLength As Integer = System.Random.InRange(1, 3)
		  If words.Count < mirrorLength Then mirrorLength = words.Count
		  
		  Var mirror As String = ""
		  For i As Integer = words.Count - mirrorLength To words.Count - 1
		    mirror = mirror + words(i) + " "
		  Next
		  
		  mirror = mirror.Trim + "?"
		  
		  ' Store mirrored phrase for tracking
		  If Not mMirroredPhrases.HasKey(mirror.Lowercase) Then
		    mMirroredPhrases.Value(mirror.Lowercase) = 1
		  Else
		    mMirroredPhrases.Value(mirror.Lowercase) = mMirroredPhrases.Value(mirror.Lowercase) + 1
		  End If
		  
		  Return mirror
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateTacticalEmpathy(userInput As String, emotion As String) As String
		  ' Acknowledge their perspective and validate their experience
		  
		  Var lowerInput As String = userInput.Lowercase
		  
		  ' Specific empathetic responses based on content
		  If InStr(lowerInput, "unfair") > 0 Or InStr(lowerInput, "not fair") > 0 Then
		    Return "That really doesn't seem fair to you, does it? Anyone in your position would feel that way."
		  ElseIf InStr(lowerInput, "nobody understands") > 0 Or InStr(lowerInput, "no one gets it") > 0 Then
		    Return "It must be incredibly isolating to feel like no one really gets what you're going through."
		  ElseIf InStr(lowerInput, "can't take it") > 0 Or InStr(lowerInput, "too much") > 0 Then
		    Return "This sounds absolutely overwhelming. You're dealing with way more than anyone should have to handle alone."
		  ElseIf InStr(lowerInput, "scared") > 0 Or InStr(lowerInput, "afraid") > 0 Then
		    Return "Fear is such a difficult emotion to sit with, especially when it feels this big."
		  ElseIf InStr(lowerInput, "angry") > 0 Or InStr(lowerInput, "mad") > 0 Then
		    Return "That anger makes complete sense. You have every right to feel this way about what happened."
		  ElseIf InStr(lowerInput, "disappointed") > 0 Then
		    Return "Disappointment can be one of the hardest emotions to process, especially when your hopes were high."
		  ElseIf InStr(lowerInput, "confused") > 0 Then
		    Return "Confusion is so uncomfortable, isn't it? Not knowing what to think or feel about something this important."
		  End If
		  
		  ' General tactical empathy responses
		  Var empathyResponses() As String = Array( _
		  "This is clearly weighing heavily on you, and that's completely understandable.", _
		  "Anyone going through what you're experiencing would be struggling with this.", _
		  "It sounds like you're being really hard on yourself about something that's genuinely difficult.", _
		  "What you're dealing with would challenge anyone. You're not alone in feeling this way.", _
		  "This situation would be tough for anyone to navigate. Your feelings make perfect sense." _
		  )
		  
		  Return empathyResponses(System.Random.InRange(0, empathyResponses.Count - 1))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetectEmotion(input As String) As String
		  ' Enhanced emotion detection
		  
		  Var lowerInput As String = input.Lowercase
		  
		  ' Direct emotion words
		  If InStr(lowerInput, "furious") > 0 Or InStr(lowerInput, "enraged") > 0 Then
		    mEmotionalIntensity = 9
		    Return "furious"
		  ElseIf InStr(lowerInput, "devastated") > 0 Or InStr(lowerInput, "destroyed") > 0 Then
		    mEmotionalIntensity = 9
		    Return "devastated"
		  ElseIf InStr(lowerInput, "terrified") > 0 Or InStr(lowerInput, "petrified") > 0 Then
		    mEmotionalIntensity = 9
		    Return "terrified"
		  ElseIf InStr(lowerInput, "angry") > 0 Or InStr(lowerInput, "mad") > 0 Or InStr(lowerInput, "pissed") > 0 Then
		    mEmotionalIntensity = 7
		    Return "angry"
		  ElseIf InStr(lowerInput, "sad") > 0 Or InStr(lowerInput, "depressed") > 0 Then
		    mEmotionalIntensity = 6
		    Return "sad"
		  ElseIf InStr(lowerInput, "scared") > 0 Or InStr(lowerInput, "afraid") > 0 Or InStr(lowerInput, "worried") > 0 Then
		    mEmotionalIntensity = 6
		    Return "scared"
		  ElseIf InStr(lowerInput, "frustrated") > 0 Or InStr(lowerInput, "annoyed") > 0 Then
		    mEmotionalIntensity = 5
		    Return "frustrated"
		  ElseIf InStr(lowerInput, "disappointed") > 0 Then
		    mEmotionalIntensity = 5
		    Return "disappointed"
		  ElseIf InStr(lowerInput, "confused") > 0 Or InStr(lowerInput, "lost") > 0 Then
		    mEmotionalIntensity = 4
		    Return "confused"
		  ElseIf InStr(lowerInput, "overwhelmed") > 0 Or InStr(lowerInput, "stressed") > 0 Then
		    mEmotionalIntensity = 7
		    Return "overwhelmed"
		  End If
		  
		  ' Contextual emotion detection
		  If InStr(lowerInput, "can't take") > 0 Or InStr(lowerInput, "too much") > 0 Then
		    mEmotionalIntensity = 8
		    Return "overwhelmed"
		  ElseIf InStr(lowerInput, "giving up") > 0 Or InStr(lowerInput, "hopeless") > 0 Then
		    mEmotionalIntensity = 8
		    Return "hopeless"
		  ElseIf InStr(lowerInput, "don't know what to do") > 0 Then
		    mEmotionalIntensity = 6
		    Return "lost"
		  End If
		  
		  mEmotionalIntensity = 3
		  Return "uncertainty"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetermineResponseType() As String
		  ' Determine which technique to use based on conversation flow
		  
		  Var totalResponses As Integer = mQuestionCount + mReflectionCount + mLabelingCount
		  
		  ' Start with labeling for new conversations
		  If totalResponses < 2 And mEmotionalIntensity > 3 Then
		    Return "label"
		  End If
		  
		  ' Use mirroring frequently but not consecutively
		  If mLastResponse.EndsWith("?") = False And System.Random.InRange(1, 100) <= 25 Then
		    Return "mirror"
		  End If
		  
		  ' Balance tactical empathy with other techniques
		  If mReflectionCount >= 2 And mQuestionCount = 0 Then
		    If System.Random.InRange(1, 100) <= 60 Then
		      Return "calibration"
		    Else
		      Return "control"
		    End If
		  End If
		  
		  ' Use tactical empathy for high emotion
		  If mEmotionalIntensity > 6 And mReflectionCount < 3 Then
		    Return "tactical_empathy"
		  End If
		  
		  ' Create illusion of control when they seem stuck
		  If mQuestionCount >= 3 And System.Random.InRange(1, 100) <= 40 Then
		    Return "control"
		  End If
		  
		  ' Use calibration questions to gather information
		  If mQuestionCount < mReflectionCount And System.Random.InRange(1, 100) <= 50 Then
		    Return "calibration"
		  End If
		  
		  ' Default to emotional labeling
		  If System.Random.InRange(1, 100) <= 60 Then
		    Return "label"
		  Else
		    Return "minimal"
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateResponse(userInput As String) As String
		  AddToHistory("User: " + userInput)
		  
		  ' Detect emotion and intensity
		  Var currentEmotion As String = DetectEmotion(userInput)
		  mLastEmotion = currentEmotion
		  
		  ' Track emotional patterns
		  If Not mEmotionalPatterns.HasKey(currentEmotion) Then
		    mEmotionalPatterns.Value(currentEmotion) = 1
		  Else
		    mEmotionalPatterns.Value(currentEmotion) = mEmotionalPatterns.Value(currentEmotion) + 1
		  End If
		  
		  Var response As String = ""
		  Var responseType As String = DetermineResponseType()
		  
		  Select Case responseType
		  Case "mirror"
		    response = CreateMirror(userInput)
		    
		  Case "label"
		    response = CreateEmotionalLabel(currentEmotion, mEmotionalIntensity)
		    mLabelingCount = mLabelingCount + 1
		    
		  Case "tactical_empathy"
		    response = CreateTacticalEmpathy(userInput, currentEmotion)
		    mReflectionCount = mReflectionCount + 1
		    
		  Case "calibration"
		    response = CreateCalibrationQuestion(userInput)
		    mQuestionCount = mQuestionCount + 1
		    
		  Case "control"
		    response = CreateIllusionOfControl(userInput)
		    mQuestionCount = mQuestionCount + 1
		    
		  Case "minimal"
		    ' Minimal encouragers to keep them talking
		    Var minimal() As String = Array("Mm-hmm.", "Go on.", "I'm listening.", "Tell me more.", "And then?", "That must have been hard.")
		    response = minimal(System.Random.InRange(0, minimal.Count - 1))
		    
		  End Select
		  
		  ' Add a pause or follow-up about 30% of the time
		  If System.Random.InRange(1, 100) <= 30 And response.Length > 5 Then
		    Var followUps() As String = Array( _
		    " What else?", _
		    " Help me understand.", _
		    " There's more, isn't there?", _
		    " What am I missing?", _
		    " Say more about that." _
		    )
		    response = response + followUps(System.Random.InRange(0, followUps.Count - 1))
		  End If
		  
		  mLastResponse = response
		  AddToHistory("Bot: " + response)
		  
		  Return response
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
		    Var count As Integer = mEmotionalPatterns.Value(emotion)
		    profile = profile + "- " + emotion + " (detected " + Str(count) + " times)" + EndOfLine
		  Next
		  
		  profile = profile + EndOfLine + "Current emotional intensity: " + Str(mEmotionalIntensity) + "/10" + EndOfLine
		  profile = profile + "Most recent emotion: " + mLastEmotion + EndOfLine
		  
		  Return profile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSessionSummary() As String
		  Var summary As String = "Session Summary:" + EndOfLine
		  summary = summary + "Started: " + mSessionStartTime.ToString + EndOfLine
		  summary = summary + "Duration: " + Str((DateTime.Now.SecondsFrom1970 - mSessionStartTime.SecondsFrom1970) / 60) + " minutes" + EndOfLine
		  summary = summary + "Exchanges: " + Str(mConversationHistory.Count) + EndOfLine
		  summary = summary + "Calibration questions: " + Str(mQuestionCount) + EndOfLine
		  summary = summary + "Empathetic reflections: " + Str(mReflectionCount) + EndOfLine
		  summary = summary + "Emotional labels: " + Str(mLabelingCount) + EndOfLine
		  summary = summary + "Peak emotional intensity: " + Str(mEmotionalIntensity) + "/10" + EndOfLine
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
		  
		  // Use ANSI escape sequence to resize terminal window
		  System.DebugLog Chr(27) + "[8;" + Str(rows) + ";" + Str(cols) + "t"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setScreenColours()
		  
		  
		  var  kLightBlue As String = Chr(27) + "[104m"  // Bright blue background
		  var kCyan As String = Chr(27) + "[106m"       // Cyan background (light blue-ish)
		  var kClearScreen As String = Chr(27) + "[2J"  // Clear screen
		  var kHomeCursor As String = Chr(27) + "[H"    // Move cursor to home (0,0)
		  var kWhiteText As String = Chr(27) + "[97m"   // Bright white text
		  
		  // Set up the entire screen with light blue background
		  System.DebugLog kLightBlue + kClearScreen + kHomeCursor + kWhiteText
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetUserName(name As String)
		  mUserName = name
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidateUserBoundary(input As String) As String
		  Var lowerInput As String = input.Lowercase
		  If InStr(lowerInput, "no") > 0 Or InStr(lowerInput, "don't want") > 0 Or InStr(lowerInput, "stop") > 0 Then
		    Return "I hear you saying no, and I completely respect that. You're in control here. What would feel right for you instead?"
		  End If
		  Return ""
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConversationHistory() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEmotionalIntensity As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEmotionalPatterns As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLabelingCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastEmotion As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastResponse As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMirroredPhrases As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQuestionCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReflectionCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSessionStartTime As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserName As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
