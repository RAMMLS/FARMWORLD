extends Node2D

@onready var tilemap: TileMapLayer = $TileMapLayer
@onready var player: CharacterBody2D = $Player

# Словарь для хранения информации о посаженных растениях
# Формат: {Vector2i(x, y): {"stage": int, "is_watered": bool}}
var plants_data: Dictionary = {}

# Таймер для роста растений (будем проверять рост каждые 5 секунд для теста)
var growth_timer: Timer

# ID источников в TileSet
const SOURCE_BASE = 0
const SOURCE_SEED = 1
const SOURCE_MID = 2
const SOURCE_FULL = 3
const SOURCE_WATER = 4

func _ready() -> void:
	# Получаем координаты тайла, на котором стоит игрок
	var player_pos = tilemap.local_to_map(player.global_position)
	
	# Рисуем большой квадрат травы (тайл 0:0) вокруг игрока
	var radius = 25
	for x in range(-radius, radius):
		for y in range(-radius, radius):
			var cell_pos = player_pos + Vector2i(x, y)
			
			# Если это граница квадрата - рисуем забор (тайл 1:1)
			if x == -radius or x == radius - 1 or y == -radius or y == radius - 1:
				tilemap.set_cell(cell_pos, SOURCE_BASE, Vector2i(1, 1))
			else:
				# Иначе рисуем траву (тайл 0:0)
				tilemap.set_cell(cell_pos, SOURCE_BASE, Vector2i(0, 0))

	# Настраиваем таймер роста
	growth_timer = Timer.new()
	growth_timer.wait_time = 5.0 # Каждые 5 секунд растение будет расти
	growth_timer.autostart = true
	growth_timer.timeout.connect(_on_growth_timer_timeout)
	add_child(growth_timer)

func _input(event: InputEvent) -> void:
	# По нажатию Пробела (interact) взаимодействуем с землей перед персонажем
	if event.is_action_pressed("interact"):
		var player_map_pos = tilemap.local_to_map(player.global_position)
		var facing_offset = Vector2i(player.facing_direction.x, player.facing_direction.y)
		var target_map_pos = player_map_pos + facing_offset
		
		var source_id = tilemap.get_cell_source_id(target_map_pos)
		var current_tile = tilemap.get_cell_atlas_coords(target_map_pos)
		
		# Узнаем, какой инструмент в руках
		var current_tool = player.get_current_tool()
		
		# 1. Трава -> Вскопанная земля (нужна МОТЫГА)
		if source_id == SOURCE_BASE and current_tile == Vector2i(0, 0):
			if current_tool == "hoe":
				tilemap.set_cell(target_map_pos, SOURCE_BASE, Vector2i(1, 0))
				print("Грядка вскопана!")
			else:
				print("Нужна мотыга (нажми 1), чтобы копать!")
		
		# 2. Вскопанная земля -> Сажаем семечко (нужны СЕМЕНА)
		elif source_id == SOURCE_BASE and current_tile == Vector2i(1, 0):
			if current_tool == "seeds" and player.seeds_count > 0:
				tilemap.set_cell(target_map_pos, SOURCE_SEED, Vector2i(0, 0))
				plants_data[target_map_pos] = {"stage": 1, "is_watered": false}
				player.seeds_count -= 1
				print("Семечко посажено! Осталось семян: ", player.seeds_count)
			elif current_tool == "seeds":
				print("Нет семян!")
			else:
				print("Нужны семена (нажми 3), чтобы сажать!")
			
		# 3. Сухое растение (семечко или среднее) -> Поливаем (нужна ЛЕЙКА)
		elif target_map_pos in plants_data and not plants_data[target_map_pos]["is_watered"]:
			if current_tool == "water_can":
				plants_data[target_map_pos]["is_watered"] = true
				var stage = plants_data[target_map_pos]["stage"]
				if stage == 1:
					tilemap.set_cell(target_map_pos, SOURCE_WATER, Vector2i(0, 0))
				print("Растение полито!")
			else:
				print("Нужна лейка (нажми 2), чтобы полить!")
				
		# 4. Взрослое растение -> Сбор урожая (нужны РУКИ)
		elif target_map_pos in plants_data and plants_data[target_map_pos]["stage"] == 3:
			if current_tool == "hands":
				# Собираем урожай, грядка снова становится пустой вскопанной землей
				tilemap.set_cell(target_map_pos, SOURCE_BASE, Vector2i(1, 0))
				plants_data.erase(target_map_pos)
				player.harvested_tomatoes += 1
				# При сборе урожая даем еще семян
				player.seeds_count += 2
				print("Урожай собран! Всего помидоров: ", player.harvested_tomatoes)
			else:
				print("Выбери пустые руки (нажми 4), чтобы собрать урожай!")

func _on_growth_timer_timeout() -> void:
	# Проходим по всем посаженным растениям
	for pos in plants_data.keys():
		var plant = plants_data[pos]
		
		# Растет только если полито
		if plant["is_watered"]:
			if plant["stage"] == 1:
				plant["stage"] = 2
				plant["is_watered"] = false # Земля высыхает после роста
				tilemap.set_cell(pos, SOURCE_MID, Vector2i(0, 0))
			
			elif plant["stage"] == 2:
				plant["stage"] = 3
				plant["is_watered"] = false
				tilemap.set_cell(pos, SOURCE_FULL, Vector2i(0, 0))
				# Когда выросло полностью, удаляем из отслеживания роста
				plants_data.erase(pos)
