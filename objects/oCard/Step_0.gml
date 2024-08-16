/// @description Insert description here
// You can write your code in this editor
//in_player_hand = is_undefined(ds_list_find_index(oCardMan.player_hand,id));
//the manager is in the picking state
if(oCardMan.state == STATES.PICK)  {
	//if the player has not yet selected two cards
	if(ds_list_size(oCardMan.player_selected) < 1) {
		//and if the card is in the player's hand and is not face up
		if(in_player_hand ) {
			//mouse is over the card and the player pressed the left mouse btn
			if(position_meeting(mouse_x, mouse_y, id) && mouse_check_button_pressed(mb_left)) {
				//flip over the card and add it to the player's selected list
				face_up = true;
				target_y = room_height*0.76;
				target_x = room_width*0.7;
				in_player_hand = false;
				ds_list_add(oCardMan.player_selected, id);
				ds_list_delete(oCardMan.player_hand,ds_list_find_index(oCardMan.player_hand,id));
				hover=false;
				start_fade = true;
				oScore.starterhelp_firsttime=false;
				isChosen=true;
			}
			else if (position_meeting(mouse_x-30, mouse_y, id)){
					target_x = room_width*0.88;
					hover=true;
					hover_counter++;
					start_fade = false;
					hover_fade_alpha=1;
			}else{
				target_x = room_width*0.91;
				hover=true;
				start_fade = true;

			}
		}

	}
}

if (oCardMan.state == STATES.CLEANUP){
moveSpeed=0.3;
	dotrickincomparecounter++;
	if (dotrickincomparecounter>120 and dotrickincomparecounter<180){
		if (isChosen){
			target_y=room_height*0.5;
			moveSpeed=0.2;
			if (y==room_height*0.5)
			dotrickincomparealpha-=0.05;
		}
	}

	
}else{
	dotrickincomparecounter=0;
	dotrickincomparealpha=1;
	moveSpeed=.3;
}



