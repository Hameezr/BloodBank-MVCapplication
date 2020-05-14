

function checkcniclen(cnic, password) {

    if (cnic.value.length != 13 || isNaN(cnic.value)) {
        alert("cnic not valid");

        cnic.value = "";
        return false;
    }
    if (password.value.length < 7 || password.value.length > 16) {
        alert("Password not valid");
        password.value = "";
        return false;
    }

    return true;
}
function checkpasslen(password) {
    var y = password;
}
function myfunc2(oldCnic1) {
    var x = document.getElementById("hey1").value;
    //  document.getElementById("hey3").innerHTML = x;
    if (x.length != 13) {
        document.getElementById("hey3").innerHTML = String(oldCnic1);
    }
    else {
        var id = x.document.getElementById("hey1"); //if you want to pass an Id parameter
        });
            window.location.href = 'Url.Action("updateCnic", "Home",{oldCnic= oldCnic1,newCnic=x})';
       // updateCnic(x, oldCnic1);
        // Url.Action("updateCnic", "Home", new { newcnic=x, old)
        ///    window.location.href = "/Home/updateCnic";
    }
}
function myfunc() {

    document.getElementById("hey1").style.visibility = 'visible';
    document.getElementById("hey2").style.visibility = 'visible';
    //  document.getElementById("demo1")


}

function openForm() {
    document.getElementById("myForm").style.display = "block";
}

function closeForm() {
    document.getElementById("myForm").style.display = "none";
}