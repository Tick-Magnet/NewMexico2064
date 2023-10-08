// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function align_to_grid(val, align_to){

	var diff = val mod align_to; ///# between 0-7 (or align_to)
	var halfway = (align_to - 1) div 2; /// (8 -1 / 2)
	
	if (diff > halfway) {
		
		//show_debug_message(string(align_to - diff));
		return align_to - diff;	
		
	} else {
		
		//show_debug_message(string(-diff));
		return -diff;	
	}
	
}