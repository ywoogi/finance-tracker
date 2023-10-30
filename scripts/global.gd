extends Node

var places : Array
var categories : Array
var purchases : Array
# Called when the node enters the scene tree for the first time.
func _ready():
	places = []
	categories = []
	purchases = []
	load_files()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_place(_place : String):
	if _place in places:
		return
	else:
		places.append(_place)
		
func add_category(_category : String):
	if _category in categories:
		return
	else:
		categories.append(_category)

func add_purchase(_purchase : Purchase):
	purchases.append(_purchase)

func replace_komma_with_dot(string: String):
	if "," in string:
		return string.replace(",",".")
	return string
	
func save_files():
	var file = FileAccess.open("/Users/erickim/Documents/finances.csv", FileAccess.WRITE)
	var purchases_string = purchases_to_csv()
	file.store_string(purchases_string)
	
	for purchase in purchases:
		add_place(purchase.get_place())
		add_category(purchase.get_product().get_category())
	
	save_array("places",places)
	save_array("categories",categories)
	
	

func load_files():
	var file = FileAccess.open("/Users/erickim/Documents/finances.csv", FileAccess.READ)
	if file != null:
		var csv = file.get_as_text()
		csv_to_purchases(csv)
	
	places = load_array("places")
	categories = load_array("categories")
	print(places,categories)


func save_array(_name :String, array:Array):
	var file = FileAccess.open("/Users/erickim/[98] DATA/"+_name+".dat", FileAccess.WRITE)
	
	var string = ";".join(array)
	
	file.store_string(string)

func load_array(_name : String):
	var array = []
	var file = FileAccess.open("/Users/erickim/[98] DATA/"+_name+".dat", FileAccess.READ)
	if file != null:
		var string = file.get_as_text()
		array = string.split(";")
	return array

func purchases_to_csv():
	var rows = []
	sort_purchases_date_asc()
	for purchase in purchases:
		var row = []
		var date = purchase.get_date()
		row.append(str(date.get_day())+"/"+str(date.get_month())+"/"+str(date.get_year()))
		row.append(purchase.get_place())
		var product = purchase.get_product()
		row.append(product.get_name())
		row.append(str(product.get_price()))
		row.append(str(purchase.get_amount()))
		row.append(product.get_category())
		row.append(purchase.get_total_price())
		rows.append(row)
	
	var csv = ""
	var row_strings = []
	for row in rows:
		row_strings.append(";".join(row))
	csv = "Date;Place;Product;Price;Amount;Category;Total\r\n" + "\r\n".join(row_strings)+"\r\nTotal;;;;;;"+get_total()
	return csv

func csv_to_purchases(csv):
	var rows = csv.replace("\r","").split("\n")
	var purchase_list = []
	rows.remove_at(0) 
	rows.remove_at(rows.size()-1)
	for row in rows:
		row = row.split(";")
		purchase_list.append(row)
	print(purchase_list)
	for row in purchase_list:
		var purchase = Purchase.new()
		var date = Date.new()
		var product = Product.new()
		var csv_date = row[0].split("/")
		date.set_day(int(csv_date[0]))
		date.set_month(int(csv_date[1]))
		date.set_year(int(csv_date[2]))
		purchase.set_place(row[1])
		product.set_name(row[2])
		product.set_price(float(row[3]))
		purchase.set_amount(int(row[4]))
		product.set_category(row[5])
		purchase.set_date(date)
		purchase.set_product(product)
		purchases.append(purchase)

func get_total():
	var total = 0
	for purchase in purchases:
		total += purchase.get_total_price()
	
	return str(total)

func sort_purchases_date_asc():
	purchases.sort_custom(sort_dates_asc)

func sort_purchases_date_desc():
	purchases.sort_custom(sort_dates_desc)

func sort_dates_asc(a: Purchase, b:Purchase):
	var date1 = a.get_date()
	var date2 = b.get_date()
	var d1 = date1.get_day()
	var m1 = date1.get_month()
	var y1 = date1.get_year()
	var d2 = date2.get_day()
	var m2 = date2.get_month()
	var y2 = date2.get_year()
	
	if y1<y2:
		return true
	elif y1==y2:
		if m1<m2:
			return true
		elif m1==m2:
			if d1<d2:
				return true
			else:
				return false
		else:
			return false
	else:
		return false

func sort_dates_desc(a: Purchase, b:Purchase):
	var date1 = a.get_date()
	var date2 = b.get_date()
	var d1 = date1.get_day()
	var m1 = date1.get_month()
	var y1 = date1.get_year()
	var d2 = date2.get_day()
	var m2 = date2.get_month()
	var y2 = date2.get_year()
	
	if y1<y2:
		return false
	elif y1==y2:
		if m1<m2:
			return false
		elif m1==m2:
			if d1<d2:
				return false
			else:
				return true
		else:
			return true
	else:
		return true
