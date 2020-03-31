var msgTimer = null

  function getMsg() {
  //  alert('getMsg()')
      $.get("/employee/chat_history", function(data, status){
        if (status == 'success') {
          // alert("\nStatus: " + status);
          // alert(data)
          $("#msgbox").html(data)
        //  alert($("#msgbox").contents().length)
          if ($("#msgbox").contents().length > 3 ) {
            $("#statusToggler").prop("checked", true)
            $("#chatOn").css("display","block")
            updateStatus()
          } else {
            $("#statusToggler").prop("checked", false)
            $("#chatOn").css("display","none")
            updateStatus()
          }
        } else {
          alert("failed!")
        }
      });
  }

//  var  tik = setInterval(getMsg,10000)

function updateStatus() {
  var ele = document.getElementById("statusToggler")
  var cmd = ''
  // If the checkbox is checked, display the output text
  if (ele.checked == true){
    cmd = '0'
  } else {
    cmd = '1'
    let data = "<p><span id='date'>Welcome to Live Chat!</p>"
    $("#msgbox").html(data)
    setTimeout(chatOff, 7000)
  }

function chatOff() {

  $("#chatOn").css("display","none")

}



  //if ($('#msg').val().replace(new RegExp(' ', 'g'),'')  != '') {
  //  cid = $('#cid').html()
    $.post("/employee/update_status",
    {
      cmd: cmd
    },
    function(data,status){
      // alert("Data: " + data + "\nStatus: " + status);
    //  $("#msgbox").html(data)
    });
  //  $('#msg').val('')
//  } else {
//    alert("No empty messages, please!")
//    }
}

function postMsg() {
  if ($('#msg').val().replace(new RegExp(' ', 'g'),'')  != '') {

    $.post("/employee/chat_history",
    {
      message: $('#msg').val(),
    },
    function(data,status){
      // alert("Data: " + data + "\nStatus: " + status);
      $("#msgbox").html(data)
    });
    $('#msg').val('')
  } else {
    alert("No empty messages, please!")
    }
}




$(document).ready(function(){

  // alert($("#msgbox").contents().length)
//  if ($("#msgbox").contents().length > 3 ) {
    //setInterval(fetchdata,10000);
    //alert('?')
    $('#msg').keypress(function(event) {

        if (event.keyCode == 13) {
            event.preventDefault();
        }
    });

//  }
  msgTimer = setInterval(getMsg,10000)
  // setInterval(getStatus,10000)
  // alert($('#cidBtn').attr("value"))
  //  setInterval(alert($('#cidBtn').attr("value")),10000)
});

function showSignUp() {
  document.getElementById("signUpDiv").style.zIndex  = "10"
  document.getElementById("signInDiv").style.zIndex  = "-1"
}

function showSignIn() {
  document.getElementById("signUpDiv").style.zIndex  = "-1"
  document.getElementById("signInDiv").style.zIndex  = "10"
}


//window.addEventListener('beforeunload', function (e) {
  // Cancel the event
  //e.preventDefault(); // If you prevent default behavior in Mozilla Firefox prompt will always be shown
  // Chrome requires returnValue to be set
  //alert('Bye!')
  //e.returnValue = '';
//});


function exit() {
  clearInterval(msgTimer)
  alert('Thanks for using our portal!')
}
