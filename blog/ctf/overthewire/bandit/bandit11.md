---
layout: post
title: "bandit11"
---

18-07-2026
15:31

![]({{ '/ctf/overthewire/bandit/' . 'Pasted%20image%2020260718153208.png' | relative_url }})

so its a caesar cipher, it says its called ROT13:
![]({{ '/ctf/overthewire/bandit/' . 'Pasted%20image%2020260718153440.png' | relative_url }})

looking at wikipedia:
![]({{ '/ctf/overthewire/bandit/' . 'Pasted%20image%2020260718154001.png' | relative_url }})

great, so now we just need to replace the characters a-m (also A-M) to N-Z.

the next command overthewire gives us is the `tr` command, lets take a look:
![]({{ '/ctf/overthewire/bandit/' . 'Pasted%20image%2020260718154131.png' | relative_url }})

i dont understand this man page, is it that:

`STRING1 = ARRAY1`
and
`STRING2 = ARRAY2`

so that both of these strings represent arrays that control the action? if so that wording is kind of confusing.
![]({{ '/ctf/overthewire/bandit/' . 'Pasted%20image%2020260718155732.png' | relative_url }})
i guess thats it?
![]({{ '/ctf/overthewire/bandit/' . 'Pasted%20image%2020260718155801.png' | relative_url }})

so i cant really find anything about adding sequences together so ill just google it.
also couldnt find anything about this in tutorials, so stack overflow it is!

![]({{ '/ctf/overthewire/bandit/' . 'Pasted%20image%2020260718160331.png' | relative_url }})
great, so you just fucking addem together - great syntax man

![]({{ '/ctf/overthewire/bandit/' . 'Pasted%20image%2020260718160419.png' | relative_url }})
so fucking annoying

flag: `GROozWPO8QyN0mGrjUkID0WCYkZiQxrN`