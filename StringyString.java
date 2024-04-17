package fall2020;
import java.util.Scanner;

public class StringyString {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner input = new Scanner(System.in);
		
		System.out.print("What is your name:\n");
		String username = input.nextLine();
		
		//q1
		System.out.print("-----Print Full Name::\n"); // Print all characters on a line.
		for(int i=0; i<=username.length()-1; i++) {
			System.out.println(username.charAt(i));
			
		}
		//q2 method: s.indexOf(str) "Yinan Yu" We need to identify position of space to know what the position of first/last name. Index of (" ")
		System.out.print("-----Just First name:\n");
		for (int i=0; i<username.indexOf(" "); i++) { //Notice we're just displaying values up to the " "
			System.out.println(username.charAt(i));
		}
		
		System.out.print("-----Just Last Name:\n"); //Notice we're starting at the " " then incrementing
		for (int i=username.indexOf(" ")+1; i<username.length();i++) {
			System.out.println(username.charAt(i));
		}
		
		
		//q3
		System.out.print("-----Last Name Backwards:\n");
		for(int i =username.length()-1; i>username.indexOf(" "); i--) { //Notice we're starting at the maximum length location, then decrement to " "
			System.out.println(username.charAt(i));
		}
		
	}

}
