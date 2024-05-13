extends CanvasLayer

@onready var coin_count = $CoinCount

var coins = 0

func _ready():
	coin_count.text = str(coins)

func add_coin():
	coins += 1
	print("+1 Coin!")
	coin_count.text = str(coins)
