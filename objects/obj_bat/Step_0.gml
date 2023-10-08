//Double Check Death
if (state = "DIE") {
		sprite_index = unit_death_animation;
			
			if (image_index >= image_number - 1) {
			    	
				rng = irandom_range(1,5);
				
				switch rng { 
				
					case 1: {/*Nothing*/ break;}
					case 5: {/*Nothing*/ break;}
					case 2: {instance_create_layer(x,y,"Drops",obj_heart) break;}
					
				}
				
				instance_destroy(id);
			}
		
	}


//Begin Action
if (global.active_room == my_room) {
		
	
	
	if !place_meeting(x,y,my_room) {
		instance_destroy();	
	}
	
	///First Check If Enemy Has Been Hit!
	//Check if hit
	if place_meeting(x,y,obj_hit) and (iframes == false) and (state != "HIT"){
		state = "HIT";
	}
	
	
	

	switch (state) {
		
		case "ATTACKED": {
			
			state = "WANDER";
			bounce = 4;
		
			objdist_x = x - obj_player.x;
			objdist_y = y - obj_player.y;
			
			if abs(objdist_x) > abs(objdist_y) {
			
				if sign(objdist_x) == 1 {rng = 3;} else {rng = 4;} 
			
				//Bounce Back Four Pixels if Possible
				for (i = bounce; i >= 0; i -= 1) {	
					if !place_meeting(x + (sign(objdist_x) * i), y, obj_wall)
						{
							x = x + (sign(objdist_x) * i);
							break;
						}
					}
					
			} else {
			
				if sign(objdist_y) == 1 {rng = 2;} else {rng = 1;} 
				
				//Bounce Back Four Pixels if Possible
				for (i = bounce; i >= 0; i -= 1) {
					if !place_meeting(x, y + (sign(objdist_y) * i), obj_wall)
						{
							y = y + (sign(objdist_y) * i);
							break;
						}
					}	
			}
			
			break;
		}

		//Standin Around
		case "IDLE": {
			image_speed = 0;
			sprite_index = unit_sprite;
			
			if (rng = 0) {
				alarm[1] = 15;
				rng = 5;
			}
			break;
		}
		
		//Walkin' Around
		case "WANDER": {
			
			image_speed = sprite_speed;
			sprite_index = unit_sprite;
			
			switch (rng) {
			
				//North
				case 1: {
					
					if !place_meeting(x, y - spd, obj_wall) and (y != dest) and place_meeting(x,y - spd, my_room) {y -= spd;} 
					else {
						state = "IDLE"
						rng = 0;
					}
					break;
				} 
				
				//South
				case 2: {
					
					if !place_meeting(x, y + spd, obj_wall) and (y != dest) and place_meeting(x,y + spd, my_room) {y += spd;} 
					else {
						state = "IDLE"
						rng = 0;
					}
					break;
				} 
				
				//East
				case 3: {
					
					image_xscale = 1;


					if !place_meeting(x + spd, y, obj_wall) and (x != dest) and place_meeting(x + spd,y, my_room) {x += spd;} 
					else {
						state = "IDLE"
						rng = 0;
					}
					break;
					
				} 
				
				//West
				case 4: {
					
					image_xscale = -1;
					
					if !place_meeting(x - spd, y, obj_wall) and (x != dest) and place_meeting(x - spd,y, my_room) {x -= spd;} 
					else {
						state = "IDLE"
						rng = 0;
					}
					break;
					
				} 
				
			}
			
			break;
		}

		case "HIT": {
		
			//Stop AI 
			image_speed = 6;
			
			sprite_index = unit_sprite_hurt;
			 
			x_goal = 0;
			y_goal = 0;
			rng = 0;
			
			//Play Damage Audio
			if hit_audio_playing == false {
				audio_play_sound(snd_hit_medium, 10, false);
				hit_audio_playing = true;
			}
		
			
			//Determine Knockback
			if (iframes == false) {
				iframes = true;
				hp -= 1;
				alarm[0] = 30;
			}
			
			if (hp <= 0) {state = "DIE";}
			
			if (knockback_x == noone and knockback_y == noone) {
			
				switch (obj_player.sprite_index) {
					case spr_player_attack_north: {
						
						knockback_x = x;
						knockback_y = y - 48;
						
						break;
					}
					case spr_player_attack_south: {
						knockback_x = x;
						knockback_y = y + 48;
						
						break;
					}
					case spr_player_attack_east: {
						
						knockback_x = x + 48;
						knockback_y = y;
					
						break;
					}
					case spr_player_attack_west: {
						
						knockback_x = x - 48;
						knockback_y = y;
						
						break;
					}
				}
				
			} else {
				
				////Knockback 
				//Handling X-Axis Collisions
				if (knockback_x != x) {
					dir = sign(knockback_x - x)
					if !place_meeting((x + (dir * 3)), y, obj_wall) {x += (dir * 3);} 
					else {
						for (i = 0; i < 3; i += 1) {
							if !place_meeting((x + (dir)), y, obj_wall) {x += (dir);} 
						}
						knockback_x = noone;
						knockback_y = noone;
						state = "IDLE";
					}
				} 
				
				//Handling Y-Axis Collisions
				if (knockback_y != y) {
					dir = sign(knockback_y - y)
					if !place_meeting(x, (y + (dir * 3)), obj_wall) {y += (dir * 3);} 
					else {
						for (i = 0; i < 3; i += 1) {
							if !place_meeting(x, (y + (dir)), obj_wall) {y += (dir);} 
						}
						
						knockback_x = noone;
						knockback_y = noone;
						state = "IDLE";
					}		
				}
				
				//Normal Moveback
				if (knockback_y == y and knockback_x == x) {
					knockback_x = noone;
					knockback_y = noone;
					state = "IDLE";
				}
			}
			
			break;
		}
		
		case "DIE": {
			sprite_index = unit_death_animation;
			
			if (image_index >= image_number - 1) {
			    	
				rng = irandom_range(1,5);
				
				switch rng { 
				
					case 1: {/*Nothing*/ break;}
					case 5: {/*Nothing*/ break;}
					case 2: {instance_create_layer(x,y,"Drops",obj_heart) break;}
					case 3: {instance_create_layer(x,y,"Drops",obj_cash) break;}
					case 4: {instance_create_layer(x,y,"Drops",obj_shot) break;}
					
				}
				
				instance_destroy(id);
			}
			
			break;
		}
	}
	
}  