/// @description Insert description here
// You can write your code in this editor

//position of hand
hand_x_offset = 130;
resetx = x;
//number of cards in deck
num_cards = 24;
x=room_width*0.5;
y=room_height*0.2;

//enum = constant (unchangable variable)
//which allows us to create our own data type
//each potential value is a state in the card game
enum STATES
{
	DEAL,
	PICK,
	COMPARE,
	CLEANUP,
	SHUFFLE
}

//set the initial state to deal
state = STATES.DEAL;

//this controls when a card can move
//from the deck to the hand
//or the hand to the discard
//or the discard to the deck
//you'll need a seperate one for when the game pauses
//to show the player information
move_timer = 0;

//lists for different card states
deck = ds_list_create();
player_hand = ds_list_create();
opp_hand = ds_list_create();
temp_opp_hand = ds_list_create();
player_selected = ds_list_create();
opp_selected= ds_list_create();
discard = ds_list_create();

//create the deck
for(var _i = 0; _i < num_cards; _i++) {
	//make a card
	var _new_card = instance_create_layer(x, y, "Instances",oCard);
	//set its face color
	//% is modulo
	//it finds the remainder of the two numbers
	//this allows us to iterate through 0, 1, 2 for the face
	_new_card.face_index = _i % 3;
	//if the card should be face up
	_new_card.face_up = false;
	//if the card is in the player's hand
	_new_card.in_player_hand = false;
	//depth the card should move to
	_new_card.target_depth = 0;
	_new_card.target_x = x;
	_new_card.target_y = y;
	_new_card.moveSound=false;
	_new_card.hover=false;
	//add the card to the deck
	ds_list_add(deck, _new_card);
}

//shuffle the deck
randomize();
ds_list_shuffle(deck);

//set the depth and y pos of the cards to be staggered
//to make it look like a real deck
for(var _i = 0; _i < num_cards; _i++) {
	deck[| _i].target_depth = - _i;
	deck[| _i].target_y = y - (1 * _i);
	//deck[| _i].y = y - (2 * _i);
}

//freeze counters
//i can't think of a better way to pause the game except for a bunch of counters
shuffle_counter=0;
redeck_counter=0;
	redeck_counter_index=0;
clean_up_counter=0;

player_score=0;
opp_score=0;
target_player_score=false;
target_opp_score=false;

dotrickincomparecounter=0;

//computer calculate:
attack_dis=0;
upgrade_dis=0;
defend_dis=0;