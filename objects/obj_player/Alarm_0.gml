if (state != "DIE") {
/// @description Attack Cool Down
instance_destroy(obj_hit);

switch (sprite_index) {
			case spr_player_attack_north: {
				sprite_index = spr_player_north;
				break;
			}
			case spr_player_attack_south: {
				sprite_index = spr_player_south;
				break;
			}
			case spr_player_attack_east: {
				sprite_index = spr_player_east;
				break;
			}
			case spr_player_attack_west: {
				sprite_index = spr_player_west;
				break;
			}
		}
		
//Reset State		
state = "IDLE";
		
}