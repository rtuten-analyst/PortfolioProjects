package fall2020;
import java.util.Scanner;

public class EncloseString {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner input = new Scanner(System.in);
		System.out.println("Please enter your message:\t");
		String userMessage = input.nextLine();
		
		System.out.print("Please enter your key");
		int userKey = input.nextInt();
		
		String secretMessage = encode(userMessage, userKey); //First arguement, string we want to encode. Second arguement, how many values we want to shift characters
		System.out.println(secretMessage);
		
		/*Please enter your message:	
				Monday is a holiday!
		Please enter your key1
				Npoebz!jt!b!ipmjebz" 
				^^ Notice it's simply shifting to the next letter when the value is 1. So m -> n, o -> p, n -> o, d -> e

		 */
		
		
		
		/*
		String message = "Monday is a Holiday!";
		String encodeMessage = ""; //Just used to store the message.
		
		for(int i = 0; i<message.length(); i++) {
			char c = message.charAt(i);//1. identify the character.
			c++;//2. shift the value by 1.
			encodeMessage += c;//3. attach character to new string. (Store encoded message)
		}
		System.out.println(encodeMessage);
		*/
		
		
		
		
		
		
		
		
		
	}
	
	public static String encode(String message, int key) {
		String encodeMessage = "";
		for(int i = 0; i<message.length(); i++) {
			char c = message.charAt(i);//1. identify the character.
			c+= key;//2. shift the value by 1.
			encodeMessage += c;//3. attach character to new string. (Store encoded message)
		}
		return encodeMessage;
	}

}
