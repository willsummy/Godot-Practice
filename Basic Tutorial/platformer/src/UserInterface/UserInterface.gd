extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var score: Label = get_node("Label")
onready var pause_title: Label = get_node("PauseOverlay/PausedTitle")
onready var is_dead:= false

var paused: = false setget set_paused



func _ready() -> void:
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	update_interface()
	

func _on_PlayerData_player_died() -> void:
	self.paused = true
	self.is_dead = true
	pause_title.text = "You Died"
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and !is_dead:
		self.paused = !paused
		# since the setter is not called when var is interanally changed
		# you can either directly call the setter or use the self prefix
		scene_tree.set_input_as_handled()



func update_interface() -> void:
	score.text = "Score: %s" % PlayerData.score



func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
	
	
	
