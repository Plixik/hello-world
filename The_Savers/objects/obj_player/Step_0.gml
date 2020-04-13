if (keyboard_check(ord("W"))) y -= 2;
if (y < 0) y = 0;

if (keyboard_check(ord("S"))) y += 2;
if (y > room_height) y = room_height;

if (keyboard_check(ord("A"))) x -= 2;
if (x < 0) x = 0;

if (keyboard_check(ord("D"))) x += 2;
if (x > room_width) x = room_width;

//Drop coin
if (keyboard_check_pressed(ord("E")) && ds_stack_size(coinStack) > 0) {
	var coinDrop = ds_stack_pop(coinStack);
	coinDrop.persistent = false;
	coinDrop.x = x;
	coinDrop.y = y + 30;
	obj_camera_manager.coins--;
}

//Pick up coin
var pickCoin = instance_place(x, y, obj_coin);
	if (pickCoin != noone) {
	ds_stack_push(coinStack, pickCoin);
	pickCoin.persistent = true;
	pickCoin.x = 160;
	pickCoin.y = 160;
	obj_camera_manager.coins++;
}

//Room transistion
//instance_place() returns an id or noone. place_meeting() returns true or false
var instRoom = instance_place(x, y, obj_room_warp);
if (instRoom != noone) {
	room_goto(instRoom.targetRoom);
	obj_player.x = instRoom.targetX;
	obj_player.y = instRoom.targetY;
}
