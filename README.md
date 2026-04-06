<div align="center">
          <img width="320" height="320" alt="istinye-universitesi-logo-png_seeklogo-610039" src="https://github.com/user-attachments/assets/3debbd6f-edb2-4c3b-bbb6-ab19c460183c" />



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

🚩 Hatalı Dosya İsimleri: Repodaki terminal kalıntıları temizlendi, hiyerarşi düzeltildi. (Durum: ✅)

🧰 6. Kullanılan Araç Seti (Toolkit)
Ağ Analizi: Nmap, netstat

Güvenlik: ezel-audit.sh, Fail2Ban

Sanal Ortam: Docker Engine, Alpine Linux

Dokümantasyon: Markdown, Mermaid.js

🌐 7. Gelecek Çalışma: Modern Audit Dashboard
Analiz verilerini interaktif bir panel üzerinden sunacak olan HTML/CSS tabanlı "Audit Dashboard" bir sonraki fazda projeye dahil edilecektir.

🔬 Özel Güvenlik Aracı: Komut Çevirici (Disassembler)
Vaultwarden gibi derlenmiş (compiled) ve yüksek güvenlikli sistemlerin çekirdek komut akışını (instruction flow) en alt seviyede analiz edebilmek için projeye özel bir Disassembler modülü kodlanmıştır.

Kullanılan Teknoloji: Rust & Capstone Engine (x86_64 mimarisi)

Amaç: Makine dilindeki anlamsız Hex/Opcode bayt dizilimlerini (örn: B8 34 12 00...), analiz edilebilir Assembly komutlarına (mov eax, 0x1234) dönüştürerek tersine mühendislik süreçlerini otomatize etmek.

Nasıl Çalıştırılır?
Bash
cd komut-cevirici
cargo run
