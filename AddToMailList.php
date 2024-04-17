<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"> 
		<title>Thank You</title>
</head>

<body>
<?php
	$firstname=$_POST['firstname'];
	$lastname=$_POST['lastname'];
	$phonenumber=$_POST['phonenumber'];
	$email=$_POST['email'];
	$date=$_POST['date'];
	$marital=$_POST["marital"];
	$planet=$_POST['planet'];

	$html_string = "<h3>Thank You Message</h3><p>Dear $firstname $lastname:<br><br>
		Sapling Homes Management has forwarded a message from $date to you. It reads,<br><br><tab>
		''Thank you for joining our mailing list! We welcome all citizens from the planet $planet. You're absolutely interstellar for making this far!<br><br>
			PS: Is your $email email even working!? Message back sometime!!''</p>";

	//Echo to verify what was sent
echo"<!DOCTYPE html><html><head><meta charset='utf-8'> <title>Thank You</title>";
echo"</head><body>";
echo"<h3> Thank you for Joining Our Mailing List!</h3>";
echo"<p>This is the information you entered:</p><table>";
echo"<tr><td>First Name: </td><td>$firstname</td></tr>";
echo"<tr><td>Last Name: </td><td>$lastname</td></tr>";
echo"<tr><td>Phone Number: </td><td>$phonenumber</td></tr>";
echo"<tr><td>Email Address: </td><td>$email</td></tr>";
echo"<tr><td>Date: </td><td>$date</td></tr>";
echo"<tr><td>Marital Status: </td><td>$marital</td></tr>";
echo"<tr><td>Planet: </td><td>$planet</td></tr></table></body></html>";

//Customized 'Thank You' message using variables.

echo "$html_string";

    




    $dbconnect = mysqli_connect ("localhost", "root", "")
        or die("Unable to connect to MySQL");

    $selected = mysqli_select_db ($dbconnect, "webdata")
        or die ("Could not open database");

    $esc_firstname= mysqli_real_escape_string($dbconnect, $_POST['firstname']);
    $esc_lastname= mysqli_real_escape_string($dbconnect, $_POST['lastname']);
    $esc_phonenumber= mysqli_real_escape_string($dbconnect, $_POST['phonenumber']);
    $esc_email= mysqli_real_escape_string($dbconnect, $_POST['email']);
    $esc_date= mysqli_real_escape_string($dbconnect, $_POST['date']);
    $esc_marital= mysqli_real_escape_string($dbconnect, $_POST['marital']);
    $esc_planet= mysqli_real_escape_string($dbconnect, $_POST['planet']);

    $sql= "INSERT INTO mailinglist VALUES ('$esc_firstname', '$esc_lastname', '$esc_phonenumber', '$esc_email', '$esc_date', '$esc_marital', '$esc_planet')";

    mysqli_query($dbconnect, $sql);
    mysqli_close($dbconnect);

		?>

</body>
</html>