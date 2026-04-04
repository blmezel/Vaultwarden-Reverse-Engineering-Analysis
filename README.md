🛡️ Vaultwarden: Tersine Mühendislik, Sistem Mimarisi ve Güvenlik Analizi
Proje Yürütücüsü: Ezel Balım Atik

Kurum: İstinye Üniversitesi

Bölüm: Bilişim Güvenliği Teknolojisi

Ders: Tersine Mühendislik (Vize Projesi)

Tarih: Mart 2026

1. Yönetici Özeti (Executive Summary)
Bu çalışma, endüstri standartlarında açık kaynaklı bir şifre yönetim sunucusu olan Vaultwarden'ın uçtan uca güvenlik denetimini ve tersine mühendislik analizini kapsamaktadır. Standart bir analizden öteye geçerek; terminal seviyesinde karşılaşılan yapısal hataların tespiti, kriz yönetimi süreçleri ve sistemin proaktif savunma araçlarıyla (Ezel-Audit, Fail2Ban) sıkılaştırılmasını içeren kapsamlı bir "Siber Güvenlik Denetçisi" perspektifi sunar.

2. Mimari Görselleştirme (Mermaid Analysis)
Sistemin veri akış ve güvenlik katmanları aşağıda canlı olarak haritalandırılmıştır:

Kod snippet'i
graph TD
    User((Kullanıcı)) -->|HTTPS/JWT| Web[Vaultwarden Web UI]
    Web -->|API Requests| API[Rust API Server]
    API -->|Vault Data| DB[(SQLite Database)]
    API -->|Logs| LogFile[vaultwarden.log]
    
    subgraph "Güvenlik ve Savunma Katmanları"
    API -.->|Ezel-Audit| Scan[Zafiyet Taraması]
    API -.->|Protect| F2B[Fail2Ban - IP Blocking]
    API -.->|Verify| Hash[Hash Check]
    end
3. Metodoloji: 9 Adımlık Derinlemesine Denetim
🔍 Adım 1: Kurulum ve Hash Doğrulama (Zorunlu)
Kritik Soru: Paketler çekilirken imza kontrolü yapılıyor mu?

Bulgu: Kurulumun "Blind Execution" (Körü körüne) yapıldığı, sha256sum kontrollerinin eksik olduğu tespit edilmiştir. Bu durum bir MitM (Aradaki Adam) saldırısı riski olarak raporlanmıştır.

🧹 Adım 2: İzolasyon ve Forensics (Zorunlu)
Kritik Soru: Sistemden gerçekten iz kalmıyor mu?

Bulgu: Uygulama silinse dahi sqlite-wal ve sqlite-shm dosyalarının diskte kalıntı bıraktığı adli bilişim teknikleriyle ispatlanmıştır.

⚙️ Adım 3: CI/CD ve Webhook Analizi (Zorunlu)
Kritik Soru: Webhook nedir ve güvenliği nasıl etkiler?

Bulgu: Yerel repoda .github/workflows klasörünün eksikliği "Shadow CI/CD" riski olarak tanımlanmıştır. Webhook'ların birer HTTP callback mekanizması olduğu ve otomasyon güvenliğindeki rolü analiz edilmiştir.

🐳 Adım 4: Docker Mimarisi ve VM Karşılaştırması (Zorunlu)
Analiz: Docker'ın "Kernel Virtualization" mantığı ile VM'in "Hardware Virtualization" farkları incelenmiş, Alpine Linux tabanlı imaj katmanları parçalarına ayrılmıştır.

🎯 Adım 5: Kaynak Kod ve Tehdit Modelleme (Zorunlu)
Analiz: JWT (JSON Web Token) oturum yönetimi incelenmiş; "Token Hijacking" ve "Brute-Force" saldırılarına karşı sistemin direnci test edilmiştir.

📡 Adım 10: Ağ Katmanı ve Nmap Analizi (Bonus)
Bulgu: nmap -sV taramasında tüm portların kapalı (Default Deny) olduğu görülmüş, sistemin dış saldırı yüzeyinin minimumda tutulduğu onaylanmıştır.

🛠️ Adım 11: Ezel-Audit Özel Güvenlik Aracı (İnovasyon)
Geliştirme: Sistemdeki zafiyetli izinleri (777), boş scriptleri ve DB kalıntılarını tek tuşla bulan ezel-audit.sh Bash scripti kodlanmıştır. Bu, projenin en özgün "çözüm odaklı" parçasıdır.

🛡️ Adım 12: Fail2Ban ve Brute-Force Savunması (Bonus)
Savunma: Hackerların deneme-yanılma saldırılarını durdurmak için IP tabanlı engelleme yapan vaultwarden-jail.local kurgusu oluşturulmuştur.

📦 Adım 13: SCA ve Tedarik Zinciri Güvenliği (Bonus)
Analiz: Rust kütüphanelerindeki (Crates) bağımlılıkların güvenliği ve "Supply Chain" saldırı riskleri dokümante edilmiştir.

4. Araştırmacı Ayak İzi: Kriz Yönetimi (Logbook)
Süreç boyunca karşılaşılan teknik engeller ve uygulanan çözümler:

[Kriz - 04.04.2026]: scripts/tools altındaki hash-verify.sh ve port-check.sh dosyalarının içinin boş (0 byte) olduğu tespit edildi.

[Çözüm]: Dosyalar manuel olarak işlevsel Bash kodlarıyla dolduruldu ve chmod +x ile yetkilendirildi.

[Kriz - 04.04.2026]: GitHub Mermaid diyagramı render hatası verdi.

[Çözüm]: Mermaid kodu graph TD yapısına göre yeniden düzenlenerek görselleştirme sağlandı.

[Kriz - 04.04.2026]: Terminal hatalarından dolayı repoda hatalı isimli "hayalet dosyalar" oluştu.

[Çözüm]: git rm ve rm komutlarıyla repo refactoring (temizlik) işlemi yapıldı.

5. Gelecek Çalışma: Modern Dashboard
Analiz sonuçlarını interaktif bir şekilde sunmak amacıyla, bu README'deki verileri temel alan Modern, Dark-Theme HTML/CSS Güvenlik Paneli bir sonraki fazda yayına alınacaktır.

6. Araç Kutusu (Toolkit)
Analiz: Nmap, ezel-audit.sh, netstat, Docker Engine.

Dokümantasyon: Markdown, Mermaid.js.

Savunma: Fail2Ban Config, Unix Permissions Management.
