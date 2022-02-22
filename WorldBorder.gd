extends Area2D

onready var area = $CollisionShape2D

func onEntryHallwaybodyentered(body):
gettree().changescene("res://World/room/scene2.tscn")
#AaAAAAARG I DONT KNOW HOW TO MAKE IT SCROLL TO THE NEXT SCREEN BUT ALSO
#FOLLOW THE CHARACTER WHEN THERE'S NO BORDER NEARBY AAAAAHHH
