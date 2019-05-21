function s_getSpecTask(username, subject_id) {
	setInterval(function() {
		xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				// document.getElementById("newMessages").innerHTML = this.responseText;
				var responseArray = xmlhttp.responseText.split("||");
				document.getElementById("newTask").innerHTML = responseArray[0];
				console.log(responseArray[1]);
				document.getElementById("checkTask").innerHTML = responseArray[1];
			}
		};
		xmlhttp.open("GET", "s_getSpecTask.php?username=" + username + "&subject_id=" + subject_id, true);
		xmlhttp.send();
	}, 1111);
}