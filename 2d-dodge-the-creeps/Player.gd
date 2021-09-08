extends Area2D

signal hit

onready var playerSprite: AnimatedSprite = $AnimatedSprite

export var speed: = 400
var screen_size = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	
	if direction.length() > 0:
		direction = direction.normalized()
		playerSprite.play()
	else:
		playerSprite.stop()
	
	position += direction * speed * delta
	# position is a default field
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if direction.x != 0:
		playerSprite.animation = "right"
		playerSprite.flip_h = direction.x < 0
		playerSprite.flip_v = direction.y > 0
	elif direction.y != 0:
		playerSprite.animation = "up"
		playerSprite.flip_v = direction.y > 0
		playerSprite.flip_h = direction.x < 0
	
	
func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false


func _on_body_entered(body: Node) -> void:
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	# this waits to end of physics frame to change property to be safe
	emit_signal("hit")
