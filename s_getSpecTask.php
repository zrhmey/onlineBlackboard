<?php 
	include("db_connection.php");

	$username = $_GET['username'];
	$subject_id = $_GET['subject_id'];

	$group_count = 0;
	$indiv_count = 0;
	$announcement_count = 0;
	$quiz_count = 0;

	$total_count = 0;

	$getStudent = $dbconn->query("SELECT * from student where username = '$username' ");
	$stu = mysqli_fetch_array($getStudent);
	$studentId = $stu['student_id'];
	// echo $studentId;

	$getGroupAssignment = "SELECT count(*) from group_assignment where student_id = '$studentId' and opened = 'false' and subject_id = '$subject_id' group by subject_id ";
	$getGroupAssignment_connect = mysqli_query($dbconn, $getGroupAssignment);
	$group_count = mysqli_num_rows($getGroupAssignment_connect);

	$getIndivAssignment = "SELECT count(*) from individual_assignment where student_id = '$studentId' and opened = 'false' and assignment_id <> '0' and subject_id = '$subject_id' group by subject_id";
	$getIndivAssignment_connect = mysqli_query($dbconn, $getIndivAssignment);
	$indiv_count = mysqli_num_rows($getIndivAssignment_connect);

	$assignment_graded = "SELECT count(*) from graded_assignment where student_id = '$studentId' and graded = 'true' and opened = 'false' and subject_id = '$subject_id' group by subject_id ";
	$assignment_graded_connect = mysqli_query($dbconn, $assignment_graded);
	$graded_count = mysqli_num_rows($assignment_graded_connect);

	$getAnnouncement = "SELECT count(*) from see_announcement where student_id = '$studentId' and opened = 'false' and subject_id = '$subject_id' group by subject_id ";
	$getAnnouncement_connect = mysqli_query($dbconn, $getAnnouncement);
	$announcement_count = mysqli_num_rows($getAnnouncement_connect);

	$getQuiz = "SELECT count(*) from see_quiz where student_id = '$studentId' and opened = 'false' and subject_id = '$subject_id' group by subject_id ";
	$getQuiz_connect = mysqli_query($dbconn, $getQuiz);
	$quiz_count = mysqli_num_rows($getQuiz_connect);	

	$total_count = $indiv_count + $group_count + $graded_count + $announcement_count + $quiz_count;

	if ($total_count != 0) {
		if ($group_count != 0) {
			while ($row = mysqli_fetch_row($getGroupAssignment_connect)) {
	?>
				<a style='margin-bottom: 0;'>
	<?php
				echo "<strong>".$row[0]."</strong> new group assignment/s.";
				echo "</a>";
				echo "<br>";
			}
		}

		if ($indiv_count != 0) {
			while ($row2 = mysqli_fetch_row($getIndivAssignment_connect)) {
	?>
				<a style='margin-bottom: 0;'>
	<?php
				echo "<strong>".$row2[0]."</strong> new individual assignment/s.";
				echo "</a>";
				echo "<br>";
			}
		}
		
		if ($graded_count != 0) {
			while ($row3 = mysqli_fetch_row($assignment_graded_connect)) {
	?>
				<a style='margin-bottom: 0;'>
	<?php
				//echo $group_count;
				echo "<strong>".$row3[0]."</strong> newly graded assignment/s.";
				echo "</a>";
				echo "<br>";
			}
		}

		if ($quiz_count != 0) {
			while ($row5 = mysqli_fetch_row($getQuiz_connect)) {
	?>
				<a style='margin-bottom: 0;'>
	<?php
				//echo $group_count;
				echo "<strong>".$row5[0]."</strong> new quiz/zes.";
				echo "</a>";
				echo "<br>";
			}
		}

		if ($announcement_count != 0) {
			while ($row4 = mysqli_fetch_row($getAnnouncement_connect)) {
	?>
				<a style='margin-bottom: 0;'>
	<?php
				//echo $group_count;
				echo "<strong>".$row4[0]."</strong> unseen announcement/s.";
				echo "</a>";
				echo "<br>";
			}
		}


		echo "||";
		echo "!";
	} else {
		echo "<p style='margin-bottom: 0; font-weight: bold;' >No new notification.</p>";

		echo "||";
		echo "";
	}

?>