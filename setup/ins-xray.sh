#!/bin/bash
# XRay Installation
# Mod by Rocknet Store
# ==================================
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$(curl -sS https://raw.githubusercontent.com/sibeesans/rcv/main/ip | awk '{print $4}' | grep $MYIP )
if [[ $MYIP = $IZIN ]]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Please Contact Admin!!"
rm -f ins-xray.sh
exit 0
fi  
clear

domain=$(cat /etc/xray/domain)

# // Make Main Directory
mkdir -p /usr/local/xray/

# // Installation XRay Core
wget -q -O /usr/local/xray/xray "https://raw.githubusercontent.com/rockneters/rockvpn/main/core/xray" 
wget -q -O /usr/local/xray/geosite.dat "https://raw.githubusercontent.com/rockneters/rockvpn/main/addon/geosite.dat"
wget -q -O /usr/local/xray/geoip.dat "https://raw.githubusercontent.com/rockneters/rockvpn/main/addon/geoip.dat"
chmod +x /usr/local/xray/xray

# // Make XRay Mini Root Folder
mkdir -p /etc/xray/
chmod 775 /etc/xray/


cat > /etc/systemd/system/xr-vm-tls.service << EOF
[Unit]
Description=XRay TLS Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/vmesstls.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/xr-vm-ntls.service << EOF
[Unit]
Description=XRay NTLS Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/vmessnone.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/xr-vm-mk.service << EOF
[Unit]
Description=XRay MKCP Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/mkcp.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/xr-vl-tls.service << EOF
[Unit]
Description=XRay VLess TLS Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/vlesstls.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/xr-vl-ntls.service << EOF
[Unit]
Description=XRay VLess NTLS Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/vlessnone.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/xtls.service << EOF
[Unit]
Description=XRay XTLS Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/xrayxtls.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/x-tr.service << EOF
[Unit]
Description=XRay Trojan Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/trojan.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/vm-grpc.service << EOF
[Unit]
Description=XRay VMess GRPC Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/vm-grpc.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

wget https://raw.githubusercontent.com/rockneters/rockvpn/main/setup/plugin-xray.sh && chmod +x plugin-xray.sh && ./plugin-xray.sh
rm -f /root/plugin-xray.sh
service squid start
uuid=$(cat /proc/sys/kernel/random/uuid)
password="$(tr -dc 'a-z0-9A-Z' </dev/urandom | head -c 16)"
cat > /etc/xray/vmesstls.json <<END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 8443,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
#tls
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        },
        "tcpSettings": {
          "path": "/xray",
          "headers": {
            "Host": ""
          }
         },
        "quicSettings": {},
        "sockopt": {
          "mark": 0,
          "tcpFastOpen": true
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "domain": "$domain"
    }
  ],
  "outbounds": [
    {
      "tag": "IP4_out",
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag": "IP6_out",
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "UseIPv6"
      }
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "outboundTag": "IP6_out",
        "domain": [
          "geosite:netflix"
        ]
      },
      {
        "type": "field",
        "outboundTag": "IP4_out",
        "network": "udp,tcp"
      },
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      }
    ]
  }
}
END
cat > /etc/xray/vmessnone.json <<END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 80,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
#none
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "tcpSettings": {
          "path": "/xray",
          "headers": {
            "Host": ""
          }
         },
        "quicSettings": {},
        "sockopt": {
          "mark": 0,
          "tcpFastOpen": true
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "domain": "$domain"
    }
  ],
  "outbounds": [
    {
      "tag": "IP4_out",
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag": "IP6_out",
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "UseIPv6"
      }
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "outboundTag": "IP6_out",
        "domain": [
          "geosite:netflix"
        ]
      },
      {
        "type": "field",
        "outboundTag": "IP4_out",
        "network": "udp,tcp"
      },
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      }
    ]
  }
}
END
cat > /etc/xray/vlesstls.json <<END
{
  "log": {
    "access": "/var/log/xray/access2.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 6565,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
#tls
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        },
        "tcpSettings": {
          "path": "/xray",
          "headers": {
            "Host": ""
          }
         },
        "quicSettings": {},
        "sockopt": {
          "mark": 0,
          "tcpFastOpen": true
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "domain": "$domain"
    }
  ],
  "outbounds": [
    {
      "tag": "IP4_out",
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag": "IP6_out",
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "UseIPv6"
      }
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "outboundTag": "IP6_out",
        "domain": [
          "geosite:netflix"
        ]
      },
      {
        "type": "field",
        "outboundTag": "IP4_out",
        "network": "udp,tcp"
      },
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      }
    ]
  }
}
END
cat > /etc/xray/vlessnone.json <<END
{
  "log": {
    "access": "/var/log/xray/access2.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 6666,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
#none
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "tcpSettings": {
          "path": "/xray",
          "headers": {
            "Host": ""
          }
         },
        "quicSettings": {},
        "sockopt": {
          "mark": 0,
          "tcpFastOpen": true
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "domain": "$domain"
    }
  ],
  "outbounds": [
    {
      "tag": "IP4_out",
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag": "IP6_out",
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "UseIPv6"
      }
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "outboundTag": "IP6_out",
        "domain": [
          "geosite:netflix"
        ]
      },
      {
        "type": "field",
        "outboundTag": "IP4_out",
        "network": "udp,tcp"
      },
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      }
    ]
  }
}
END
cat > /etc/xray/xrayxtls.json << END
{
  "log": {
    "access": "/var/log/xray/access1.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 756,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "flow": "xtls-rprx-direct"
#XRay
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "dest": 60000,
            "alpn": "",
            "xver": 1
          },
          {
            "dest": 60001,
            "alpn": "h2",
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "minVersion": "1.2",
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
END
cat> /etc/xray/mkcp.json << END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 6161,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
#mkcp
          }
        ]
      },
      "streamSettings": {
        "network": "kcp",
        "security": "none",
        "tlsSettings": {},
        "tcpSettings": {},
        "httpSettings": {},
        "kcpSettings": {
          "mtu": 1350,
          "tti": 50,
          "uplinkCapacity": 100,
          "downlinkCapacity": 100,
          "congestion": false,
          "readBufferSize": 2,
          "writeBufferSize": 2,
          "header": {
            "type": "dtls"
          }
        },
        "wsSettings": {},
        "quicSettings": {}
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "domain": "$domain"
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
END

cat > /etc/xray/trojan.json <<END
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": 2089,
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password":"dev",
                        "email": ""
#xray-trojan
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "tls",
                "tlsSettings": {
                    "alpn": [
                        "http/1.1"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/etc/xray/xray.crt",
                            "keyFile": "/etc/xray/xray.key"
                        }
                    ]
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
END

cat > /etc/xray/vmessgrpc.json << END
{
    "log": {
            "access": "/var/log/xray/access5.log",
        "error": "/var/log/xray/error.log",
        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 3480,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}"
#vmessgrpc
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "gun",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "${domain}",
                    "alpn": [
                        "h2"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/etc/xray/xray.crt",
                            "keyFile": "/etc/xray/xray.key"
                        }
                    ]
                },
                "grpcSettings": {
                    "serviceName": "GunService"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        }
    ]
}
END

