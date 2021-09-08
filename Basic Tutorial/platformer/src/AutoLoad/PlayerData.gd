extends Node

signal score_updated
signal player_died

var score:= 0 setget set_score #could do , get_score as well

var deaths:= 0 setget set_deaths
# externally changing these vars, auto uses the setters
# PlayerData.score += 1 uses set_score internally

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")

func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_died")

func reset() -> void:
	score = 0
	deaths = 0
