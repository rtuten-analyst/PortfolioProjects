package fall2020;
import java.util.Scanner;
//Robert Tuten
//MIS 2845
//Optional Assignment - Problem 2


public class optional2Strings {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner input = new Scanner(System.in);
		

		
		System.out.print("Please enter a string:\n");
		String message = input.nextLine();
		
		System.out.print("Please enter a character:\n");
		String scenario = input.nextLine();
		char ch = scenario.charAt(0); //Only records the first character the user inputs.
		
	
		
		int matches = 0; //Initalize matches. Add each time a character has been found!
		
		for(int i=0; i<=message.length()-1; i++) {
			//System.out.println(message.charAt(i));
			if(ch == message.charAt(i)){
				matches += 1; //Increment by one each match finding
			}
		}
		System.out.println("We have found  '" + matches + "'  matches to the letter  '" + ch + "'  within the string:\t ''" + message + "''");

	}
}