cat > /etc/xray/vlessgrpc.json << END
{
    "log": {
            "access": "/var/log/xray/access5.log",
        "error": "/var/log/xray/error.log",
        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 880,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}"
#vlessgrpc
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "gun",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "${domain}",
                    "alpn": [
                        "h2"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/etc/xray/xray.crt",
                            "keyFile": "/etc/xray/xray.key"
                        }
                    ]
                },
                "grpcSettings": {
                    "serviceName": "GunService"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        }
    ]
}
END

cat > /etc/xray/trojangrpc.json << END
{
  "log": {
    "access": "/var/log/xray/access3.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 2099,
      "protocol": "trojan",
      "settings": {
        "clients": [
          {
            "password": "${uuid}",
            "email": ""
#xray-trojan-grpc
                    }
                ]
            },
            "streamSettings": {
                "network": "gun",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "${domain}",
                    "alpn": [
                        "h2",
                        "http/1.1"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/etc/xray/xray.crt",
                            "keyFile": "/etc/xray/xray.key"
                        }
                    ]
                },
                "grpcSettings": {
                    "serviceName": "GunService"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        }
    ]
}
            
END

cat > /etc/xray/trojanxtls.json << END
{
  "log": {
    "access": "/var/log/xray/access3.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 2088,
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                "password":"${uuid}",
                "flow": "xtls-rprx-direct",
                "level": 0
#trojan-xtls
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "minVersion": "1.2",
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}

END
cat > /etc/systemd/system/vmess-grpc.service << EOF
[Unit]
Description=XRay VMess GRPC Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/vmessgrpc.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/vless-grpc.service << EOF
[Unit]
Description=XRay VMess GRPC Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/vlessgrpc.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/trojangrpc.service << EOF
[Unit]
Description=XRay Trojan GRPC Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/trojangrpc.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/trojanxtls.service << EOF
[Unit]
Description=XRay Trojan XTLS Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray/xray -config /etc/xray/trojanxtls.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 6565-j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 6565-j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 6161 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 6262 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 6060 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 6060 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 6161 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 6262 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 6666 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 6666 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2089 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2089 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 3480 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 3480 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 3880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 3880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2099 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2099 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2088 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2088 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload
systemctl enable xr-vm-tls.service
systemctl start xr-vm-tls.service
systemctl enable xr-vm-ntls.service
systemctl start xr-vm-ntls.service
systemctl enable xr-vm-mk.service
systemctl start xr-vm-mk.service
systemctl enable xr-vl-tls.service
systemctl start xr-vl-tls.service
systemctl enable xr-vl-ntls.service
systemctl start xr-vl-ntls.service
systemctl restart xtls.service
systemctl enable xtls.service
systemctl enable x-tr
systemctl start x-tr 
systemctl enable vmess-grpc
systemctl restart vmess-grpc
systemctl enable vless-grpc
systemctl restart vless-grpc
systemctl enable trojangrpc
systemctl restart trojangrpc
systemctl enable trojanxtls
systemctl restart trojanxtls

cd /usr/bin

wget -O addxvmess "https://raw.githubusercontent.com/rockneters/rockvpn/main/add/addxv2ray.sh"
wget -O addxvless "https://raw.githubusercontent.com/rockneters/rockvpn/main/add/addxvless.sh"
wget -O addxtrojan "https://raw.githubusercontent.com/rockneters/rockvpn/main/add/addxtrojan.sh"
wget -O addxtls "https://raw.githubusercontent.com/rockneters/rockvpn/main/add/addxtls.sh"
wget -O addgrpc "https://raw.githubusercontent.com/rockneters/rockvpn/main/add/addxvgrpc.sh"
wget -O addtrxtls "https://raw.githubusercontent.com/rockneters/rockvpn/main/add/addtrxtls.sh"
wget -O addtrgrpc "https://raw.githubusercontent.com/rockneters/rockvpn/main/add/addtrojangrpc.sh"
wget -O delxvmess "https://raw.githubusercontent.com/rockneters/rockvpn/main/del/delxv2ray.sh"
wget -O delxvless "https://raw.githubusercontent.com/rockneters/rockvpn/main/del/delxvless.sh"
wget -O delxtrojan "https://raw.githubusercontent.com/rockneters/rockvpn/main/del/delxtrojan.sh"
wget -O delxtls "https://raw.githubusercontent.com/rockneters/rockvpn/main/del/delxtls.sh"
wget -O delgrpc "https://raw.githubusercontent.com/rockneters/rockvpn/main/del/delgrpc.sh"
wget -O deltrxtls "https://raw.githubusercontent.com/rockneters/rockvpn/main/del/deltrxtls.sh"
wget -O deltrgrpc "https://raw.githubusercontent.com/rockneters/rockvpn/main/del/deltrgrpc.sh"
wget -O cekxvmess "https://raw.githubusercontent.com/rockneters/rockvpn/main/cek/cekxvmess.sh"
wget -O cekxvless "https://raw.githubusercontent.com/rockneters/rockvpn/main/cek/cekxvless.sh"
wget -O cekxtrojan "https://raw.githubusercontent.com/rockneters/rockvpn/main/cek/cekxtrojan.sh"
wget -O cekxtls "https://raw.githubusercontent.com/rockneters/rockvpn/main/cek/cekxray.sh"
wget -O cekgrpc "https://raw.githubusercontent.com/rockneters/rockvpn/main/cek/cekgrpc.sh"
wget -O cektrxtls "https://raw.githubusercontent.com/rockneters/rockvpn/main/cek/cektrxtls.sh"
wget -O cektrgrpc "https://raw.githubusercontent.com/rockneters/rockvpn/main/cek/cektrgrpc.sh"
wget -O renewxvmess "https://raw.githubusercontent.com/rockneters/rockvpn/main/renew/renewxv2ray.sh"
wget -O renewxvless "https://raw.githubusercontent.com/rockneters/rockvpn/main/renew/renewxvless.sh"
wget -O renewxtrojan "https://raw.githubusercontent.com/rockneters/rockvpn/main/renew/renewxtrojan.sh"
wget -O renewxtls "https://raw.githubusercontent.com/rockneters/rockvpn/main/renew/renewxtls.sh"
wget -O renewgrpc "https://raw.githubusercontent.com/rockneters/rockvpn/main/renew/renewgrpc.sh"
wget -O renewtrxtls "https://raw.githubusercontent.com/rockneters/rockvpn/main/renew/renewtrxtls.sh"
wget -O renewtrgrpc "https://raw.githubusercontent.com/rockneters/rockvpn/main/renew/renewtrgrpc.sh"
wget -O trialxvmess "https://raw.githubusercontent.com/rockneters/rockvpn/main/trial/trialxvmess.sh"
wget -O trialxvless "https://raw.githubusercontent.com/rockneters/rockvpn/main/trial/trialxvless.sh"
wget -O trialxtrojan "https://raw.githubusercontent.com/rockneters/rockvpn/main/trial/trialxtrojan.sh"
wget -O trialgrpc "https://raw.githubusercontent.com/rockneters/rockvpn/main/trial/trialgrpc.sh"
wget -O trialtrxtls "https://raw.githubusercontent.com/rockneters/rockvpn/main/trial/trialtrxtls.sh"
wget -O trialtrgrpc "https://raw.githubusercontent.com/rockneters/rockvpn/main/trial/trialtrgrpc.sh"

chmod +x addxvmess
chmod +x addxvless
chmod +x addxtrojan
chmod +x addxtls
chmod +x addgrpc
chmod +x addtrxtls
chmod +x addtrgrpc
chmod +x delxvless
chmod +x delxvmess
chmod +x delxtrojan
chmod +x delxtls
chmod +x delgrpc
chmod +x deltrxtls
chmod +x deltrgrpc
chmod +x cekxvmess
chmod +x cekxvless
chmod +x cekxtrojan
chmod +x cekxtls
chmod +x cekgrpc
chmod +x cektrxtls
chmod +x cektrgrpc
chmod +x renewxvmess
chmod +x renewxvless
chmod +x renewxtrojan
chmod +x renewxtls
chmod +x renewgrpc
chmod +x renewtrxtls
chmod +x renewtrgrpc
chmod +x trialxvmess
chmod +x trialxvmess
chmod +x trialgrpc
chmod +x trialtrxtls
chmod +x trialtrgrpc

rm -f ins-xray.sh



