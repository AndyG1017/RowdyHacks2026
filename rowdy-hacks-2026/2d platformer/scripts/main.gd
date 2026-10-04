extends Node2D

var score: int = 0
var level = 1
var current_level_root: Node = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#setup the level
	current_level_root = get_node("LevelRoot")
	_setup_level()


#LEVEL MANAGEMENT

func _load_level(level_number: int) -> void:
	if current_level_root:
		current_level_root.queue_free()




func _setup_level() -> void:
	var enemies = $Level1root.get_node_or_null("enemies")
	if enemies:
		print("eneimes working")
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)
			
	var coins = $Level1root.get_node_or_null("Coins")
	if coins:
		print("coins working")
		for coin in coins.get_children():
			coin.collected.connect(increase_score)	
				
	var exit = $Level1root.get_node_or_null("Exit")
	if exit:
		print("exit working")
		exit.body_entered.connect(_on_exit_body_entered)




#Signal handlers
func _on_player_died(body):
	#print(body)
	body.die()

func increase_score() -> void:
	score += 1
	print(score)

func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "2DPlayer":
		level += 1
		print("level", level)
		body.can_move = false
