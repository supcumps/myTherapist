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

- **`mEmotionalIntensity`** Private Integer

- **`mEmotionalPatterns`** Private Dictionary

- **`mLabelingCount`** Private Integer

- **`mLastEmotion`** Private String

- **`mLastResponse`** Private String

- **`mMirroredPhrases`** Private Dictionary

- **`mQuestionCount`** Private Integer

- **`mReflectionCount`** Private Integer

- **`mSessionStartTime`** Private DateTime

- **`mUserName`** Private String

#### Methods

- **`AddToHistory`** Private Sub
  - **Parameters:** `entry As String`
  - **Signature:** `Private Sub AddToHistory(entry As String)`

- **`ClearHistory`** Public Sub
  - **Signature:** `Public Sub ClearHistory()`

- **`Constructor`** Public Constructor
  - **Signature:** `Public Constructor()`

- **`CreateCalibrationQuestion`** Private Function
  - **Parameters:** `userInput As String`
  - **Returns:** `String`
  - **Signature:** `Private Function CreateCalibrationQuestion(userInput As String) As String`

- **`CreateEmotionalLabel`** Private Function
  - **Parameters:** `emotion As String, intensity As Integer`
  - **Returns:** `String`
  - **Signature:** `Private Function CreateEmotionalLabel(emotion As String, intensity As Integer) As String`

- **`CreateIllusionOfControl`** Private Function
  - **Parameters:** `userInput As String`
  - **Returns:** `String`
  - **Signature:** `Private Function CreateIllusionOfControl(userInput As String) As String`

- **`CreateMirror`** Private Function
  - **Parameters:** `userInput As String`
  - **Returns:** `String`
  - **Signature:** `Private Function CreateMirror(userInput As String) As String`

- **`CreateTacticalEmpathy`** Private Function
  - **Parameters:** `userInput As String, emotion As String`
  - **Returns:** `String`
  - **Signature:** `Private Function CreateTacticalEmpathy(userInput As String, emotion As String) As String`

- **`DetectEmotion`** Private Function
  - **Parameters:** `input As String`
  - **Returns:** `String`
  - **Signature:** `Private Function DetectEmotion(input As String) As String`

- **`DetermineResponseType`** Private Function
  - **Returns:** `String`
  - **Signature:** `Private Function DetermineResponseType() As String`

- **`GenerateResponse`** Public Function
  - **Parameters:** `userInput As String`
  - **Returns:** `String`
  - **Signature:** `Public Function GenerateResponse(userInput As String) As String`

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

- **`setScreenColours`** Public Sub
  - **Signature:** `Public Sub setScreenColours()`

- **`SetUserName`** Public Sub
  - **Parameters:** `name As String`
  - **Signature:** `Public Sub SetUserName(name As String)`

- **`ValidateUserBoundary`** Public Function
  - **Parameters:** `input As String`
  - **Returns:** `String`
  - **Signature:** `Public Function ValidateUserBoundary(input As String) As String`

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
*This README was automatically generated from the Xojo project file on 14/8/2025*
