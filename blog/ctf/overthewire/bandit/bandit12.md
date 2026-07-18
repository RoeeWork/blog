---
layout: post
title: "bandit12"
---

18-07-2026
17:23

![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718172326.png' | relative_url }})

im guessing they want us to unhex(?) the dump untill we find the flag.

but first lets make the tmp directory and copy the data file to it:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718172902.png' | relative_url }})

taking a look at the command `xxd` we see:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718173121.png' | relative_url }})
great! ill just use `xxd -r`:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718173638.png' | relative_url }})

the instructions also mention that the file has been repeatedly compressed. so i'll also take a look at the man pages for `tar`:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718173817.png' | relative_url }})
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718173834.png' | relative_url }})

after some research:
- compression is a method which makes a file smaller.
- an archive file is a single file that contains multiple other files.

although i did know that, i had confused the two concepts together. the instructions specifically mentioned *compression*, not archiving.

taking a look at the man pages for `file`:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718175548.png' | relative_url }})

ill use this to find the actual compression type:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718175635.png' | relative_url }})

so it's `gzip` compression, ill take a look at its man pages: ![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718175756.png' | relative_url }})
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718175844.png' | relative_url }})
so ill change the file from `.tar` to `.gz`:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718175957.png' | relative_url }})

looking for decompression in the `gzip` man pages:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718180033.png' | relative_url }})

decompressing:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718180142.png' | relative_url }})
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718180205.png' | relative_url }})
as the instructions say, the file has been compressed multiple times, so ill check the file type again:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718180311.png' | relative_url }})

now its using bzip2 compression, taking a look at the man pages for `bzip2`:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718180408.png' | relative_url }})
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718180535.png' | relative_url }})

ill first try out `bzcat`:![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718180644.png' | relative_url }})

ill also try to use `bzip2 -d`:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718180756.png' | relative_url }})

great, ill check the file type again:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718180844.png' | relative_url }})

its using gzip compression, so ill exctract it:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718181229.png' | relative_url }})
seems like theres a file name coming together.

using `file` again:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718181349.png' | relative_url }})

now its a `tar` archive, ill rename it and extract using `tar -x`:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718181518.png' | relative_url }})
a new file has popped up! repeating the proccess:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718181752.png' | relative_url }})

data8.bin seems to be gzip compressed data, so decompress:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260718182010.png' | relative_url }})

lessgooooo
that was a long one

flag: `qQYQiHOBPR8zR61qxYqX45quvihF2uzk`