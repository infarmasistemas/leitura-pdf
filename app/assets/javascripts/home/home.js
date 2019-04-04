function getBase64(file) {
   var reader = new FileReader();

   reader.readAsDataURL(file);
   reader.onload = function () {
   	document.getElementById('base64').value = reader.result;
   	$("#teste").submit();
   };
   reader.onerror = function (error) {
     console.log('Error: ', error);
   };
}

function sendFile(){
	var file = document.querySelector('input[type="file"]').files[0];
	getBase64(file);
}