package fall2020;

public class ValueReturnMethod4OddEven {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		System.out.println("Are 1,2,3 all even numbers?\t" + allEven(1,2,3));
		System.out.println("Are 2,4,6 all even numbers?\t" + allEven(2,4,6));
		System.out.println("Are 3,5,7 all even numbers?\t" + allEven(3,5,7));
	}
	
	
	
	
	
	
	public static boolean allEven(int a, int b, int c) {
		boolean result = false; //default value for now.
		if (a%2==0 && b%2==0 && c%2==0) {
			result = true;
		}else
			result = false;
			
		return result;
	}
	

}
