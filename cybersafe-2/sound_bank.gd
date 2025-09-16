extends Control

var menu_button = preload("res://Assets/Music and SFX/Buttons/menu_button.wav")
var back_button = preload("res://Assets/Music and SFX/Buttons/back_button.wav")
var other_button = preload("res://Assets/Music and SFX/Buttons/other_button.wav")

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
func play_sound(sound_name: String):
	match sound_name:
		"menu":
			audio_player.stream = menu_button
		"back":
			audio_player.stream = back_button
		"other":
			audio_player.stream = other_button
	audio_player.play()
