package fall2020;
import java.util.Scanner;

public class myArray {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		
		int[] numbers = new int[20];
		Scanner input = new Scanner(System.in);
		
		//Create Array, Initialize it by assigning values as "pointers"
		for(int i = 0; i<20; i++) {
			
			System.out.println("Please enter number\t" + (i+1)); //This is simply saying iteration +1 to display "1st, 2nd, 3rd number of input for user"
			numbers[i] = input.nextInt();
		}
		//Calculate the sum of all the elements within the array.
		int sum = 0; //Initalize
		for (int k = 0; k<20; k++) {
			sum += numbers[k];
		}//This takes sum of previous numbers calculated then adds a new number each iteration.
		
		System.out.println("The sum of the 20 numbers is:\t" + sum);

		
		
	}

}
