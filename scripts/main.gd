extends Control


@onready var purchase = load("res://purchase.tscn")
@onready var row = load("res://row.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	start()
	
func _input(event):
	if event.is_action("Exit"):
		get_tree().quit()


func start():
	clear()
	add_row("Date","Place","Product","Price","Amount","Category","Total")
	g.sort_purchases_date_desc()
	for p in g.purchases:
		add_purchase(p)
	add_row("Total","","","","","","€"+g.get_total())

func clear():
	for child in %Purchases.get_children():
		child.queue_free()

func _on_add_purchase_b_button_up():
	$AddPurchase.show()
	$AddPurchase.start()


func _on_tree_exiting():
	g.save_files()

func add_purchase(_purchase : Purchase):
	var purchase_instance = purchase.instantiate()
	purchase_instance.set_date(_purchase.get_date())
	purchase_instance.set_place(_purchase.get_place())
	purchase_instance.set_product(_purchase.get_product().get_name())
	purchase_instance.set_price(_purchase.get_product().get_price())
	purchase_instance.set_amount(_purchase.get_amount())
	purchase_instance.set_category(_purchase.get_product().get_category())
	purchase_instance.set_total(_purchase.get_total_price())
	%Purchases.add_child(purchase_instance)
	#if "row" in %Purchases.get_children()[%Purchases.get_child_count() - 2].name.to_lower() && %Purchases.get_child_count() != 2:
	#	%Purchases.move_child(purchase_instance, %Purchases.get_child_count() - 2)

func add_row(a,b,c,d,e,f,gg):
	var row_instance = row.instantiate()
	row_instance.set_date(a)
	row_instance.set_place(b)
	row_instance.set_product(c)
	row_instance.set_price(d)
	row_instance.set_amount(e)
	row_instance.set_category(f)
	row_instance.set_total(gg)
	%Purchases.add_child(row_instance)


func _on_statistics_b_button_up():
	$Statistics.show()
	$Statistics.start()
