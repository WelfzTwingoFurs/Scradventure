extends Camera2D
var RoomX = 1
var RoomY = 1

var WX = 480
var WY = 368

func _process(delta):
	position.x = (WX * RoomX) - (WX/2) - (48 * RoomX) + 48
	position.y = (WY * RoomY) - (WY/2) - (32 * RoomY) + 32

func _on_Aup_body_entered(body):
	if body.is_in_group("player"):
		RoomY -= 1
func _on_Adown_body_entered(body):
	if body.is_in_group("player"):
		RoomY += 1
func _on_Aright_body_entered(body):
	if body.is_in_group("player"):
		RoomX += 1
func _on_Aleft_body_entered(body):
	if body.is_in_group("player"):
		RoomX -= 1