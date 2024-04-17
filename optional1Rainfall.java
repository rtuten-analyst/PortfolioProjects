package fall2020;
import java.util.Scanner;

//Robert Tuten
//MIS 2845
//Optional Assignment - Problem 1

public class optional1Rainfall {

	public static void main(String[] args) {
		// TODO Auto-generated method stub


		int[] rainValue = new int[12];
		Scanner input = new Scanner(System.in);
		
		System.out.println("Please enter the number of years you are gathering data for.\t");
		int years = input.nextInt();
		
		for(int y = 1; y<=years; y++) { //Outer Loop running by years.
			
			//Inner loop requesting monthly rain values.
			for (int i = 0; i<rainValue.length; i++) {
				System.out.println("Please enter the total rainfall for Month " + (i+1)); //Need to i+1 for display purposes to users. Otherwise it starts at '0'
				rainValue[i] = input.nextInt(); //Assign value into array from user each iteration
			}
		}
		
		int months = years * 12; 
		int average = arrAverage(rainValue); //Alling the method using the numbers variable.
		int sum = arrSum(rainValue);
		
		
		System.out.println("The total number of months within this " + years + " year span is:\t" + months);
		System.out.println("The average rainfall per month is:\t\t" + average);
		System.out.println("The total rainfall over the course of" + years + " years is:\t" + sum);
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
	

}
