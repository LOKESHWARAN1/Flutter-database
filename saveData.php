<?php
include "config.php";
$name=$_POST['name'];
$email=$_POST['email'];
if($name!=""&&$email!=""){
$sql="insert into users (name,email) values('$name','$email');";
if($con->query($sql)){
echo "true";
}else
{echo "false";}
}
?>