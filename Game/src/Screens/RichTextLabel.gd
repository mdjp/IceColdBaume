extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var blinkrate = 1;
var timecount = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timecount += delta
	if(timecount >= blinkrate):
		timecount = 0
		self.visible = !self.visible
