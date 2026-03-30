extends Node2D

@onready var entrance_area = $House/EntranceArea
var player_in_zone = false

func _ready() -> void:
	entrance_area.body_entered.connect(_on_body_entered)
	entrance_area.body_exited.connect(_on_body_exited)
	
	# Сделаем зону видимой для дебага
	var debug_rect = ColorRect.new()
	debug_rect.size = Vector2(40, 60)
	debug_rect.position = Vector2(-20, -30)
	debug_rect.color = Color(1, 0, 0, 0.5)
	entrance_area.add_child(debug_rect)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_zone = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_zone = false

func _input(event: InputEvent) -> void:
	if player_in_zone and event.is_action_pressed("interact"):
		get_tree().change_scene_to_file("res://TownHall.tscn")

