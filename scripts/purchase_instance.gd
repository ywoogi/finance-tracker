extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_date(date: Date):
	$Date.text = date.toString()

func set_place(place : String):
	$Place.text = place

func set_product(product : String):
	$Product.text = product

func set_price(price : float):
	$Price.text = "€"+str(price)

func set_amount(amount : int):
	$Amount.text = "x" + str(amount)

func set_category(category : String):
	$Category.text = category

func set_total(total : float):
	$Total.text = "€"+str(total)
