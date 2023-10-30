extends Panel

var purchase: Purchase
var product: Product
var date : Date
@onready var list_item = load("res://list_item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start():
	purchase = Purchase.new()
	product = Product.new()
	date = Date.new()
	date.set_day($Day.value)
	date.set_month($Month.value)
	date.set_year($Year.value)
	purchase.set_place($Place.text)
	product.set_name($Product.text)
	product.set_price($Price.text)
	purchase.set_amount($Amount.value)
	product.set_category($Category.text)
	purchase.set_product(product)
	purchase.set_date(date)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_place_text_changed(_place):
	if %Place.text != _place:
		%Place.text = _place
		%Place.caret_column = _place.length()
	purchase.set_place(_place)
	var place_list = []
	for p in g.places:
		if _place.to_lower() in p.to_lower() && _place.to_lower() != p.to_lower():
			place_list.append(p)
	show_places(place_list)

func _on_product_text_changed(_product):
	product.set_name(_product)

func _on_day_value_changed(value):
	date.set_day(value)

func _on_month_value_changed(value):
	date.set_month(value)

func _on_year_value_changed(value):
	date.set_year(value)

func _on_amount_value_changed(value):
	purchase.set_amount(value)

func _on_price_text_changed(_price):
	product.set_price(_price)
	
func _on_category_text_changed(_category):
	if %Category.text != _category:
		%Category.text = _category
		%Category.caret_column = _category.length()
	product.set_category(_category.capitalize())
	var category_list = []
	for c in g.categories:
		if _category.to_lower() in c.to_lower() && _category.to_lower() != c.to_lower():
			category_list.append(c)
	show_categories(category_list)
	


func _on_cancel_button_up():
	hide()


func _on_add_button_up():
	print(purchase.check_integrity())
	if purchase.check_integrity() == "":
		g.add_purchase(purchase)
		g.sort_purchases_date_desc()
		g.save_files()
		purchase.update_global_lists()
		get_parent().start()
		print("purchase added:")
		print(purchase.toString())
		hide()


func show_categories(categories: Array):
	for child in %Categories.get_children():
		child.queue_free()
	for category in categories:
		var list_item_instance = list_item.instantiate()
		list_item_instance.set_text(category)
		%Categories.add_child(list_item_instance)


func show_places(places: Array):
	for child in %Places.get_children():
		child.queue_free()
	for place in places:
		var list_item_instance = list_item.instantiate()
		list_item_instance.set_text(place)
		%Places.add_child(list_item_instance)




