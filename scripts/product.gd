class_name Product


var product_name : String
var price : float
var category : String


func set_name(_name : String):
	product_name = _name

func set_price(_price):
	_price = g.replace_komma_with_dot(str(_price))
	price = float(_price)

func set_category(_category: String):
	category = _category

func get_name():
	return product_name

func get_price():
	return price

func get_category():
	return category

func check_integrity():
	if product_name == "":
		return "product_name"
	if price == 0:
		return "price"
	if category == "":
		return "category"
	return ""
		
	
