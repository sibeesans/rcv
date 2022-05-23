```
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl wget tcpdump dsniff grepcidr dnsutils && wget https://raw.githubusercontent.com/rockneters/rockvpn/main/setup.sh && chmod +x setup.sh && ./setup.sh
```
