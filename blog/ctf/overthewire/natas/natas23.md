---
layout: post
title: "natas23"
---

08-09-2026
00:13
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260908001323.png' | relative_url }})

alas! a login page.

sourcecode:
``` php
    if(array_key_exists("passwd",$_REQUEST)){
        if(strstr($_REQUEST["passwd"],"iloveyou") && ($_REQUEST["passwd"] > 10 )){
            echo "<br>The credentials for the next level are:<br>";
            echo "<pre>Username: natas24 Password: <censored></pre>";
        }
        else{
            echo "<br>Wrong!<br>";
        }
    }
    // morla / 10111
```

phps type juggling allows treating a string prefixed with a number (i.e "33hello") as a number when used with a conditional operator. meaning we can just use "11iloveyou" as the password, and both conditions will be met:
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260908002846.png' | relative_url }})

flag: shlL4BvOtawNCd81dwdKRHFzmTEjYYQX