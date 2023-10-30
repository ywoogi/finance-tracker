extends Panel

@onready var stat_label = load("res://stat_label.tscn")
var offset = Vector2(500,300)
var du = 3.6 #degree_unit
var r = 100

var price_percentages = {}
var total_price_per_category = {}

var category_percentages = {}
var categories_sorted = []
var category_points = {}
var percentages_sorted = []
# Called when the node enters the scene tree for the first time.
func _ready():
	start()

func start():
	var category_list = []
	categories_sorted = []
	for purchase in g.purchases:
		category_list.append(purchase.get_product().get_category())
	#category_percentages = calculate_percentages(category_list)
	calculate_percentages(category_list)
	var dict_copy = price_percentages.duplicate()
	percentages_sorted = price_percentages.values()
	percentages_sorted.sort()
	for i in percentages_sorted:
		categories_sorted.append(dict_copy.find_key(i))
		dict_copy.erase(dict_copy.find_key(i))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if offset.distance_to(get_global_mouse_position()) < r && is_visible():
		$Label.show()
		$Label.position = get_global_mouse_position()
		var last_percentage = 0
		for category in categories_sorted:
			
			var degrees = last_percentage*du
			var x1 = cos(deg_to_rad(degrees))
			var y1 = -sin(deg_to_rad(degrees))
			var p1 = Vector2(x1, y1)+offset
			
			degrees = (last_percentage+100*percentages_sorted[categories_sorted.find(category)])*du
			var x2 = cos(deg_to_rad(degrees))
			var y2 = -sin(deg_to_rad(degrees))
			var p2 = Vector2(x2, y2)+offset
			
			var deg1 = rad_to_deg(offset.angle_to_point(p1))
			var deg2 = rad_to_deg(offset.angle_to_point(p2))
			var degmouse = rad_to_deg(offset.angle_to_point(get_viewport().get_mouse_position()))
			
			if deg1 < 0:
				deg1 += 360
			if deg2 < 0:
				deg2 += 360
			if degmouse < 0:
				degmouse += 360

			#inverse rotation
			deg1 = 360-deg1
			deg2 = 360-deg2
			degmouse = 360-degmouse
			
			#rotate 90 degrees clockwise
			#deg1 = fmod(deg1 + 90,360)
			#deg2 = fmod(deg2 + 90,360)
			degmouse = fmod(degmouse + 90,360)
			
			if deg1 == 360:
				deg1 = 0
			#$Label.text = str(degmouse)
			
			if deg2 == 0:
				deg2 = 360
			
			if degmouse >= deg1 && degmouse <= deg2:
				$Label.text = category + "\n" + str(total_price_per_category[category]) + "\n" + str(snapped(price_percentages[category]*100,0.01)) + "%"
				break
			else:
				last_percentage += price_percentages[category]*100
			
		
		
	else:
		$Label.hide()

func _draw():
	
	
	var last_percentage = 0
	var dict_copy = category_percentages.duplicate()
	for percentage in percentages_sorted:
		var points = []
		var color
		for i in range(last_percentage, last_percentage+100*percentage+1):
			var degrees = du * i
			var x = sin(deg_to_rad(degrees)) * r
			var y = cos(deg_to_rad(degrees)) * r
			points.append(Vector2(x, y))
		
#		var stat_label_instance = stat_label.instantiate()
#		stat_label_instance.set_text(dict_copy.find_key(percentage))
#		dict_copy.erase(dict_copy.find_key(percentage))
#
#		#var p1 = Vector2(0,0)
#		var p2 = Vector2(sin(deg_to_rad(last_percentage*du)) * r, cos(deg_to_rad(last_percentage*du)) * r)
#		var p3 = Vector2(sin(deg_to_rad((last_percentage+100*percentage)*du)) * r, cos(deg_to_rad((last_percentage+100*percentage)*du)) * r)
#		var p4 = Vector2(sin(deg_to_rad((last_percentage+(100*percentage)/2)*du)) * r, cos(deg_to_rad((last_percentage+(100*percentage)/2)*du)) * r)
#
#		var pcenter = (p2+p3+p4)/3
#		stat_label_instance.position = pcenter+offset
		
#		add_child(stat_label_instance)
		
		last_percentage += percentage*100
		points.append(Vector2(0,0))
		var R = randi_range(0,256)/255.0
		var G = randi_range(0,256)/255.0
		var B = randi_range(0,256)/255.0
		color = Color(R, G, B)
		for p in points:
			points[points.find(p)] += offset
		draw_colored_polygon(points,color)
		
		
		

func calculate_percentages(array: Array):
	
	var dict = {} #total price per category
	var total = g.get_total()
	for purchase in g.purchases:
		var category = purchase.get_product().get_category()
		if dict.has(category):
			dict[category] += purchase.get_total_price()
		else:
			dict[category] = purchase.get_total_price()
	total_price_per_category = dict.duplicate()
	for category in dict:
		dict[category] = dict[category]/float(total)
	price_percentages = dict.duplicate()
	
	
	
#	var dict = {}
#
#	var total = array.size()
#	for item in array:
#		if dict.has(item):
#			dict[item] += 1
#		else:
#			dict[item] = 1
#	var percentage_dict = {}
#	for key in dict:
#		percentage_dict[key] = float(dict[key])/float(total)
#	return percentage_dict


func _on_cancel_button_up():
	hide()
