<?php

require 'db_connect.inc.php';

$response=array();//Array to hold JSON information

$connect=mysqli_connect(DB_HOST,DB_USERNAME,DB_PASSWORD,DB_NAME);

if(mysqli_connect_errno()){
    //Not connected
    $response['success']=0;
    $response['message']="Cannot connect with MySql:".mysqli_connect_errno();
    //echo "Cannot connect with MySql:". mysqli_connect_errno();
    echo json_encode($response);
}else{
  //Successfully connected
  if (isset($_POST['user_id']) && isset($_POST['survey_id']) && isset($_POST['question1']) && isset($_POST['answer1']) && isset($_POST['question2']) && isset($_POST['answer2']) && isset($_POST['question3']) && isset($_POST['answer3'])
  && isset($_POST['question4']) && isset($_POST['answer4'])) {
    $user_id=$_POST['user_id'];
    $survey_id=$_POST['survey_id'];
    $question1=$_POST['question1'];
    $question2=$_POST['question2'];
    $question3=$_POST['question3'];
    $question4=$_POST['question4'];

    $answer1=$_POST['answer1'];
    $answer2=$_POST['answer2'];
    $answer3=$_POST['answer3'];
    $answer4=$_POST['answer4'];

    if(!empty($user_id) && !empty($survey_id) && !empty($question1) && !empty($question2) && !empty($question3) && !empty($question4) && !empty($answer1) && !empty($answer2) && !empty($answer3) && !empty($answer4)){
      $check_user_id="SELECT * FROM `users` WHERE `ID`='$user_id'";
      $check_user_id_run=mysqli_query($connect,$check_user_id);
      if(mysqli_fetch_assoc($check_user_id_run)){
        //user id verified
        $check_survey_id="SELECT * FROM `survey` WHERE `ID`='$survey_id'";
        $check_survey_id_run=mysqli_query($connect,$check_survey_id);
        if(mysqli_fetch_assoc($check_survey_id_run)){
          //survey id verified
          //die($insert_answers3);
          $insert_answers1="insert into `answers` values('$user_id','$question1','$answer1')";
          $insert_answers2="insert into `answers` values('$user_id','$question2','$answer2')";
          $insert_answers3="insert into `answers` values('$user_id','$question3','$answer3')";
          $insert_answers4="insert into `answers` values('$user_id','$question4','$answer4')";

          $insert_answers1_run=mysqli_query($connect,$insert_answers1);

          /*if(mysqli_fetch_assoc($insert_answers1_run)){
            //1st inserted
            $response['success']=1;
            $response['message']="Inserted Answer 1";
          }else{
            $response['success']=0;
            $response['message']="Cannot insert Answer 1";
          }*/

          $insert_answers2_run=mysqli_query($connect,$insert_answers2);
          $insert_answers3_run=mysqli_query($connect,$insert_answers3);
          $insert_answers4_run=mysqli_query($connect,$insert_answers4);
          $response['success']=10;
          $response['message']="Successfully Submitted Answers";
          echo json_encode($response);

          $insert_survey_completed="insert into `user_surveys` values('$survey_id','$user_id',CURRENT_TIMESTAMP)";
          $insert_survey_completed_run=mysqli_query($connect,$insert_survey_completed);

          //echo "Cannot connect with MySql:". mysqli_connect_errno();
        }else{
          //survey id not verified
          $response['success']=0;
          $response['message']="Survey ID is incorrect";
          echo json_encode($response);
        }
      }else {
        $response['success']=3;
        $response['message']="Cannot verify your User ID\nPlease login again";
        echo json_encode($response);
      }
    }else{
      $response['success']=0;
      $response['message']="Field cannot be empty";
      echo json_encode($response);
    }
  }
}
mysqli_close($connect);
?>

<form action="submitanswers.php" method="post">
  User ID:<br><input type="text" name="user_id" maxlength="33"><br><br>
  Survey ID:<br><input type="text" name="survey_id" maxlength="33"><br><br>

  Question 1:<br><input type="text" name="question1" maxlength="33"><br><br>
  Answer 1:<br><input type="text" name="answer1" maxlength="33"><br><br>

  Question 2:<br><input type="text" name="question2" maxlength="33"><br><br>
  Answer 2:<br><input type="text" name="answer2" maxlength="33"><br><br>

  Question 3:<br><input type="text" name="question3" maxlength="33"><br><br>
  Answer 3:<br><input type="text" name="answer3" maxlength="33"><br><br>

  Question 4:<br><input type="text" name="question4" maxlength="33"><br><br>
  Answer 4:<br><input type="text" name="answer4" maxlength="33"><br><br>

  <input type="Submit" name="submit" value="Submit">
</form>
