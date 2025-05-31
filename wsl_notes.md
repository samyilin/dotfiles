# Why

Windows is such a pain to work with when it comes to WSL. A part of the
reason is because WSL2 is a virtual machine, so network/internet access
becomes a problem, especially when under corporate network.

I have 1 alias called "netowrk" in .bash_aliases that address the DNS
forwarding problem in corporate network, but still has SSL certification
problem when using Git (Git itself or package managers who use git) or
anything that uses opensssl.Here's the actual fix, don't disable SSL globally
to try to fix this:

[Reference](https://stackoverflow.com/questions/72167566/wsl-docker-curl-60-ssl-certificate-problem-unable-to-get-local-issuer-certi) here:
Basically:

1. run certmgr.msc. There's no easy way to get at it other than use "run" command.
2. go to Trusted Root Certification Authorities\Certifiactes
3. Find entries here that has certificate template of "CA"
4. Export them to a folder using DER coded x.509, call it whatever.
   cert.cer for example.
5. Use the below code:

```bash
openssl x509 -inform DER -in /mnt/d/cert.cer -out ./eset.crt
```

If under Ubuntu, do

```bash
sudo cp eset.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
```

If under [Arch](https://wiki.archlinux.org/title/User:Grawity/Adding_a_trusted_CA_certificate), do

```bash
sudo trust anchor --store ~/cert.crt
```
