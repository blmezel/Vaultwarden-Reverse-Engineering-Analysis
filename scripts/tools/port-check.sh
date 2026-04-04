#!/bin/bash
echo "[*] Vaultwarden Kritik Port Kontrolü Başlatılıyor..."
for port in 80 443 3012
do
    (echo >/dev/tcp/localhost/$port) &>/dev/null && echo "[+] Port $port: AÇIK" || echo "[-] Port $port: KAPALI"
done
