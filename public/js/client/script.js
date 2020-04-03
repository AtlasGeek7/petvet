var statusTimer = null
var msgTimer = null

sendBtn = document.getElementById('sendbtn')
msg = document.getElementById('msg')
//msgbox = document.getElementById('msgbox')

function validateAuth(){
  // alert('ok')
  //send an ajax request to our action
  $.ajax({
    url: "/users/validation",
    //url: path,
    //serialize the form and use it as data for our ajax request
    data: $(this).serialize(),
    //the type of data we are expecting back from server, could be json too
    dataType: "html",
    success: function(data) {
      //if our ajax request is successful, replace the content of our viz div with the response data
      // $("#msgbox").html("<p>" + $( "#msg" ).val() + "</p>" + data);
      // alert($("#msgbox").contents().length)
      $("#msgbox").html(data)
      //$(target).html(data)
    }
  });
}


function validateFileUp(id) {
  var id = id.split('-')[1]
  var ele = document.getElementById("imgBtn-"+id)
  if (ele.value != '') {
    document.getElementById("upBtn"+id).disabled = false
  }
  }


//sendBtn.addEventListener("click", function(e){
  //e.preventDefault()
  //fetchdata()
  //alert('OK')
//});

//function senddata() {
  //fetchdata()
//}

function range(arr, start, end) {
    var ans = []
    for (let i = start; i <= end; i++) {
        ans.push((arr.split(''))[i])
    }
    return ans.join('')
}


//function delPet(id){
  //$.ajax({
  //  url: '/users/:id/home#about/delete/' + id,
  //  type: 'DELETE',
  //  success: function(data) {
    //  location.reload();
  //  }
//  })
//}

//function fetchdata(path,target){




function postMsg() {
  if ($('#msg').val().replace(new RegExp(' ', 'g'),'')  != '') {
    cid = $('#cid').html()
    $.post("/users/chat_history",
    {
      message: $('#msg').val(),
      cid: cid
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

function getMsg() {
//  alert(' getMsg()')
    $.get("/users/chat_history", function(data, status){
      if (status == 'success') {
        // alert("\nStatus: " + status);
        $("#msgbox").html(data)
      } else {
        alert("failed!")
      }
    });
}

function getStatus() {
    $.get("/users/employees_status", function(data, status){
      if (status == 'success') {
        // alert(data);
        $("#statusBox").css("display","block")
        $("#statusBox").html(data)
      } else {
        alert("failed!")
      }
    });
}



function chatInit(ecid) {
    $("#innerStatusBox").css("display","none")
  ecid = ecid.split('-')[1]
  // alert(ecid)
  $.post("/users/chat_init",
  {
    ecid: ecid
  },
  function(data,status){
    // alert("Data: " + data + "\nStatus: " + status);
  //  $("#msgbox").html(data)
  });
//  setInterval(getMsg,10000)
  // tik = setTimeout(toggleStatus, 3000, ecid)
  // alert($('#cidBtn'+cid).attr("value"))
  // $('#cidBtn'+cid).html(cid)
  // $('#msg').val('')
}

$(document).ready(function(){
  // alert($("#msgbox").contents().length)
//  if ($("#msgbox").contents().length > 3 ) {
    //setInterval(fetchdata,10000);
    $('#msg').keypress(function(event) {

        if (event.keyCode == 13) {
            event.preventDefault();
        }
    });

  //}
   statusTimer = setInterval(getStatus,10000)
   msgTimer = setInterval(getMsg,10000)
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


var addPetBtn = document.getElementById("addPetBtn")
var mainDiv = document.getElementById("main")
var addPetDiv = document.getElementById("addPet")
var sndBtn = null
var editBtn = null
var fld = null
var petInf = null
function frmOn(id) {
  fld = document.getElementById("fld"+id)
  sndBtn = document.getElementById("sndBtn"+id)
  editBtn = document.getElementById("editBtn"+id)
  petInf = document.getElementById("petInf"+id)
  if (editBtn.innerText  == "Edit") {
    editBtn.innerText  = "Cancel"
    fld.disabled = false
    sndBtn.style.visibility = 'visible'

  }	else {
    editBtn.innerText  = "Edit"

    petInf.reset()
    fld.disabled = true
    sndBtn.style.visibility = 'hidden'
  }
}

function petfrmOn(idx) {

  for (let i=0; i<idx ; i++) {
    document.getElementById("petInf"+i).reset()
    document.getElementById("fld"+i).disabled = true
    document.getElementById("sndBtn"+i).style.visibility = 'hidden'
    document.getElementById("editBtn"+i).innerText  = "Edit"
  }
  // mainDiv.style.visibility = 'hidden'
  // addPetDiv.style.visibility = 'visible'

//  petfrm.style.visibility = 'visible'


}

function petfrmOff(idx) {
  mainDiv.style.visibility = 'visible'
  addPetDiv.style.visibility = 'hidden'
  petfrm.style.visibility = 'hidden'
  //petInf.style.visibility = 'visible'
  //petfrm.style.top = '-800px';
  //frm.style.top = '0px';
}

function upfrmOn(id) {
  var id = id.split('-')[1]
  var ele = document.getElementById("fileUp"+id)
  if (ele.style.display == 'block') {
    ele.style.display = 'none'
  } else {
    ele.style.display = 'block'
  }
}


var usrfrm = document.getElementById("usrfrm")
var petfrm  = document.getElementById("petfrm")

function dispPetfrm() {
  var usrfrm = document.getElementById("usrfrm")
  var petfrm  = document.getElementById("petfrm")
  usrfrm.style.display = 'none'
  petfrm.style.display = 'block'
  $("#petFrmBtn").css({ top: '0px' });
}

function dispUsrfrm() {
  var usrfrm = document.getElementById("usrfrm")
  var petfrm  = document.getElementById("petfrm")
  usrfrm.style.display = 'block'
  petfrm.style.display = 'none'
}



function dispAddPet(){
  $("#addPet").slideDown("slow")
   $("#petfrm").css({ top: '-415px' });

  $("#petfrm").css("display","block")
}

function hideAddPet(){
  $("#addPet").slideUp("slow")
  // $("#petfrm").css("display","block")
}

function dispEditRev() {
  $("#editRev").css({ top: '-500px' });
  $("#editRev").css({ zIndex: '10' });
}

function cancEditRev() {
  $("#editRev").css({ top: '100px' });
  $("#editRev").css({ zIndex: '-1' });
}

function delRev() {
  var r = confirm("Your review will be deleted. Proceed anyway?");
  if (r == true) {
      $.post("/review/delete", function(data,status){
        if (status == 'success') {
          // alert("\nStatus: " + status);

           // alert("Done!")
           $("#load-page-1").css("display","block")
          setTimeout(function()
          {
            location.reload();
          }, 3000);
        //  $("#revfrm").trigger("reset");
        //  dispEditRev()
        } else {
          alert("Oops... failed!")
        }
      });
    }
  }

  function cancAppt() {
    var r = confirm("Your appointment will be deleted. Proceed anyway?");
    if (r == true) {
        $.post("/appointment/cancel", function(data, status){
          if (status == 'success') {
            $("#load-page-2").css("display","block")
            setTimeout(function()
            {
              location.reload();
            }, 3000);
          } else {
            alert("Oops... failed!")
          }
        });
      }
  }


  function exit() {
    clearInterval(statusTimer)
    clearInterval(msgTimer)
    alert('Thanks for using our portal!')
  }
