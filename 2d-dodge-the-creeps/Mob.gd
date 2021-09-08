extends RigidBody2D

onready var MobSprite: AnimatedSprite = $AnimatedSprite


export var min_speed:=150.0
export var max_speed:=250.0

func _ready():
	randomize() # regenerates the random number seed based on time
	MobSprite.playing = true
	var mob_types = MobSprite.frames.get_animation_names() # array
	MobSprite.animation = mob_types[randi() % mob_types.size()]


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
