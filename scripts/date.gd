class_name Date

var day : int
var month : int
var year : int

func set_day(_day : int):
	if _day in range(1,32):
		day = _day
	
func set_month(_month : int):
	if _month in range(1,13):
		month = _month

func set_year(_year : int):
	year = _year
	
func get_day():
	return day

func get_month():
	return month

func get_year():
	return year

func toString():
	return str(day) + "/" + str(month) + "/" + str(year)

func check_integrity():
	if day == null:
		return "day"
	if month == null:
		return "month"
	if year == null:
		return "year"
	return ""
