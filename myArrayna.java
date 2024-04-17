package fall2020;
import java.util.Scanner;

public class myArrayna {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int[] numbers = new int[5];
		Scanner input = new Scanner(System.in);

		
		for (int i = 0; i<numbers.length; i++) {
			System.out.println("Please enter number " + (i+1)); //Need to i+1 for display purposes to users. Otherwise it starts at '0'
			numbers[i] = input.nextInt(); //Assign value into array from user each iteration
		}
		double average = arrAvg(numbers); //Alling the method using the numbers variable.
		System.out.println("The average of the elements from this array is:\t" + average);

	}
	
	
	public static double arrAvg(int[] arr) { //Array is the parameter
		int sum = 0;
		for (int i = 0; i<arr.length; i++) {
			sum += arr[i]; //For each iteration, add to the sum.	
		}
		double avg = sum / arr.length;
		return avg;
	}

}
