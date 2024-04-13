extends Node
##basically a simplified vector2 
class_name Point
var x = 0.0
var y = 0.0
var userData #store somthing in it if necessary and access it through search from root

#for testing only
func move():
	x += randf_range(-1,1)
	y += randf_range(-1,1)
