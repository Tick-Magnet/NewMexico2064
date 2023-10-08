/// @description Idle

rng = irandom_range(1,4);

dest = irandom_range(1,6)

switch rng{
	case 1:
		dest = y - (dest * 16);
		break;
	case 2:
		dest = y + (dest * 16);
		break;
	case 3:
		dest = x + (dest * 16);
		break;
	case 4:
		dest = x - (dest * 16);
		break;
}



state = "WANDER";
