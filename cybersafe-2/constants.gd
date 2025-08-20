extends Node

enum Meters {
	CYBER_KNOWLEDGE,
	DEVICE_HEALTH,
	DATA_SECURITY,
	SOCIAL_TRUST,
	STRESS
}

# HASHMAP Mapping Names to Icons for messages

# TEST DECISION EMAIL
var choice1 = Choice.new("Follow" ,"Follow", {Constants.Meters.CYBER_KNOWLEDGE: +15,
										 Constants.Meters.DEVICE_HEALTH: +10,
										 Constants.Meters.DATA_SECURITY: -10,
										 Constants.Meters.SOCIAL_TRUST: -30,
										 Constants.Meters.STRESS: +10}, ["Good stuff", "It's not everyday you test an email!"])
var choice2 = Choice.new("Report", "Report", {Constants.Meters.CYBER_KNOWLEDGE: +2,
										 Constants.Meters.DEVICE_HEALTH: +3,
										 Constants.Meters.DATA_SECURITY: +4,
										 Constants.Meters.SOCIAL_TRUST: +5,
										 Constants.Meters.STRESS: -5}, ["Bad Stuff", "It's not everyday you report an email!"])
var choice3 = Choice.new("Ignore", "Ignore", {Constants.Meters.CYBER_KNOWLEDGE: +2,
										 Constants.Meters.DEVICE_HEALTH: +3,
										 Constants.Meters.DATA_SECURITY: +4,
										 Constants.Meters.SOCIAL_TRUST: +5,
										 Constants.Meters.STRESS: -5}, ["Decent Stuff", "We'll see how this turns out another time"])
var email = Email.new("testsender@test.co.uk", "This is a test email", "This is a test email", [])
var dummyDecision = EmailDecision.new("DecisionTest", "This is a test... believe it!", "Here is a top tip for an email", [choice1, choice2, choice3],  email)
var dummyEvent = GameEvent.new("TestEvent", Vector2i(3, 1), dummyDecision)

# TEST CHAT STUFF
var chat1 = ChatMessage.new("Winton Overwat", "Overwatch 2 in big 2025", false)
var chat2 = ChatMessage.new("FroggerTV", "Does this mean Overwatch is back?", true)
var chat3 = ChatMessage.new("Winton Overwat", "Yes, Yes we are!", false)

var choice1c = Choice.new("Play", "Play Overwatch. you could reach Grandmaster!", {Constants.Meters.CYBER_KNOWLEDGE: +15,
										 Constants.Meters.DEVICE_HEALTH: +10,
										 Constants.Meters.DATA_SECURITY: -10,
										 Constants.Meters.SOCIAL_TRUST: -30,
										 Constants.Meters.STRESS: +10}, ["Maybe not the best choice...", "Your enthusiasm quickly dries out as you re-enter that hellscape."])
var choice2c = Choice.new("Uninstall", "Uninstall Overwatch. It's not worth the pain.",  {Constants.Meters.CYBER_KNOWLEDGE: +2,
										 Constants.Meters.DEVICE_HEALTH: +3,
										 Constants.Meters.DATA_SECURITY: +4,
										 Constants.Meters.SOCIAL_TRUST: +5,
										 Constants.Meters.STRESS: -5}, ["Great choice!", "Your life is way more peaceful"])
var choice3c = Choice.new("Paladins", "Play Paladins. It was bettter anyway...", {Constants.Meters.CYBER_KNOWLEDGE: +2,
										 Constants.Meters.DEVICE_HEALTH: +3,
										 Constants.Meters.DATA_SECURITY: +4,
										 Constants.Meters.SOCIAL_TRUST: +5,
										 Constants.Meters.STRESS: -5}, ["Uhhhhh...", "Seems like you haven't heard the news.", "Paladins is dead."])
var dummyChatDecision = ChatDecision.new("PlayOverwatch", "TestPrompt", "Learn the fastest rollouts to get to the objective!", [choice1c, choice2c, choice3c], "Winton Overwat", [chat1, chat2, chat3])
var dummyChatEvent = GameEvent.new("PlayOverwatch", Vector2(1, 1), dummyChatDecision)
