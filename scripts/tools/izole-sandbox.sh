#!/bin/bash
# Vaultwarden Güvenli Kurulum Alanı Hazırlayıcı
echo "[*] Sandbox ortamı hazırlanıyor..."
mkdir -p /tmp/vaultwarden_sandbox
chmod 700 /tmp/vaultwarden_sandbox
echo "[+] İzole dizin oluşturuldu: /tmp/vaultwarden_sandbox"
echo "[!] Analizleri sadece bu dizin içinde gerçekleştirin!"
