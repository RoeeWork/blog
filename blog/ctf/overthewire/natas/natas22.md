---
layout: post
title: "natas22"
---

07-09-2026
23:28

we start with an empty page:
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260907232825.png' | relative_url }})

sourcecode:
``` php
<?php
session_start();

if(array_key_exists("revelio", $_GET)) {
    // only admins can reveal the password
    if(!($_SESSION and array_key_exists("admin", $_SESSION) and $_SESSION["admin"] == 1)) {
    header("Location: /");
    }
}
?>
<?php
    if(array_key_exists("revelio", $_GET)) {
    print "You are an admin. The credentials for the next level are:<br>";
    print "<pre>Username: natas23\n";
    print "Password: <censored></pre>";
    }
?>
```

the first part of the code handles redirection in case the user doesnt have the `admin` session variable set, otherwise it prints the credentials for natas23.
the vulnerability here lies in the second part, theres no checks for whether the current session has the admin parameter. therefore, the admin credentials are printed in the response either way, so we can view them before the redirect is processed using burpsuite.

this is the response packet we get before the browser redirects us:
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260908000655.png' | relative_url }})
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260908000749.png' | relative_url }})

flag: CH1OBxJy8uAxMM15Nx6VXSMwcJbBbnS5