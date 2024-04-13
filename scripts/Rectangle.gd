#Custom rectangle for easy adaptability to other languages
class_name Rectangle
var x=0.0
var y=0.0
var w=100.0
var h=100.0

func _init() -> void:
	pass

func setRect(x,y,w,h):
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	
func set_size(w,h):
	self.w = w
	self.h = h

func contains(point):
	return point.x > x - w/2 &&\
		point.x < x + w/2 &&\
		point.y > y - h/2 &&\
		point.y < y + h/2 

func intersects(_range:Rectangle):
	return !(_range.x - _range.w > x + w or\
		_range.x + _range.w < x - w or\
	 	_range.y - _range.h > y + h or\
		_range.y + _range.h < y - h)
			
