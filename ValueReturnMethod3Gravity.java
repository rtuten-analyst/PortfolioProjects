package fall2020;

public class ValueReturnMethod3Gravity {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		System.out.println("We wish to calculate the distance of an object when it falls within a specific time period!");
		

//Calculating the distance of an object for every second up to 10 seconds.
		
		for(int i = 1; i<=10; i++) {
			double distance = fallingDistance(i);
			System.out.println("The object falls " + distance + " meters in " + i + " second(s).");
			
		}
		
		
		
		
	}
/////////////////////////////////
//Method Area:
	
	
	public static double fallingDistance(double t) {
		double g = 9.8; //This is gravity. Declared here because... it don't really change.
		double result;
		result = ( g * Math.pow(t, 2) * 0.5);
		
		return result;
	
	}
	
	
	
	
	
	
	
	
}
