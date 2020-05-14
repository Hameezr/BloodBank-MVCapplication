var btn_login_value = 0, btn_signin_value = 0;
var btn_donor_value = 0, btn_reciever_value = 0, btn_bloodbank_value = 0;
var btn_donor = document.getElementById("btn_div_donor");
var btn_reciever = document.getElementById("btn_div_reciever");
var btn_bloodbank = document.getElementById("btn_div_bloodbank");
var div_login_receiver = document.getElementById("div_login_receiver");
var div_login_bloodbank = document.getElementById("div_login_bloodbank");


var div_login = document.getElementById("div_login");
var div_signin_donor = document.getElementById("div_signin_donor");
var div_signin_reciever = document.getElementById("div_signin_reciever");
var div_signin_bloodbank = document.getElementById("div_signin_bloodbank");

function openlogindiv() {
    var menulogin = document.getElementById("btn_login_menue");
    var menusignin = document.getElementById("btn_signin_menue");
    var btn_div_login = document.getElementById("btn_div_login");
    var btn_div_signin = document.getElementById("btn_div_signin");
    var divloginsignin = document.getElementById("div_login_signin");
    //div_login.style.display = "block";
    //div_login.style.display = "block";

    /////

    
    if (btn_login_value === 0) {

        //set login div on display
        menulogin.style.backgroundColor = "red";
        menulogin.style.color = "#a80000";
        divloginsignin.style.display = "block";
        btn_login_value = 1;


        //style="background-color:white;color:#a80000;border-radius:10px;margin:2px"
        btn_div_login.style.backgroundColor = "white";
        btn_div_login.style.color = "#a80000";

        //remove sigin in div in case it was already present there
        btn_signin_value = 0;
        //there is problem in section below upto line no 50
        menusignin.style.backgroundColor = "#a80000";
        btn_div_signin.style.color = "white";
        btn_div_signin.style.backgroundColor = "#a80000";
        div_signin_reciever.style.display = "none";

        div_signin_bloodbank.style.display = "none";
        div_signin_donor.style.display = "none";


        //////////
        //get priviously selected reciver/donor/bloodbank
        if (btn_donor_value === 0 && btn_reciever_value === 0 && btn_bloodbank_value === 0)
            btn_reciever_value = 1;
        if (btn_donor_value === 1) {

            div_login_receiver.style.display = "none";
            btn_reciever.style.backgroundColor = "#a80000";
            btn_reciever.style.color = "white";


            div_login.style.display = "block";
            btn_donor.style.backgroundColor = "white";
            btn_donor.style.color = "#a80000";

            div_login_bloodbank.style.display = "none";
            btn_bloodbank.style.backgroundColor = "#a80000";
            btn_bloodbank.style.color = "white";


        } else if (btn_reciever_value === 1) {
            div_login_receiver.style.display = "block";
            btn_reciever.style.backgroundColor = "white";
            btn_reciever.style.color = "#a80000";


            div_login.style.display = "none";
            btn_donor.style.backgroundColor = "#a80000";
            btn_donor.style.color = "white";

            div_login_bloodbank.style.display = "none";
            btn_bloodbank.style.backgroundColor = "#a80000";
            btn_bloodbank.style.color = "white";

        } else {

            div_login_receiver.style.display = "none";
            btn_reciever.style.backgroundColor = "#a80000";
            btn_reciever.style.color = "white";


            div_login.style.display = "none";
            btn_donor.style.backgroundColor = "#a80000";
            btn_donor.style.color = "white";

            div_login_bloodbank.style.display = "block";
            btn_bloodbank.style.backgroundColor = "white";
            btn_bloodbank.style.color = "#a80000";

        }

    }
    else {
        //remove it from display

        menulogin.style.backgroundColor = "#a80000";//"#a80000";
        menulogin.style.color = "white";

        divloginsignin.style.display = "none";
        btn_login_value = 0;
    }

}



