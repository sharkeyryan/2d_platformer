extends CanvasLayer

@onready var coin_count = $CoinCount

var coins = 0

func _ready():
	coin_count.text = str(coins)

func add_coin():
	coins += 1
	coin_count.text = str(coins)
