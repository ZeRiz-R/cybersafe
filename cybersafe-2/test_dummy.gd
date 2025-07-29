extends Node2D
@onready var calendar_manager = CalendarManager.new()

func _ready():
	calendar_manager.load_test_event()
	calendar_manager.print_event()