function opensignindiv() {
    var menusignin = document.getElementById("btn_signin_menue");
    var menulogin = document.getElementById("btn_login_menue");
    var btn_div_login = document.getElementById("btn_div_login");
    var btn_div_signin = document.getElementById("btn_div_signin");
    var divloginsignin = document.getElementById("div_login_signin");
    //btn_signin_value = 1;
    if (btn_signin_value === 0) {
        //intialize showing div
        btn_login_value = 0;
        btn_signin_value = 1;
        menusignin.style.backgroundColor = "red";
        div_login.style.display = "none";

        divloginsignin.style.display = "block";

        btn_div_login.style.backgroundColor = "#a80000";
        btn_div_login.style.color = "white";
        menulogin.style.backgroundColor = "#a80000";
        btn_login_value = 0;

        btn_div_signin.style.backgroundColor = "white";
        btn_div_signin.style.color = "#a80000";

        div_login.style.display = "none";
        div_login_receiver.style.display = "none";
        div_login_bloodbank.style.display = "none";


        //////////
        //get priviously selected reciver/donor/bloodbank
        if (btn_donor_value === 0 && btn_reciever_value === 0 && btn_bloodbank_value === 0)
            btn_reciever_value = 1;
        if (btn_donor_value === 1) {

            div_signin_reciever.style.display = "none";
            btn_reciever.style.backgroundColor = "#a80000";
            btn_reciever.style.color = "white";


            div_signin_donor.style.display = "block";
            btn_donor.style.backgroundColor = "white";
            btn_donor.style.color = "#a80000";

            div_signin_bloodbank.style.display = "none";
            btn_bloodbank.style.backgroundColor = "#a80000";
            btn_bloodbank.style.color = "white";


        } else if (btn_reciever_value === 1) {
            div_signin_reciever.style.display = "block";
            btn_reciever.style.backgroundColor = "white";
            btn_reciever.style.color = "#a80000";


            div_signin_donor.style.display = "none";
            btn_donor.style.backgroundColor = "#a80000";
            btn_donor.style.color = "white";

            div_signin_bloodbank.style.display = "none";
            btn_bloodbank.style.backgroundColor = "#a80000";
            btn_bloodbank.style.color = "white";

        } else {

            div_signin_reciever.style.display = "none";
            btn_reciever.style.backgroundColor = "#a80000";
            btn_reciever.style.color = "white";


            div_signin_donor.style.display = "none";
            btn_donor.style.backgroundColor = "#a80000";
            btn_donor.style.color = "white";

            div_signin_bloodbank.style.display = "block";
            btn_bloodbank.style.backgroundColor = "white";
            btn_bloodbank.style.color = "#a80000";

        }
    }
    else {
        divloginsignin.style.display = "none";
        menusignin.style.backgroundColor = "#a80000";
        btn_signin_value = 0;

    }
    //alert("function called");

}

// <button id="btn_div_donor" value="0" onclick="divdonor()" style="background-color:#a80000;border-radius:10px;border-color:#a80000;color:ghostwhite;margin:2px;">Donor</button>
//<button id="btn_div_reciever" value="0" onclick="divreciever()" style="background-color:#a80000;border-radius:10px;border-color:#a80000;color:ghostwhite;margin:2px;">Reciever</button>
//    <button id="btn_div_bloodbank" value="0" onclick="divbloodbank()" 

function divdonor() {
    btn_donor_value = 1;
    btn_reciever_value = 0;
    btn_bloodbank_value = 0;

    //change buttons color
    btn_donor.style.backgroundColor = "white";
    btn_donor.style.color = "#a80000";

    btn_reciever.style.backgroundColor = "#a80000";
    btn_reciever.style.color = "white";

    btn_bloodbank.style.backgroundColor = "#a80000";
    btn_bloodbank.style.color = "white";

    //change div
    if (btn_signin_value === 1) {
        //change to signdiv
        div_signin_donor.style.display = "block";
        div_signin_reciever.style.display = "none";
        div_signin_bloodbank.style.display = "none";

    } else {
        //change to login div
        div_login.style.display = "block";
        div_login_receiver.style.display = "none";
        div_login_bloodbank.style.display = "none";

    }
}

