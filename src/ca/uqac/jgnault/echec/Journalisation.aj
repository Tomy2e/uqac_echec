package ca.uqac.jgnault.echec;
import ca.uqac.jgnault.echec.Plateau;

public aspect Journalisation {
	pointcut logMove(int iniX, int iniY, int finX, int finY, boolean PourVrai):
		args(iniX,iniY,finX,finY,PourVrai) &&
		call(public boolean Plateau.Bouger(int, int, int, int, boolean));
	
	after(int iniX, int iniY, int finX, int finY, boolean PourVrai) returning(boolean possible) :logMove(iniX, iniY, finX, finY, PourVrai){
		if(possible && PourVrai)
			System.out.println("after a move : " + (char)(iniX+'a') + "" + (iniY+1) + "" + (char)(finX+'a') + "" + (finY+1));
	}
}
