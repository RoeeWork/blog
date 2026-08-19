---
layout: post
title: "basic 6"
---

17-08-2026
20:18

![]({{ '/ctf/hackthissite/pics/Pasted%20image%2020260817201818.png' | relative_url }})

input "abcde" into the encryption:
![]({{ '/ctf/hackthissite/pics/Pasted%20image%2020260817201854.png' | relative_url }})

so abcde becomes acegi, looks like the index of the characters are added to the ascii value. ill write a small script to decode this:
![]({{ '/ctf/hackthissite/pics/Pasted%20image%2020260817202821.png' | relative_url }})
![]({{ '/ctf/hackthissite/pics/Pasted%20image%2020260817202842.png' | relative_url }})lets check "86920863" in the encryption program:
![]({{ '/ctf/hackthissite/pics/Pasted%20image%2020260817202925.png' | relative_url }})
that matches the encrypted password
![]({{ '/ctf/hackthissite/pics/Pasted%20image%2020260817203001.png' | relative_url }})

flag: 86920863