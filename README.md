
<div align="center">
       
<img width="320" height="320" alt="istinye-universitesi-logo-png_seeklogo-610039" src="https://github.com/user-attachments/assets/7be1d44d-0ec2-4315-96c2-04e56145a53c" />

# 🛡️ Vaultwarden: Güvenlik Analizi ve Tersine Mühendislik Raporu

**Analist:** Ezel Balım Atik  
**Kurum:** İstinye Üniversitesi  
**Bölüm:** Bilişim Güvenliği Teknolojisi  
**Ders:** Tersine Mühendislik (Vize Projesi)  
**Eğitmen:** Keyvan Arasteh  
**Tarih:** Mart 2026  

🚀 **[CANLI SİBER GÜVENLİK PANELİNİ GÖRÜNTÜLEMEK İÇİN TIKLAYIN](https://blmezel.github.io/Vaultwarden-Reverse-Engineering-Analysis/)**

---

## 📊 1. Proje Genel Bakışı
**Özet:** Bu rapor, Vaultwarden (Rust tabanlı şifre yönetim sistemi) platformunun mimari güvenliğini, konteyner izolasyonunu ve potansiyel zafiyet noktalarını detaylandırmaktadır.

* **📌 Kapsam:** 9 Adım (5 Zorunlu + 4 Bonus Denetim)
* **⚠️ Zafiyet Seviyesi:** Orta/Kritik (Kurulum ve İzolasyon süreçlerinde bulgular)
* **🛡️ Savunma Durumu:** Aktif (Ezel-Audit & Fail2Ban Entegrasyonu sağlandı)

## 🏗️ 2. Mimari Akış ve Savunma Katmanları
Sistem mimarisi ve güvenlik katmanları şu şekilde işlemektedir:

* **Kullanıcı Erişimi:** HTTPS/JWT üzerinden Vaultwarden Web UI'a bağlantı.
* **Sunucu Katmanı:** Rust API Server üzerinden isteklerin işlenmesi.
* **Veri Katmanı:** SQLite Database (`vaultwarden.log` ile loglama).
* **Entegre Savunma:** Ezel-Audit (Güvenlik Taraması), Fail2Ban (IP Bloklama) ve İmza Kontrolü.

---

## 🕵️‍♂️ 3. Teknik Metodoloji ve Kritik Bulgular

### 🔍 3.1. Kurulum ve Hash Analizi (Adım 1)
* **Soru:** Dış kaynaklı paketlerde imza kontrolü yapılıyor mu?
* **Bulgu:** `install.sh` süreçlerinde paketlerin `sha256sum` kontrollerinin eksik olduğu tespit edilmiştir.
* **Risk:** Man-in-the-Middle (MitM) saldırılarına karşı savunmasızlık.

### 🧹 3.2. İzolasyon ve Adli Bilişim (Adım 2)
* **Soru:** Sistem kaldırıldıktan sonra kalıntı bırakıyor mu?
* **Bulgu:** `/data` dizini altındaki SQLite log dosyalarının (`-wal`, `-shm`) sistem silinse dahi diskte kaldığı ispatlanmıştır.

### ⚙️ 3.3. CI/CD ve Otomasyon (Adım 3)
* **Analiz:** Webhook'ların birer HTTP callback mekanizması olduğu ve projenin otomasyon şeffaflığı analiz edilmiştir. `.github/workflows` eksikliği raporlanmıştır.

### 🐳 3.4. Konteyner Mimarisi (Adım 4 & 5)
* **Docker vs VM:** İzolasyon seviyeleri karşılaştırılmış, Docker'ın çekirdek paylaşımı ve VM'in donanım sanallaştırma farkları incelenmiştir.
* **JWT Güvenliği:** Kimlik doğrulama süreçlerindeki "Token Hijacking" riskleri teorik olarak analiz edilmiştir.

---

## 🛠️ 4. Geliştirilen Özel Savunma Araçları

### 🛡️ Ezel-Audit Bash Script (Bonus 11)
Manuel denetimleri otomatize etmek için geliştirilen bu araç şu kontrolleri sağlar:
* **777** izinli (herkese açık) tehlikeli dosyaların tespiti.
* Diskte unutulan SQLite kalıntı verilerinin analizi.
* Boş veya zayıf yapılandırılmış güvenlik scriptlerinin denetimi.

### 📡 Ağ Güvenliği ve Fail2Ban (Bonus 10 & 12)
* **Nmap:** Ağ taraması ile tüm portların "Default Deny" olduğu teyit edildi.
* **Brute-Force:** 3 hatalı denemede IP engelleyen `vaultwarden-jail.local` kurgusu hazırlandı.

---

## 📝 5. Araştırmacı Ayak İzi (Logbook)
Süreç boyunca terminalde karşılaşılan krizler ve uygulanan çözümler:

* 🚩 **0 Byte Script Dosyaları:** `port-check.sh` fonksiyonel kodla doldurularak sorun giderildi. (Durum: ✅)
* 🚩 **Mermaid Render Hatası:** Diyagram kaldırılıp metinsel ifadeye dönüştürüldü. (Durum: ✅)
* 🚩 **Hatalı Dosya İsimleri:** Repodaki terminal kalıntıları temizlendi, hiyerarşi düzeltildi. (Durum: ✅)

---

## 🧰 6. Kullanılan Araç Seti (Toolkit)
* **Ağ Analizi:** Nmap, netstat
* **Güvenlik:** `ezel-audit.sh`, Fail2Ban
* **Sanal Ortam:** Docker Engine, Alpine Linux
* **Dokümantasyon:** Markdown

---

## 🌐 7. Gelecek Çalışma: Modern Audit Dashboard
Analiz verilerini interaktif bir panel üzerinden sunacak olan HTML/CSS tabanlı **"Audit Dashboard"** bir sonraki fazda projeye dahil edilecektir.

---

## 🔬 Özel Güvenlik Aracı: Komut Çevirici (Disassembler)
Vaultwarden gibi derlenmiş (compiled) ve yüksek güvenlikli sistemlerin çekirdek komut akışını (instruction flow) en alt seviyede analiz edebilmek için projeye özel bir **Disassembler** modülü kodlanmıştır.

* **Kullanılan Teknoloji:** Rust & Capstone Engine (`x86_64` mimarisi)
* **Amaç:** Makine dilindeki anlamsız Hex/Opcode bayt dizilimlerini (örn: `B8 34 12 00...`), analiz edilebilir Assembly komutlarına (`mov eax, 0x1234`) dönüştürerek tersine mühendislik süreçlerini otomatize etmek.

### Nasıl Çalıştırılır?

```bash
cd komut-cevirici
cargo run
```
🎬 Proje Demosu ve Yapay Zeka Analizi
Projenin derlenme, çalışma ve hata ayıklama (debugging) süreçleri otomatik test motoru Antigravity AI tarafından incelenmiş ve kayıt altına alınmıştır.

🎥 Test Videosu: Buraya Tıklayarak İzleyebilirsiniz

🤖 AI Analiz Raporu: ANTIGRAVITY_ANALYSIS.md
