extends Node
class_name Particle
var x = 0.0
var y = 0.0
var r = 4
var highlight = false

func move():
	x += randf_range(-1,1)
	y += randf_range(-1,1)

func intersets(other :Particle):
	return x + r > other.x + other.r and\
		x - r < other.x-other.r and\
		y + r > other.y + other.r and\
		y - r < other.y-other.r
