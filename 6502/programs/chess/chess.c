// Checkmate
// Check
// Capture
// Push
#include "stdio.h" 

struct Piece{
	char color;  // W for white else B
	short int piece;    // -1-pawn, 0-rook, 1-knt, 2-bishop, 3-queen, 4,king, 5-bishop, 6-knt, 7-rook
};

void setupBoard(struct Piece* board){
	for(int i=0; i<16; i++){
		if(i<7){  // White Pieces
			// Main pieces
			board[i, 0].color = 'W';
			board[i, 0].piece = i;
			// Pawns
			board[i, 1].color = 'W';
			board[i, 1].piece = -1;

		}else{  
			// Black Pieces
			// Main pieces			
			board[i-7, 7].color = 'B';
			board[i-7, 7].piece=i-7;
			// Pawns
			board[i-7,6].color = 'B';
			board[i-7,6].piece = -1;
		}
		
	}
}

int main(){
	struct Piece board[32];
	setupBoard(board);
	return 0;
}
