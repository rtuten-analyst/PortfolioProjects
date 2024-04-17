package fall2020;
import java.util.Scanner;

public class assign6Strings {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner input = new Scanner(System.in);
		
		System.out.println("Please enter a line of text:\t");
		String userLine = input.nextLine();
		
		String down = userLine.toLowerCase(); //Convert user text into ALL Upercase
		String up = userLine.toUpperCase(); //Convert user text into ALL Lowercase
		
		System.out.println(up);
		System.out.println(down);
		
		for (int i=userLine.length()-1; i>=0; i--) { //Displays user text in Reverse
			System.out.print(userLine.charAt(i)); 
		}

		System.out.println();
		System.out.println();
		
		System.out.println("Please enter another line of text:\t");
		String userLine2 = input.nextLine(); //Record second line of text from user.
		String down2 = userLine2.toLowerCase(); //Set the line of text to ALL Lowercase.
		
		System.out.println();
		
		if (down.contentEquals(down2)) { //Compare content of first and second user inputs, both of which have been set to Lowercase.
			System.out.println("These strings are the same!");
		}else
			System.out.println("These strings are different!");
	}

}
