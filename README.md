
🛡️ Vaultwarden: Güvenlik Analizi ve Tersine Mühendislik Raporu
Analist: Ezel Balım Atik

Kurum: İstinye Üniversitesi

Bölüm: Bilişim Güvenliği Teknolojisi

Ders: Tersine Mühendislik (Vize Projesi)

Tarih: Mart 2026

📊 1. Proje Genel Bakışı
Özet: Bu rapor, Vaultwarden (Rust tabanlı şifre yönetim sistemi) platformunun mimari güvenliğini, konteyner izolasyonunu ve potansiyel zafiyet noktalarını detaylandırmaktadır.

📌 Kapsam: 9 Adım (5 Zorunlu + 4 Bonus Denetim)

⚠️ Zafiyet Seviyesi: Orta/Kritik (Kurulum ve İzolasyon süreçlerinde bulgular)

🛡️ Savunma Durumu: Aktif (Ezel-Audit & Fail2Ban Entegrasyonu sağlandı)

🏗️ 2. Mimari Akış ve Savunma Katmanları
Aşağıdaki şema, kullanıcının sisteme erişiminden veritabanına kadar olan süreci ve aradaki güvenlik katmanlarını temsil eder:

Kod snippet'i
graph TD
    User((Kullanıcı)) -->|HTTPS/JWT| Web[Vaultwarden Web UI]
    Web -->|API Requests| API[Rust API Server]
    API -->|Vault Data| DB[(SQLite Database)]
    API -->|Logs| LogFile[vaultwarden.log]
    
    subgraph "Entegre Savunma Sistemleri"
    API -.->|Ezel-Audit| Scan[Güvenlik Taraması]
    API -.->|Protect| F2B[Fail2Ban IP Bloklama]
    API -.->|Verify| Hash[İmza Kontrolü]
    end
🕵️‍♂️ 3. Teknik Metodoloji ve Kritik Bulgular
🔍 3.1. Kurulum ve Hash Analizi (Adım 1)
Soru: Dış kaynaklı paketlerde imza kontrolü yapılıyor mu?

Bulgu: install.sh süreçlerinde paketlerin sha256sum kontrollerinin eksik olduğu tespit edilmiştir.

Risk: Man-in-the-Middle (MitM) saldırılarına karşı savunmasızlık.

🧹 3.2. İzolasyon ve Adli Bilişim (Adım 2)
Soru: Sistem kaldırıldıktan sonra kalıntı bırakıyor mu?

Bulgu: /data dizini altındaki SQLite log dosyalarının (-wal, -shm) sistem silinse dahi diskte kaldığı ispatlanmıştır.

⚙️ 3.3. CI/CD ve Otomasyon (Adım 3)
Analiz: Webhook'ların birer HTTP callback mekanizması olduğu ve projenin otomasyon şeffaflığı analiz edilmiştir. .github/workflows eksikliği raporlanmıştır.

🐳 3.4. Konteyner Mimarisi (Adım 4 & 5)
Docker vs VM: İzolasyon seviyeleri karşılaştırılmış, Docker'ın çekirdek paylaşımı ve VM'in donanım sanallaştırma farkları incelenmiştir.

JWT Güvenliği: Kimlik doğrulama süreçlerindeki "Token Hijacking" riskleri teorik olarak analiz edilmiştir.

🛠️ 4. Geliştirilen Özel Savunma Araçları
🛡️ Ezel-Audit Bash Script (Bonus 11)
Manuel denetimleri otomatize etmek için geliştirilen bu araç şu kontrolleri sağlar:

777 izinli (herkese açık) tehlikeli dosyaların tespiti.

Diskte unutulan SQLite kalıntı verilerinin analizi.

Boş veya zayıf yapılandırılmış güvenlik scriptlerinin denetimi.

📡 Ağ Güvenliği ve Fail2Ban (Bonus 10 & 12)
Nmap: Ağ taraması ile tüm portların "Default Deny" olduğu teyit edildi.

Brute-Force: 3 hatalı denemede IP engelleyen vaultwarden-jail.local kurgusu hazırlandı.

📝 5. Araştırmacı Ayak İzi (Logbook)
Süreç boyunca terminalde karşılaşılan krizler ve uygulanan çözümler:

🚩 0 Byte Script Dosyaları: port-check.sh fonksiyonel kodla doldurularak sorun giderildi. (Durum: ✅)

🚩 Mermaid Render Hatası: Diyagram kodu graph TD yapısına göre refactor edilerek görselleştirme sağlandı. (Durum: ✅)

🚩 Hatalı Dosya İsimleri: Repodaki **Not:** gibi terminal kalıntıları temizlendi, hiyerarşi düzeltildi. (Durum: ✅)

🧰 6. Kullanılan Araç Seti (Toolkit)
Ağ Analizi: Nmap, netstat.

Güvenlik: ezel-audit.sh, Fail2Ban.

Sanal Ortam: Docker Engine, Alpine Linux.

Dokümantasyon: Markdown, Mermaid.js.

🌐 7. Gelecek Çalışma: Modern Audit Dashboard
Analiz verilerini interaktif bir panel üzerinden sunacak olan HTML/CSS tabanlı "Audit Dashboard" bir sonraki fazda projeye dahil edilecektir.
