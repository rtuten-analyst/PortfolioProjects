package fall2020;
import java.lang.reflect.Array;
import java.util.Scanner;

//Robert Tuten
//Assignment 7 - Rainfall

public class assign7RainFall {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		int[] rainValue = new int[12];
		Scanner input = new Scanner(System.in);

		
		for (int i = 0; i<rainValue.length; i++) {
			System.out.println("Please enter the total rainfall for Month " + (i+1)); //Need to i+1 for display purposes to users. Otherwise it starts at '0'
			rainValue[i] = input.nextInt(); //Assign value into array from user each iteration
		}
		int average = arrAverage(rainValue); //Alling the method using the numbers variable.
		int sum = arrSum(rainValue);
		int max = max(rainValue);
		int min = min(rainValue);
		System.out.println("The average of the elements from this Rainfall array is:\t" + average);
		System.out.println("The total sum of the elements from this Rainfall array is:\t" + sum);
		System.out.println("The minimum value of the elements from this Rainfall array is:\t" + min);
		System.out.println("The maximum value of the elements from this Rainfall array is:\t" + max);
		
		
	}

	
	public static int arrSum(int[] set) {
		int sum = 0;
		for (int i = 0; i<set.length; i++) {
			sum+= set[i];
		}
		return sum;
	}
	
	public static int arrAverage(int[] set) {
		int sum = 0;
		for (int i = 0; i<set.length; i++) {
			sum+= set[i];
		}
		int average = sum / set.length;
		return average;
	}
	

	
	public static int min(int[] set) {
		int minimum = -999;
		
		for(int i=0; i<set.length; i++) {
			if (minimum == -999) {
				minimum = set[i];
			}else if(set[i] < minimum) {
				minimum = set[i];
			}

		}
		return minimum;
	}
	
	public static int max(int[] set) {
		int maximum = -999;
		
		for(int i=0; i<set.length; i++) {
			if (maximum == -999) {
				maximum = set[i];
			}else if(set[i] > maximum) {
				maximum = set[i];
			}

		}
		return maximum;
	}
	
	
}
