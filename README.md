# myTherapist

## Project Overview

This Xojo project contains the following components:

## Project Components

- **Classes:** 2 (App, EmpatheticChatbot)

## Classes

### App

#### Properties

None

#### Methods

None

#### Events

- **`Run`**
  - **Signature:** `Event Run(args() as String) As Integer`
  - **Parameters:** `args() as String`
  - **Returns:** `Integer`

---

### EmpatheticChatbot

#### Properties

- **`mConversationHistory`** Private String()

- **`mRecentExchanges`** Private String()

- **`mEmotionalPatterns`** Private Dictionary

- **`mKeyTopics`** Private Dictionary

- **`mSpecificSituations`** Private Dictionary

- **`mRecentResponses`** Private Dictionary

- **`mUserSharedDetails`** Private Dictionary

- **`mSessionStartTime`** Private DateTime

- **`mTurnCount`** Private Integer

- **`mLastEmotion`** Private String

- **`mEmotionalIntensity`** Private Integer

- **`mConversationPhase`** Private String

- **`mLastResponseType`** Private String

- **`mLastResponse`** Private String

- **`mCurrentSituation`** Private String

- **`mLastUserInput`** Private String

- **`mUserName`** Private String

#### Methods

- **`AddToHistory`** Private Sub
  - **Parameters:** `entry As String`
  - **Signature:** `Private Sub AddToHistory(entry As String)`

- **`ClearHistory`** Public Sub
  - **Signature:** `Public Sub ClearHistory()`

- **`Constructor`** Public Constructor
  - **Signature:** `Public Constructor()`

- **`GenerateResponse`** Public Function
  - **Parameters:** `userInput As String`
  - **Returns:** `String`
  - **Signature:** `Public Function GenerateResponse(userInput As String) As String`

- **`CreateSmartResponse`** Private Function
  - **Parameters:** `userInput As String, emotion As String, specificSituation As String`
  - **Returns:** `String`
  - **Signature:** `Private Function CreateSmartResponse(userInput As String, emotion As String, specificSituation As String) As String`

- **`GetContextualValidation`** Private Function
  - **Parameters:** `emotion As String, situation As String`
  - **Returns:** `String`
  - **Signature:** `Private Function GetContextualValidation(emotion As String, situation As String) As String`

- **`GetOpeningQuestion`** Private Function
  - **Parameters:** `situation As String`
  - **Returns:** `String`
  - **Signature:** `Private Function GetOpeningQuestion(situation As String) As String`

- **`GetExplorationResponse`** Private Function
  - **Parameters:** `userInput As String, emotion As String, situation As String`
  - **Returns:** `String`
  - **Signature:** `Private Function GetExplorationResponse(userInput As String, emotion As String, situation As String) As String`

- **`GetDeepeningResponse`** Private Function
  - **Parameters:** `userInput As String, emotion As String, situation As String`
  - **Returns:** `String`
  - **Signature:** `Private Function GetDeepeningResponse(userInput As String, emotion As String, situation As String) As String`

- **`GetSupportingResponse`** Private Function
  - **Parameters:** `userInput As String, emotion As String, situation As String`
  - **Returns:** `String`
  - **Signature:** `Private Function GetSupportingResponse(userInput As String, emotion As String, situation As String) As String`

- **`EnsureUniqueResponse`** Private Function
  - **Parameters:** `proposedResponse As String, userInput As String`
  - **Returns:** `String`
  - **Signature:** `Private Function EnsureUniqueResponse(proposedResponse As String, userInput As String) As String`

- **`TrackResponse`** Private Sub
  - **Parameters:** `response As String`
  - **Signature:** `Private Sub TrackResponse(response As String)`

- **`AnalyzeSpecificSituation`** Private Function
  - **Parameters:** `userInput As String`
  - **Returns:** `String`
  - **Signature:** `Private Function AnalyzeSpecificSituation(userInput As String) As String`

- **`DetectEmotion`** Private Function
  - **Parameters:** `input As String`
  - **Returns:** `String`
  - **Signature:** `Private Function DetectEmotion(input As String) As String`

- **`TrackEmotionalPattern`** Private Sub
  - **Parameters:** `emotion As String`
  - **Signature:** `Private Sub TrackEmotionalPattern(emotion As String)`

- **`DetermineConversationPhase`** Private Function
  - **Returns:** `String`
  - **Signature:** `Private Function DetermineConversationPhase() As String`

- **`ValidateUserBoundary`** Public Function
  - **Parameters:** `input As String`
  - **Returns:** `String`
  - **Signature:** `Public Function ValidateUserBoundary(input As String) As String`

- **`GetConversationHistory`** Public Function
  - **Returns:** `String()`
  - **Signature:** `Public Function GetConversationHistory() As String()`

- **`GetEmotionalProfile`** Public Function
  - **Returns:** `String`
  - **Signature:** `Public Function GetEmotionalProfile() As String`

- **`GetSessionSummary`** Public Function
  - **Returns:** `String`
  - **Signature:** `Public Function GetSessionSummary() As String`

- **`GetUserName`** Public Function
  - **Returns:** `String`
  - **Signature:** `Public Function GetUserName() As String`

- **`ResizeTerminal`** Public Sub
  - **Parameters:** `cols As Integer, rows As Integer`
  - **Signature:** `Public Sub ResizeTerminal(cols As Integer, rows As Integer)`

- **`SetScreenColours`** Public Sub
  - **Signature:** `Public Sub SetScreenColours()`

- **`SetUserName`** Public Sub
  - **Parameters:** `name As String`
  - **Signature:** `Public Sub SetUserName(name As String)`

#### Events

None

---

## Requirements

- **Xojo:** Latest compatible version

## Installation

1. Clone or download this repository
2. Open the `.xojo_project` file in Xojo
3. Build and run the project

## Usage

[Add specific usage instructions for your application]

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

[Specify your license here]

---
*This README was automatically generated from the Xojo project file on 29/8/2025*
*© Philip Cumpston 28th August 2025 *
