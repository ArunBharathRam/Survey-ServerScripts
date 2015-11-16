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
        //user id verified
        $check_survey_id="SELECT * FROM `survey` WHERE `ID`='$survey_id'";
        $check_survey_id_run=mysqli_query($connect,$check_survey_id);
        if(mysqli_fetch_assoc($check_survey_id_run)){
          //survey id verified
          $fetch_survey="select survey.`id`,organization.`name`,survey.`organization_id`,survey.`title`,survey.`instructions` FROM `survey`,`organization` WHERE survey.`id`='$survey_id' AND survey.`organization_id`=organization.`id` ";
          $fetch_survey_run=mysqli_query($connect,$fetch_survey);
          if($query_array=mysqli_fetch_assoc($fetch_survey_run)){
            //fetched data for survey
            $response['success']=1;
            $response['survey_id']=$survey_id;
            $response['organization_id']=$query_array['organization_id'];
            $response['organization_name']=$query_array['name'];
            $response['title']=$query_array['title'];
            $response['instructions']=$query_array['instructions'];

            $check_user_took_survey="select * from `user_surveys` where `survey_id`='$survey_id' and `user_id`='$user_id'";
            $check_user_took_survey_run=mysqli_query($connect,$check_user_took_survey);
            if(mysqli_fetch_assoc($check_user_took_survey_run)){
              //user took survey
              $response['already_taken']="true";
            }else {
              //user did not take survey
              $response['already_taken']="false";
            }
            echo json_encode($response);
          }else {
            //cannot fetch data for survey
            $response['success']=0;
            $response['message']="Cannot fetch data for survey";
            echo json_encode($response);
          }
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

<form action="choosesurvey.php" method="post">
  User ID:<br><input type="text" name="user_id" maxlength="33"><br><br>
  Survey ID:<br><input type="text" name="survey_id" maxlength="33"><br><br>
  <input type="Submit" name="submit" value="Submit">
</form>
