---
layout: post
title: "natas21"
---

03-09-2026
15:35

login:

![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260903153555.png' | relative_url }})
sourcecode:
``` php
function print_credentials() { /* {{{ */
    if($_SESSION and array_key_exists("admin", $_SESSION) and $_SESSION["admin"] == 1) {
    print "You are an admin. The credentials for the next level are:<br>";
    print "<pre>Username: natas22\n";
    print "Password: <censored></pre>";
    } else {
    print "You are logged in as a regular user. Login as an admin to retrieve credentials for natas22.";
    }
}
/* }}} */

session_start();
print_credentials();
```

in order to print the flag for this level, we need to set the admin flag to 1.

the site is colocated with this "CSS STYLE EXPERIMENTER":
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260903153613.png' | relative_url }})
sourcecode:
``` php

session_start();

// if update was submitted, store it
if(array_key_exists("submit", $_REQUEST)) {
    foreach($_REQUEST as $key => $val) {
    $_SESSION[$key] = $val;
    }
}

if(array_key_exists("debug", $_GET)) {
    print "[DEBUG] Session contents:<br>";
    print_r($_SESSION);
}

// only allow these keys
$validkeys = array("align" => "center", "fontsize" => "100%", "bgcolor" => "yellow");
$form = "";

$form .= '<form action="index.php" method="POST">';
foreach($validkeys as $key => $defval) {
    $val = $defval;
    if(array_key_exists($key, $_SESSION)) {
    $val = $_SESSION[$key];
    } else {
    $_SESSION[$key] = $val;
    }
    $form .= "$key: <input name='$key' value='$val' /><br>";
}
$form .= '<input type="submit" name="submit" value="Update" />';
$form .= '</form>';

$style = "background-color: ".$_SESSION["bgcolor"]."; text-align: ".$_SESSION["align"]."; font-size: ".$_SESSION["fontsize"].";";
$example = "<div style='$style'>Hello world!</div>";

```

the vulnerable part of the code is at the first few lines:
``` php
session_start();

// if update was submitted, store it
if(array_key_exists("submit", $_REQUEST)) {
    foreach($_REQUEST as $key => $val) {
    $_SESSION[$key] = $val;
    }
}
```
there is no check for the validity of the keys before they are stored, so we could potentially inject whatever key we wanted. and since the site is "colocated" with the one which has the print_credentials() function, we could use that in order to manipulate the admin key:

![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260903155347.png' | relative_url }})

we can just inject the admin flag like so:![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260903155541.png' | relative_url }})
its important that we remove the `Content-Length` header before sending the packet, since we changed the length of the data being sent in the packet. burpsuite will automatically add the correct `Content-Length` value after sending the packet.
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260903155808.png' | relative_url }})

then, we will send a packet to the original site with the injected sessions `PHPSESSID`:
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260903160502.png' | relative_url }})![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260903160631.png' | relative_url }})

flag: 964laB0r7TuDqJj5b3HFtwsQoc0GhjBF