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
  if (isset($_POST['user_id']) && isset($_POST['survey_id'])) {
    $user_id=$_POST['user_id'];
    $survey_id=$_POST['survey_id'];
    if(!empty($user_id) && !empty($survey_id)){
      $check_user_id="SELECT * FROM `users` WHERE `ID`='$user_id'";
      $check_user_id_run=mysqli_query($connect,$check_user_id);
      if(mysqli_fetch_assoc($check_user_id_run)){
        //User id verified
        $check_survey_id="SELECT * FROM `survey` WHERE `id`='$survey_id'";
        $check_survey_id_run=mysqli_query($connect,$check_survey_id);
        if(mysqli_fetch_assoc($check_survey_id_run)){
          //survey id verified
          //fetch question here
          $response['success']=1;
          $response['data']=array();

          $fetch_question="select `id`,`question` from `questions` where `survey_id`='$survey_id'";
          $fetch_question_run=mysqli_query($connect,$fetch_question);
          while($question_query_array=mysqli_fetch_assoc($fetch_question_run)){
            $question['id']=$question_query_array['id'];
            $question['question']=$question_query_array['question'];
            $question['options']=array();
            $question_id=$question['id'];
            $fetch_options="select `id`,`option` from `options` where `questions_id`='$question_id'";
            //die($fetch_options);
            $fetch_options_run=mysqli_query($connect,$fetch_options);
            while($options_query_array=mysqli_fetch_assoc($fetch_options_run)){
              $option['id']=$options_query_array['id'];
              $option['option']=$options_query_array['option'];
              array_push($question['options'],$option);
            }
            array_push($response['data'],$question);
          }
          echo json_encode($response);
        }else {
          //survey id not verified
          $response['success']=0;
          $response['message']="Cannot verify Survey ID";
          echo json_encode($response);
        }
      }else {
        //user id not verified
        $response['success']=3;
        $response['message']="Cannot verify your User ID\nPlease login again and try to take quiz again";
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

<form action="fetchquestions.php" method="post">
  User ID:<br><input type="text" name="user_id" maxlength="33"><br><br>
  Survey ID:<br><input type="text" name="survey_id" maxlength="33"><br><br>
  <input type="Submit" name="submit" value="Submit">
</form>
