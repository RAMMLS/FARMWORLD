extends Node2D

@onready var exit_area = $Background/ExitArea
var player_in_zone = false

func _ready() -> void:
	exit_area.body_entered.connect(_on_body_entered)
	exit_area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_zone = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_zone = false

func _input(event: InputEvent) -> void:
	if player_in_zone and event.is_action_pressed("interact"):
		get_tree().change_scene_to_file("res://main.tscn")

