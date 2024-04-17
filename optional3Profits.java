package fall2020;
import java.util.Scanner;

//Robert Tuten
//Optional Assignment - Problem 3 Profit/Loss
//MIS 2845

public class optional3Profits {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Scanner input = new Scanner(System.in);
		

		
		System.out.println("Please enter the Number of Shares:\t");
			int ns = input.nextInt(); //nShares
		
		System.out.println("Please enter the Purchase Price per Share:\t");
			int pp = input.nextInt(); //pPrice
		
		System.out.println("Please enter the Purchase Commission Paid::\t");
			int pc = input.nextInt(); //pCommission
		
		System.out.println("Please enter the Sales Price per Share:\t");
			int sp = input.nextInt(); //sPrice
			
		System.out.println("Please enter the Sale Commission Paid:\t");
			int sc = input.nextInt(); //sCommission
			
			
		int formula = stocks(ns, pp, pc, sp, sc); //Call the 'stock' method and set the answer to 'formula'.
		
		
		//Determine if the value implies profit, loss, or neither.
		if (formula > 0) {
			System.out.println("From the sale of stock(s), there has been a GAIN of:\t" + formula);			
		}else if(formula == 0){
			System.out.println("\"From the sale of stock(s), there was neither a GAIN nor a LOSS:\t" + formula);
		}else {
			System.out.println("From the sale of stock(s), there has been a LOSS of:\t" + formula);
		}
		

		
		
	}
	
	
	
	
	public static int stocks(int nShares, int pPrice, int pCommission, int sPrice, int sCommission) {
		
		int profit = (((nShares * sPrice) - sCommission) - ((nShares * pPrice) + pCommission));
		
	return profit;
	}
	

}
