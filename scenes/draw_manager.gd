extends Node2D
#--Not Used-- intended for none node quadtrees
var quadtrees = []
var points :Array= []

func add_quad(quad:Rectangle):
	var s = quadtrees.duplicate()
	quadtrees.append(quad)
	
func add_points(points:Array[Point]):
	points.append_array(points)


func _draw() -> void:
	for quad in quadtrees:
		draw_rect(quad,Color.WHITE,false,1)
	for r in points:
		draw_circle(r,1,Color.WHITE)
