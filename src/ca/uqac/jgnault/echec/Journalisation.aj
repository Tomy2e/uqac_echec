package ca.uqac.jgnault.echec;

import ca.uqac.jgnault.echec.Plateau;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.Charset;
import java.util.logging.Level;
import java.util.logging.Logger;

public aspect Journalisation {
	pointcut logMove(int iniX, int iniY, int finX, int finY, boolean PourVrai):
		args(iniX,iniY,finX,finY,PourVrai) &&
		call(public boolean Plateau.Bouger(int, int, int, int, boolean));
	
	private String path = new String("Partie.txt");
	
	public Journalisation() {
		try (PrintWriter pw = new PrintWriter(path)){
			pw.close();
		} catch(FileNotFoundException e) {
			Logger.getLogger("ca.uqac.jgnault.echec").log(Level.SEVERE, e.getMessage(), e);
		}
	}
	
	after(int iniX, int iniY, int finX, int finY, boolean PourVrai) returning(boolean possible) :logMove(iniX, iniY, finX, finY, PourVrai){
		if(possible && PourVrai) {
			try (FileOutputStream os = new FileOutputStream(new File(path), true)){
				os.write(new String((char)(iniX+'a') + "" + (iniY+1) + "" + (char)(finX+'a') + "" + (finY+1) + "\n").getBytes(Charset.forName("UTF-8")));
			} catch(IOException e) {
				Logger.getLogger("ca.uqac.jgnault.echec").log(Level.SEVERE, e.getMessage(), e);
			}
		}
	}
}
