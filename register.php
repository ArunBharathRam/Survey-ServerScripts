<?php

require 'db_connect.inc.php';

$response=array();//Array to hold json information

$connect=mysqli_connect(DB_HOST,DB_USERNAME,DB_PASSWORD,DB_NAME);

if(mysqli_connect_errno()){
  //Not connected
  $response['success']=0;
  $response['message']="Cannot connect with MySql :".mysqli_connect_errno();
  //echo "Cannot connect with MySql:". mysqli_connect_errno();
  echo json_encode($response);
}else{
  //Successfully connected
  if (isset($_POST['name']) && isset($_POST['email']) && isset($_POST['password'])) {
    $name=$_POST['name'];
    $email=$_POST['email'];
    $password=$_POST['password'];
    if(!empty($name) && !empty($email) && !empty($password)){
      $password=md5($password);
      $query="SELECT * FROM `users` WHERE `email`='$email' LIMIT 1";
      $query_run=mysqli_query($connect,$query);
      if(mysqli_fetch_assoc($query_run)){
        $response['success']=0;
        $response['message']="email has already been registered.";
        //echo "email has already been registered";
        echo json_encode($response);
      }else {
        $query="INSERT INTO `users` (`id`, `name`, `password`, `email`, `last_login`) VALUES (NULL, '$name','$password','$email',CURRENT_TIMESTAMP)";
        $query_run=mysqli_query($connect,$query);
        if($query_run){
          $response['success']=1;
          $response['message']="Your Account has been created.You can login using your email";
          $subject="Survey Application Account Created";
          $message="Registration Successful !"."\r\n"."Your account has been created."."\r\n"."You can log in to your account using your email and your password.";
          $headers='From: Survey Application'."\r\n".'Reply-To: jm.prathab@gmail.com'."\r\n";
          $message = wordwrap($message, 70, "\r\n");
          mail($email,$subject,$message,$headers);
          //echo "Your Account has been created.You can login using your email";
          echo json_encode($response);
          }else{
            $response['success']=0;
            $response['message']="Oops!...Details cannot be added into Database.Try again later.";
            //echo "Details cannot be added into Database";
            echo json_encode($response);
            die();
          }
        }
      }else{
        $response['success']=0;
        $response['message']="Fields cannot be empty.";
        //echo "Fields Cannot be empty";
        echo json_encode($response);
      }
    }
  mysqli_close($connect);
}
?>
<form  action="register.php" method="post">
  Name:<br><input type="text" name="name" maxlength="80"><br><br>
  email:<br><input type="text" name="email" maxlength="80"><br><br>
  Password:<br><input type="password" name="password" maxlength="40"><br><br>
  <input type="Submit" name="submit" value="Submit">
</form>
