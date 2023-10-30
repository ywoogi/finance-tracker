extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_date(date: String):
	$Date.text = date

func set_place(place : String):
	$Place.text = place

func set_product(product : String):
	$Product.text = product

func set_price(price : String):
	$Price.text = str(price)

func set_amount(amount : String):
	$Amount.text = str(amount)

func set_category(category : String):
	$Category.text = category
	
func set_total(total : String):
	$Total.text = total
