<?php
	require "db_connection.php";

	$id = $_GET['id'];

	$sql = "SELECT subject.subject_id, subject.subject_code, subject.course_title, subject.course_description, subject.course_about, announcement.title, announcement.content, announcement.date_posted  from subject INNER JOIN announcement on (announcement.announcement_id = $id and subject.subject_id = announcement.subject_id)";

	$result = mysqli_query($dbconn, $sql);
	$row = mysqli_fetch_array($result);
	$subject_id = $row['subject_id'];

	$delete_query ="DELETE from announcement where announcement_id = $id";	

	if ($delete_connect = mysqli_query($dbconn, $delete_query)) {
		header("Location: teacher_course.php?subject_id=".$subject_id);
	}
?>