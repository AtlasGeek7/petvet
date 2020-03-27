
sendBtn = document.getElementById('sendbtn')
msg = document.getElementById('msg')
//msgbox = document.getElementById('msgbox')

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

function fetchdata(path,target){
  //alert('ok')
  //send an ajax request to our action
  $.ajax({
    //url: "/users/chat_history",
    url: path,
    //serialize the form and use it as data for our ajax request
    data: $(this).serialize(),
    //the type of data we are expecting back from server, could be json too
    dataType: "html",
    success: function(data) {
      //if our ajax request is successful, replace the content of our viz div with the response data
      // $("#msgbox").html("<p>" + $( "#msg" ).val() + "</p>" + data);
      //$("#msgbox").html(data)
      $(target).html(data)
    }
  });
}

$(document).ready(function(){
 setInterval(fetchdata,10000);
});
