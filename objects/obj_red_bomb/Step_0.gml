//Check if player is in collision rectangle
my_room = instance_position(x,y,obj_room);


if place_meeting(x,y,obj_player) or place_meeting(x,y,obj_spear) and dest_x == x and dest_y == y {
	
	
	
	objdist_x = x - obj_player.x;
	objdist_y = y - obj_player.y;

	if abs(objdist_x) > abs(objdist_y) {
		
		for (i = 96; i >= 0; i -= 1) {
				{
					dest_x = x + (sign(objdist_x) * i);
					dest_y = y;
					if place_meeting(x,y,obj_player) {spd = 1 * sign(objdist_x) }
					else if place_meeting(x,y,obj_spear) {spd = 3 * sign(objdist_x) }
					
					break;
				}
		}
	} else {
		
		for (i = 96; i >= 0; i -= 1) {
				{
					dest_x = x;
					dest_y = y + (sign(objdist_y) * i);
					if place_meeting(x,y,obj_player) {spd = 1 * sign(objdist_y) }
					else if place_meeting(x,y,obj_spear) {spd = 3 * sign(objdist_y) }
	
					break;
				}
		}	
	}
	
	
}

if !place_meeting(x,y,obj_wall) {
if (dest_x != x) {x += spd;} else if (dest_y != y) {y += spd;}
}