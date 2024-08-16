/// @description Insert description here
// You can write your code in this editor


/// @description Insert description here
// You can write your code in this editor

//switch statement is funcationally similar to a long if/else
//this allows us to make it so our states run mutually exclusively

//show_debug_message("deck: "+string(ds_list_size(deck)));
//show_debug_message("player_hand: "+string(ds_list_size(player_hand)));
//show_debug_message("player_select: "+string(ds_list_size(player_selected)));
//show_debug_message("opp_hand: "+string(ds_list_size(opp_hand)));
//show_debug_message("opp_sel: "+string(ds_list_size(opp_selected)));
//show_debug_message("discard: "+string(ds_list_size(discard)));
//show_debug_message("TOTAL: "+string(ds_list_size(deck)+
//							ds_list_size(player_hand)+
//							ds_list_size(player_selected)+
//							ds_list_size(opp_hand)+
//							ds_list_size(opp_selected)+
//							ds_list_size(discard))+"\n");

switch(state) {
	case STATES.DEAL:
		//if the move timer has reset
		if(move_timer == 0) {
			//how many cards the player has
			var _player_num = ds_list_size(player_hand)+ds_list_size(opp_hand);
			//if the player has less than 4 cards
			if(_player_num < 6) {
				
				// do opp first:
				
				if (ds_list_size(opp_hand)<3){
					//grab the top card of the deck
					var _dealt_card = ds_list_find_value(deck, ds_list_size(deck) - 1);
					//remove the card's index from the deck
					ds_list_delete(deck, ds_list_size(deck) - 1);
					//add that card to the player's hand
					ds_list_add(opp_hand, _dealt_card);
					ds_list_add(temp_opp_hand,_dealt_card.image_index);
					if (_dealt_card.image_index=0)attack_dis++;
					if (_dealt_card.image_index=1)defend_dis++;
					if (_dealt_card.image_index=2)upgrade_dis++;
					//set the card's target position to the hand area
					_dealt_card.target_x = room_width*.09;
					_dealt_card.target_y = room_height * 0.17 + ds_list_size(opp_hand) * hand_x_offset;
					//_dealt_card.x = room_width/4 + _player_num * hand_x_offset;
					//_dealt_card.y = room_height * 0.8;
					//let the card know it's in the player's hand
					//_dealt_card.in_player_hand = true;
				}else{
				//grab the top card of the deck
				var _dealt_card = ds_list_find_value(deck, ds_list_size(deck) - 1);
				//remove the card's index from the deck
				ds_list_delete(deck, ds_list_size(deck) - 1);
				//add that card to the player's hand
				ds_list_add(player_hand, _dealt_card);
		
				//set the card's target position to the hand area
				_dealt_card.target_x = room_width*.91;
				_dealt_card.target_y = room_height * 0.17+ ds_list_size(player_hand) * hand_x_offset;
				//_dealt_card.x = room_width/4 + _player_num * hand_x_offset;
				//_dealt_card.y = room_height * 0.8;
				//let the card know it's in the player's hand
				_dealt_card.in_player_hand = true;
				_dealt_card.face_up=true;
				}
			} else {
				//HOW COMPUTER CHOOSE CODE AREA
				randomize();
				var _percentage =irandom_range(1,10);
				var _1out3 =irandom_range(0,2);
				var _opPick = ds_list_find_value(opp_hand,_1out3);

				var _attackIn = ds_list_find_index(temp_opp_hand,0);
				var _upgradeIn = ds_list_find_index(temp_opp_hand,2);
				var _defIn = ds_list_find_index(temp_opp_hand,1);
				//var _opPick = ds_list_find_value(opp_hand,_temp);
				if (attack_dis == (num_cards/4)){
					if (_upgradeIn!=-1){
						_opPick = ds_list_find_value(opp_hand,_upgradeIn);
					}
					else if (_attackIn!=-1){
						_opPick = ds_list_find_value(opp_hand,_attackIn);
					}
				}
				else if (defend_dis== (num_cards/4)){
					if (_attackIn!=-1){
						_opPick = ds_list_find_value(opp_hand,_attackIn);
					}
				}
				//if attack<attack+upgrade*2
				else if (oMComputer.attack_score <oMComputer.attack_score+(oMComputer.upgrade_score*2)){
					var _upgradeIn = ds_list_find_index(temp_opp_hand,2);
					if (_upgradeIn!=-1 and _percentage<8){
					_opPick = ds_list_find_value(opp_hand,_upgradeIn);
					}
				}
				
				else if(oMComputer.hp_score<=oMPlayer.attack_score){
					if (_defIn!=-1 and _percentage<10){
					_opPick = ds_list_find_value(opp_hand,_upgradeIn);
					}
				}
				
				//END CODE
				ds_list_add(opp_selected,_opPick);
				ds_list_delete(opp_hand,ds_list_find_index(opp_hand,_opPick));
				_opPick.target_x = room_width*0.3;
				_opPick.target_y = room_height*0.76;
				_opPick.isChosen=true;
				oScore.starterhelp=true;
				state = STATES.PICK;
			}
		}
		break;
	case STATES.PICK:
		//show_debug_message("pick state");
		//if the player has selected two cards
		if(ds_list_size(player_selected) == 1) {
			//start resolving
			state = STATES.COMPARE;
		}
		//if we're resolving but not cleaning up
		break;
	case STATES.COMPARE:
		//if the two selected cards match or do not match, tell the player in a
		//debug message
		var player_val = ds_list_find_value(player_selected, 0).face_index;
		var opp_val = ds_list_find_value(opp_selected, 0).face_index;
		
		switch (player_val){
			case 0:
				oMPlayer.start_attack=true;
				if (opp_val !=1){
					//oMComputer.takedmg(oMPlayer.attack_score);
				}else{
					//oScore.block(0,1);
				}
				break;
			case 1:
				oMPlayer.start_def=true;
				break;
			case 2:
				oMPlayer.start_upgrade=true;
				//oMPlayer.upgrade();
				//oScore.upgrade_start(oMPlayer.upgrade_score,0);
				break;
		}
		switch (opp_val){
			case 0:
				oMComputer.start_attack=true;
				if (player_val !=1){
					//oMPlayer.takedmg(oMComputer.attack_score);
				}else{
					//oScore.block(1,0);
				}
				break;
			case 1:
				oMComputer.start_def=true;
				break;
			case 2:
				oMComputer.start_upgrade=true;
				//oMComputer.upgrade();
				//if (player_val !=2)
					//oScore.upgrade_start(0,oMComputer.upgrade_score);
				//else
					//oScore.upgrade_start(oMPlayer.upgrade_score,oMComputer.upgrade_score);
				break;
		}
		//start cleaning up
		state = STATES.CLEANUP;
		move_timer=1;
		//if we're resolving and cleaning up
		break;
	case STATES.CLEANUP:
	//show_debug_message( ds_list_size(discard));
	if (clean_up_counter > 40){
		if (ds_list_size(opp_selected)>0){
			var _hand_card = ds_list_find_value(opp_selected, ds_list_size(opp_selected) - 1);
			_hand_card.face_up=true;
		}
		if (clean_up_counter > 170){
			playerwasdef=false;
			playerwasup=false;
			if (oMPlayer.start_attack){
				oMPlayer.image_index=oMPlayer.first_attack_frame+1;
				audio_play_sound(sRoar,10,false);
				oMPlayer.start_attack=false;
				
				if (oMComputer.start_def==false){
					oMComputer.takedmg(oMPlayer.attack_score);
				}else{
					oScore.block(0,1);
					oMPlayer.takedmg(oMPlayer.attack_score/2);
				}
			}if (oMPlayer.start_def){
				oMPlayer.image_index=oMPlayer.first_dogde_frame+1;
				audio_play_sound(sRoar,10,false);
				playerwasdef=true;
				oMPlayer.start_def=false;
			}if (oMPlayer.start_upgrade){
				oMPlayer.image_index=oMPlayer.first_upgrade_frame+1;
				audio_play_sound(sRoar,10,false);
				oMPlayer.start_upgrade=false;
				playerwasup=true;
				oMPlayer.upgrade();
				oScore.upgrade_start(oMPlayer.upgrade_score,0);
				
				
			}if (oMComputer.start_attack){
				if (!(oMPlayer.image_index > oMPlayer.first_attack_frame and oMPlayer.image_index<oMPlayer.first_dogde_frame)){
				oMComputer.image_index=oMComputer.first_attack_frame+1;
				audio_play_sound(sRoar,10,false);
				oMComputer.start_attack=false;
				if (playerwasdef=false){
					oMPlayer.takedmg(oMComputer.attack_score);
				}else{
					oScore.block(1,0);
					oMComputer.takedmg(oMComputer.attack_score/2);
				}
				}
			}if (oMComputer.start_def){
				oMComputer.image_index=oMComputer.first_dogde_frame+1;
				oMComputer.start_def=false;
			}if (oMComputer.start_upgrade){
				oMComputer.image_index=oMComputer.first_upgrade_frame+1;
				oMComputer.start_upgrade=false;
				
				oMComputer.upgrade();
				if (playerwasup=false)
					oScore.upgrade_start(0,oMComputer.upgrade_score);
				else
					oScore.upgrade_start(oMPlayer.upgrade_score,oMComputer.upgrade_score);
			}
		}
	}
	if (clean_up_counter>200){
	if (move_timer==0){
		if (ds_list_size(opp_selected)>0){
			//get the last card
			var _hand_card = ds_list_find_value(opp_selected, ds_list_size(opp_selected) - 1);
			
			//remove its index from the player's hand and add it to the discard list
			ds_list_delete(opp_selected, ds_list_size(opp_selected) - 1);
			ds_list_add(discard, _hand_card);
			
			//set the card's target position to the discard area
			_hand_card.target_x = room_width * 0.5;
			_hand_card.target_y = room_height*0.9-ds_list_size(discard)*1;
			_hand_card.target_depth=-ds_list_size(discard);
			_hand_card.face_up=true;
			_hand_card.isChosen=false;
			
		}
		else if (ds_list_size(player_selected)>0){
			//get the last card
			var _hand_card = ds_list_find_value(player_selected, ds_list_size(player_selected) - 1);
			
			//remove its index from the player's hand and add it to the discard list
			ds_list_delete(player_selected, ds_list_size(player_selected) - 1);
			ds_list_add(discard, _hand_card);
			
			//set the card's target position to the discard area
			_hand_card.target_x = room_width * 0.5;
			_hand_card.target_y = room_height*0.9-ds_list_size(discard)*1;
			_hand_card.target_depth=-ds_list_size(discard);
			_hand_card.face_up=true;
			_hand_card.isChosen=false;
			if (_hand_card.image_index=0)attack_dis++;
			if (_hand_card.image_index=1)defend_dis++;
			if (_hand_card.image_index=2)upgrade_dis++;
		}
		else if (ds_list_size(opp_hand)>0){
			//get the last card
			var _hand_card = ds_list_find_value(opp_hand, ds_list_size(opp_hand) - 1);
			
			//remove its index from the player's hand and add it to the discard list
			ds_list_delete(opp_hand, ds_list_size(opp_hand) - 1);
			ds_list_add(discard, _hand_card);
			
			//set the card's target position to the discard area
			_hand_card.target_x = room_width * 0.5;
			_hand_card.target_y = room_height*0.9-ds_list_size(discard)*1;
			_hand_card.target_depth=-ds_list_size(discard);
			_hand_card.face_up=true;
			_hand_card.isChosen=false;
		}
		else if (ds_list_size(player_hand)>0){
			//get the last card
			var _hand_card = ds_list_find_value(player_hand, ds_list_size(player_hand) - 1);
			
			//remove its index from the player's hand and add it to the discard list
			ds_list_delete(player_hand, ds_list_size(player_hand) - 1);
			ds_list_add(discard, _hand_card);
			
			//set the card's target position to the discard area
			_hand_card.hover = false;
			_hand_card.target_x = room_width * 0.5;
			_hand_card.target_y = room_height*0.9-ds_list_size(discard)*1;
			_hand_card.target_depth=-ds_list_size(discard);
			_hand_card.in_player_hand = false;
			_hand_card.face_up=true;
			_hand_card.isChosen=false;
			if (_hand_card.image_index=0)attack_dis++;
			if (_hand_card.image_index=1)defend_dis++;
			if (_hand_card.image_index=2)upgrade_dis++;
		}else{
			ds_list_clear(player_selected);
			ds_list_clear(player_hand);
			if (ds_list_size(deck)>0)
			state = STATES.DEAL;
			clean_up_counter=0;
			
		}
	}
	}
		clean_up_counter++;
		break;
	case STATES.SHUFFLE:
		//get the discard size
		//take the last discard and move it to the deck
		//if there's no more cards in the discard, shuffle the deck
		//state = deal
		attack_dis=0;
		upgrade_dis=0;
		defend_dis=0;
		
		var _player_dis = ds_list_size(discard);
		if (_player_dis>0){
			var _hand_card = ds_list_find_value(discard, ds_list_size(discard) - 1);
			//remove its index from the dis and add to deck
			ds_list_delete(discard, ds_list_size(discard) - 1);
			ds_list_add(deck, _hand_card);
			_hand_card.target_x =x;
			_hand_card.target_y =y-60;
			//reset everuthinh in Ocard
			_hand_card.face_up=false;
			
		}else{
			if (shuffle_counter>=50 and shuffle_counter < 160 ){
			randomize();
			if (shuffle_counter=50){
			ds_list_shuffle(deck);
			for(var _i = 0; _i < num_cards; _i++) {
				deck[| _i].target_depth = num_cards - _i;
				//deck[| _i].y = y - (2 * _i);
			}
			}
			//set the depth and y pos of the cards to be staggered
			//to make it look like a real deck
			if (redeck_counter %4==0 and redeck_counter_index < num_cards){
				var temp =num_cards-redeck_counter_index-1;
				deck[|redeck_counter_index].target_y = y - (1 * redeck_counter_index);
				redeck_counter_index++;
			}
			
			}
			else if (shuffle_counter >160){
			state=STATES.DEAL;
			shuffle_counter=0;
			redeck_counter=0;
			redeck_counter_index=0;
			}
			shuffle_counter++;
			redeck_counter++;
			
		}
		break;
}

//increment the move timer every frame
move_timer++;
//if the move timer is 16 or more
if(move_timer > 20) {
	//reset it
	//a card can move on the next frame
	move_timer = 0;
}

if (ds_list_size(deck)==0 and ds_list_size(player_hand)==0 and ds_list_size(player_selected)==0){
	if (discard[|ds_list_size(discard)-1].x==room_width * 0.5)
	state=STATES.SHUFFLE;
}



