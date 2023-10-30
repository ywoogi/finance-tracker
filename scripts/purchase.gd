class_name Purchase


var date : Date
var product : Product
var place : String
var amount : int

func set_date(_date: Date):
	date = _date

func set_product(_product: Product):
	product = _product
	
func set_place(_place: String):
	place = _place

func set_amount(_amount : int):
	amount = _amount

func get_date():
	return date
	
func get_product():
	return product
	
func get_place():
	return place
	
func get_amount():
	return amount

func get_total_price():
	return product.price * amount

func check_integrity():
	#if date.check_integrity() != "":
	#	return date.check_integrity()
	if product.check_integrity() != "":
		return product.check_integrity()
	if place == "":
		return "place"
	#if amount == null:
	#	return "amount"
	return ""

func update_global_lists():
	g.add_category(product.category)
	g.add_place(place)
	
func toString():
	var string = "Product: "+product.get_name()+"x"+str(amount)+"\nTotal: "+str(get_total_price())
	
	return string
