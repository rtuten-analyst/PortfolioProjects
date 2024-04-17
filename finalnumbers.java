package fall2020;
import java.util.Scanner;
//Robert Tuten
//MIS 2845
//Final Exam - Part III, Question 1
/*		Write a method that accepts two arguments: an array and a number n. Assume that the array contains integers. 
 * 		The method should display all of the numbers in the array that are greater than the number n. 
 */

public class finalnumbers {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner input = new Scanner(System.in);
		
		int aSize;
		int[] userArray = new int[5]; 
		int userN;
		
		
		//Ask user how many items they will input to determine array size.
		System.out.println("-- How many values would you like to compare? --");
			aSize = input.nextInt();
			
			
		//Loop and ask X times to fill array.
		for(int w = 0; w<aSize; w++) {
			
			System.out.println("Please enter number\t" + (w+1)); //This is simply saying iteration +1 to display "1st, 2nd, 3rd number of input for user"
			userArray[w] = input.nextInt();
		}
		
		//Ask user what number they want to compare to the input values.
		System.out.println("-- What number would you like to compare these values to? --");	
		userN = input.nextInt();
		
		compare(userArray, userN);
		
	}
	
	public static void compare(int userArray[], int userN) {
		for(int i=0; i<userArray.length; i++) {
			if(userArray[i] > userN) {
				System.out.print(userArray[i] + ", "); //Print number as it comes consecutively.
			}else {//Do nothing
				
			}
		}
		
	}

}
