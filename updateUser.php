<?php
include "config.php";
$name=$_POST['name'];
$email=$_POST['email'];
$id=$_POST['id'];
if($name!=""&&$email!=""){
$sql="update users set name='$name',email='$email' where id=$id;";
if($con->query($sql)){
echo "true";
}else
{echo "false";}
}
?>