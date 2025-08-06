extends Node

enum Meters {
	CYBER_KNOWLEDGE,
	DEVICE_HEALTH,
	DATA_SECURITY,
	SOCIAL_TRUST,
	STRESS
}

# TEST DECISION
var choice1 = Choice.new("Follow", {Constants.Meters.CYBER_KNOWLEDGE: +2,
										 Constants.Meters.DEVICE_HEALTH: +3,
										 Constants.Meters.DATA_SECURITY: +4,
										 Constants.Meters.SOCIAL_TRUST: +5,
										 Constants.Meters.STRESS: -5}, "Good stuff")
var choice2 = Choice.new("Report", {Constants.Meters.CYBER_KNOWLEDGE: +2,
										 Constants.Meters.DEVICE_HEALTH: +3,
										 Constants.Meters.DATA_SECURITY: +4,
										 Constants.Meters.SOCIAL_TRUST: +5,
										 Constants.Meters.STRESS: -5}, "Bad Stuff")
var choice3 = Choice.new("Ignore", {Constants.Meters.CYBER_KNOWLEDGE: +2,
										 Constants.Meters.DEVICE_HEALTH: +3,
										 Constants.Meters.DATA_SECURITY: +4,
										 Constants.Meters.SOCIAL_TRUST: +5,
										 Constants.Meters.STRESS: -5}, "Decent Stuff")
var email = Email.new("testsender@test.co.uk", "This is a test email", "This is a test email", [])
var dummyDecision = EmailDecision.new("DecisionTest", "This is a test... believe it!", [choice1, choice2, choice3],  email)
var dummyEvent = GameEvent.new("TestEvent", Vector2i(1, 1), dummyDecision)
