package ramsystem;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class readfile {

	int filelength = 0;
	
	public String[] loadStrings(String filename)
	{
		this.filelength = 0;
		int i=0;
		String readstring = null;
		try{
		BufferedReader store = new BufferedReader(new FileReader(filename));
		while ((readstring=store.readLine() )!= null) {
			filelength++;
		}
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		String []b = new String[filelength];
		try{
			BufferedReader store2 = new BufferedReader(new FileReader(filename));
			while ((readstring=store2.readLine() )!= null) {
                  b[i++] = readstring; 				
			}
			}
			catch (IOException e) {
				e.printStackTrace();
			}
		
		return b;
	}
	
}
