/// @description Change Rooms

global.active_room = -1;

room_goto(target_room);
obj_player.x = target_x;
obj_player.y = target_y;