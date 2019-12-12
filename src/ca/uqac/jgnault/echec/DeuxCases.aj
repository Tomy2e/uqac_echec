package ca.uqac.jgnault.echec;

import java.lang.reflect.Field;
import java.util.logging.Level;
import java.util.logging.Logger;

import ca.uqac.jgnault.echec.pieces.Piece;
import ca.uqac.jgnault.echec.pieces.Pion;

public aspect DeuxCases {
	
	pointcut deuxcases(Piece piece, int Joueur, int incX, int incY, boolean PourVrai):
		target(piece) &&
		args(Joueur, incX, incY, PourVrai) &&
		call(boolean Piece.Bouger(int, int, int, boolean));
	
		after(Piece piece, int Joueur, int incX, int incY, boolean PourVrai) returning (boolean value) : deuxcases(piece, Joueur, incX, incY, PourVrai) {
			
			// Un pion avance de 2 cases
			if(Joueur == 1 && !value && incY == 2 && piece instanceof Pion) {
				
				// Verifions si le pion est sur sa case initiale
				try {
					Field privateField = piece.getClass().getSuperclass().getDeclaredField("PosY");
			        privateField.setAccessible(true);
					int field = (int) privateField.get(piece);
					
					// Il est bien sur sa case initiale, on autorise le mouvement
					if(field == 1) {
						piece.Bouger(Joueur, incX, 1, PourVrai);
						piece.Bouger(Joueur, incX, 1, PourVrai);
					}
				} catch (IllegalArgumentException | IllegalAccessException | NoSuchFieldException | SecurityException e) {
					Logger.getLogger("ca.uqac.jgnault.echec").log(Level.SEVERE, e.getMessage(), e);
				}
			}			
		}
}
