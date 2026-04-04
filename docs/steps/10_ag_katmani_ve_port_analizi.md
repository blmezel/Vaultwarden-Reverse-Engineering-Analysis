# 📡 Adım 10: Ağ Katmanı ve Attack Surface (Saldırı Yüzeyi) Analizi

## 1. Analiz Kapsamı
Vaultwarden sisteminin dış dünyaya açık olan kapıları (portları) tespit etmek amacıyla ağ katmanı taraması gerçekleştirilmiştir.

## 2. Nmap Tarama Sonuçları
Yerel ağ üzerinde `nmap -sV localhost` komutu ile gerçekleştirilen TCP taramasında şu bulgular elde edilmiştir:
* **Bulgu:** "All 1000 scanned ports on localhost are in ignored states / closed."
* **Analiz:** Sistemin dışarıya karşı varsayılan olarak kapalı olması (Default Deny), Attack Surface (Saldırı Yüzeyi) prensiplerine göre en güvenli senaryodur. 

## 3. Güvenlik Sıkılaştırma Önerisi (Hacker Engelleme)
Vaultwarden'ın normal çalışması için genellikle Web arayüzü (80/443) ve WebSocket (3012) portlarına ihtiyaç duyulur. Dışarıdan gelebilecek port tarama (Port Scanning) ve DDoS saldırılarını engellemek için:
1. Portlar doğrudan dışarı açılmamalıdır.
2. Önüne mutlaka bir **Reverse Proxy (Nginx/Traefik)** ve **WAF (Web Application Firewall)** konulmalıdır.
3. Yönetim portlarına sadece VPN veya belirli IP bloklarından (IP Whitelisting) erişim izni verilmelidir.