function divreciever() {
    btn_donor_value = 0;
    btn_reciever_value = 1;
    btn_bloodbank_value = 0;

    //change buttons colors
    btn_donor.style.backgroundColor = "#a80000";
    btn_donor.style.color = "white";

    btn_reciever.style.backgroundColor = "white";
    btn_reciever.style.color = "#a80000";

    btn_bloodbank.style.backgroundColor = "#a80000";
    btn_bloodbank.style.color = "white";

    //change div
    if (btn_signin_value === 1) {
        //change to signdiv
        div_signin_donor.style.display = "none";
        div_signin_reciever.style.display = "block";
        div_signin_bloodbank.style.display = "none";


    } else {
        //change to login div
        div_login.style.display = "none";
        div_login_receiver.style.display = "block";
        div_login_bloodbank.style.display = "none";

    }


}

function divbloodbank() {
    btn_donor_value = 0;
    btn_reciever_value = 0;
    btn_bloodbank_value = 1;

    //change buttons colors
    btn_donor.style.backgroundColor = "#a80000";
    btn_donor.style.color = "white";

    btn_reciever.style.backgroundColor = "#a80000";
    btn_reciever.style.color = "white";

    btn_bloodbank.style.backgroundColor = "white";
    btn_bloodbank.style.color = "#a80000";

    //change div
    if (btn_signin_value === 1) {
        //change to signdiv
        div_signin_donor.style.display = "none";
        div_signin_reciever.style.display = "none";
        div_signin_bloodbank.style.display = "block";


    } else {
        //change to login div
        div_login.style.display = "none";
        div_login_receiver.style.display = "none";
        div_login_bloodbank.style.display = "block";
    }

}

function opensdiv() {
    btn_signin_value = 0;
    btn_reciever_value = 1;
    opensignindiv();
}

function closediv() {

    var menulogin = document.getElementById("btn_login_menue");
    var menusignin = document.getElementById("btn_signin_menue");
    var btn_div_login = document.getElementById("btn_div_login");
    var btn_div_signin = document.getElementById("btn_div_signin");
    var divloginsignin = document.getElementById("div_login_signin");
    divloginsignin.style.display = "none";
    menusignin.style.backgroundColor = "#a80000";
    menulogin.style.backgroundColor = "#a80000";
    btn_login_value = 0;
    btn_signin_value = 0;
}


var donorcheck = function () {
    // alert("im called")
    if (document.getElementById("pwd_d").value === document.getElementById("cpwd_d").value) {
        document.getElementById("m_donor").style.color = "green";
        document.getElementById("m_donor").innerHTML = "Matching";
        document.getElementById("s_d").disabled = false;
    }
    else {
        // alert("im in else")
        document.getElementById("m_donor").style.color = "red";
        document.getElementById("m_donor").innerHTML = "Not matching";
        document.getElementById("s_d").disabled = true;
    }

}

function recievercheck() {
    // alert("im called")
    if (document.getElementById("pwd_r").value === document.getElementById("cpwd_r").value) {
        document.getElementById("m_reciever").style.color = "green";
        document.getElementById("m_reciever").innerHTML = "Matching";
        document.getElementById("s_r").disabled = false;
    }
    else {
        // alert("im in else")
        document.getElementById("m_reciever").style.color = "red";
        document.getElementById("m_reciever").innerHTML = "Not matching";
        document.getElementById("s_r").disabled = true;
    }
}

var bloodbankcheck = function () {
    if (document.getElementById("pwd_b").value === document.getElementById("cpwd_b").value) {
        document.getElementById("m_bloodbank").style.color = "green";
        document.getElementById("m_bloodbank").innerHTML = "Matching";
        document.getElementById("s_b").disabled = false;
    }
    else {
        // alert("im in else")
        document.getElementById("m_bloodbank").style.color = "red";
        document.getElementById("m_bloodbank").innerHTML = "Not matching";
        document.getElementById("s_b").disabled = true;
    }

}
//////////////////////////
