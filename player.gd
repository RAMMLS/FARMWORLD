extends CharacterBody2D

# Настройка скорости персонажа в инспекторе
@export var speed: float = 150.0

@onready var minimap_camera = $CanvasLayer/MinimapContainer/SubViewport/MinimapCamera

# Вектор, указывающий, куда смотрит персонаж (по умолчанию вниз)
var facing_direction: Vector2 = Vector2.DOWN

# Инвентарь
# 0 - Мотыга (копать), 1 - Лейка (поливать), 2 - Семена (сажать), 3 - Руки (собирать)
var inventory = ["hoe", "water_can", "seeds", "hands"]
var current_slot = 0
var seeds_count = 5
var harvested_tomatoes = 0

func _input(event: InputEvent) -> void:
	# Переключение слотов инвентаря цифрами 1, 2, 3, 4
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_1:
			current_slot = 0
			print("Выбрана Мотыга")
		elif event.keycode == KEY_2:
			current_slot = 1
			print("Выбрана Лейка")
		elif event.keycode == KEY_3:
			current_slot = 2
			print("Выбраны Семена (Осталось: ", seeds_count, ")")
		elif event.keycode == KEY_4:
			current_slot = 3
			print("Выбраны Руки (Урожай: ", harvested_tomatoes, ")")

func get_current_tool() -> String:
	return inventory[current_slot]

func _physics_process(_delta: float) -> void:
	var input_dir = Vector2.ZERO
	
	# Получаем ввод (предполагается, что действия w, a, s, d настроены в Input Map)
	# Либо можно использовать стандартные ui_left, ui_right, ui_up, ui_down
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# Нормализация вектора: персонаж не будет двигаться быстрее по диагонали
	if input_dir.length() > 1.0:
		input_dir = input_dir.normalized()
		
	# Запоминаем последнее направление, куда мы шли
	if input_dir != Vector2.ZERO:
		# Округляем до ближайшего целого направления (чтобы копать ровно перед собой)
		facing_direction = input_dir.normalized().round()
		if facing_direction.x != 0 and facing_direction.y != 0:
			# Если идем по диагонали, отдаем приоритет оси X
			facing_direction.y = 0
	
	# Применяем скорость к вектору velocity
	velocity = input_dir * speed
	
	# move_and_slide() перемещает тело на основе velocity и обрабатывает столкновения
	move_and_slide()
	
	# Синхронизируем камеру миникарты с позицией игрока
	if minimap_camera:
		minimap_camera.global_position = global_position
		
func _ready() -> void:
	# Чтобы миникарта видела тот же мир, что и основная игра:
	$CanvasLayer/MinimapContainer/SubViewport.world_2d = get_viewport().world_2d
