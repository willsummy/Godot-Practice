extends Node

export (PackedScene) var mob_scene
var score = 0




func _ready():
	randomize()
	
func new_game():
	score = 0
	$HUD.update_score(score)
	
	# Destroy all previous mobs before starting game
	get_tree().call_group("mobs", "queue_free")
	$Player.start($StartPosition.position)
	
	$StartTimer.start()
	
	$Music.play()
	
	$HUD.show_message("Get ready...")
	
	
	yield($StartTimer, "timeout")
	$ScoreTimer.start()
	
	$MobTimer.start()
	
	
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	


func _on_MobTimer_timeout():
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.unit_offset = randf()# random float 0-1
	
	var mob = mob_scene.instance()
	add_child(mob)
	
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)


func _on_ScoreTimer_timeout() -> void:
	score += 1
	$HUD.update_score(score)
