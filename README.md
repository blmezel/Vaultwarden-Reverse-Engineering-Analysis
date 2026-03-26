# 🛡️ Vaultwarden: Tersine Mühendislik, Sistem Mimarisi ve Güvenlik Analizi

**Proje Yürütücüsü:** Ezel Balım Atik  
**Kurum:** İstinye Üniversitesi  
**Bölüm:** Bilişim Güvenliği Teknolojisi  
**Ders:** Tersine Mühendislik (Vize Projesi)  
**Tarih:** Mart 2026  

---

## 1. Yönetici Özeti (Executive Summary)
Bu proje, endüstri standartlarında açık kaynaklı bir şifre yönetim sunucusu olan **Vaultwarden**'ın (Rust tabanlı Bitwarden backend alternatifi) uçtan uca güvenlik denetimini ve tersine mühendislik analizini kapsamaktadır. Çalışma, yazılımın statik kaynak kod analizinden başlayarak, dinamik bellek (RAM) davranışlarına, konteyner izolasyonundan CI/CD tedarik zinciri (Supply Chain) güvenliğine kadar geniş bir "Sistem Mimarı" perspektifi sunmayı hedeflemektedir.

## 2. İleri Seviye Tersine Mühendislik Entegrasyonları (İnovasyon)
Standart 5 aşamalı inceleme prosedürüne ek olarak, aşağıdaki ileri seviye güvenlik senaryoları projeye entegre edilmiştir:

* **[Kriptografik Derinlik - Senaryo #10]:** Vaultwarden'ın AES-256-GCM ve PBKDF2/Argon2id şifreleme altyapısının incelenmesi. Kullanıcıya ait `Master Password`'ün entropi kalitesi, şifreleme/deşifreleme (encryption/decryption) döngüleri ve anahtarın hafızada tutulma mimarisi statik olarak analiz edilecektir.
* **[Volatilite ve RAM Analizi - Senaryo #23]:** Uygulama aktif olarak çalışır durumdayken alınacak bellek dökümleri (RAM Dump) üzerinden; JWT (JSON Web Token) oturum anahtarlarının veya deşifre edilmiş hassas verilerin bellekte (Data-in-Use) "Plaintext" (açık metin) olarak sızıp sızmadığı adli bilişim teknikleriyle (Volatility/GDB) test edilecektir.

---

## 3. Metodoloji: 5 Aşamalı Güvenlik ve Mimari Analizi

### 🔍 Adım 1: Kurulum, Bağımlılık ve Statik Dosya Analizi
* **Görev:** `Dockerfile`, `install.sh` ve `Cargo.toml` dosyalarının AST (Abstract Syntax Tree) seviyesinde veya manuel statik analizi.
* **Kritik Analiz Noktaları:** * Sistem dışarıdan paket çekerken hash (imza) kontrolü (`Cargo.lock` bütünlüğü) yapıyor mu?
  * Kurulum scriptleri `curl | bash` gibi güvensiz ve körü körüne çalıştırma (blind execution) zafiyetleri barındırıyor mu?
  * Kurulum sırasında talep edilen Root/Admin yetkilerinin kapsamı nedir?

### 🧹 Adım 2: İzolasyon Testi ve Adli Bilişim Temizliği (Forensics)
* **Görev:** İzole bir Sanal Makine (VM) üzerinde kurulum, çalıştırma ve sistemden tamamen kaldırma (purge) süreçlerinin izlenmesi.
* **Kritik Analiz Noktaları:** * Diferansiyel disk analizi ile kurulum öncesi ve sonrası sistem "Snapshot" karşılaştırması.
  * İstenmeyen kalıntıların (Log dosyaları, `syslog` girdileri, açık bırakılan "Orphaned" portlar, arka plan Daemon servisleri ve SQLite veritabanı kalıntıları) tespiti.

### ⚙️ Adım 3: Sürekli Entegrasyon (CI/CD) ve İş Akışı Analizi
* **Görev:** GitHub reposunda bulunan `.github/workflows` klasörünün ve otomasyon paketlerinin denetimi.
* **Kritik Analiz Noktaları:** * "Webhook" mimarisinin güvenliği ve dışarıdan manipülasyon (Payload Injection) riskleri.
  * Otomatik test kodlarının çalışma prensipleri ve Secrets (gizli anahtar) yönetimi.

### 🐳 Adım 4: Konteyner Güvenliği ve Docker Mimarisi
* **Görev:** Docker imaj katmanlarının (Image Layers) ve `docker-compose.yml` yapılandırmasının parçalarına ayrılması.
* **Kritik Analiz Noktaları:** * İmaj inşasında kullanılan Base OS ve gereksiz bileşen (Bloatware) analizi.
  * Konteynerin "Rootless" (yetkisiz) ortamda çalışma kapasitesi.
  * Konteyner içi depolama birimlerinin (Volumes) Host sisteme erişim yetkileri ve "Container Escape" (Konteynerden Kaçış) senaryoları.

### 🎯 Adım 5: Kaynak Kod, Tehdit Modelleme ve Giriş Noktası Tespiti
* **Görev:** Rust kaynak kodu üzerinden uygulamanın uç noktalarının (Endpoints) ve yetkilendirme (Authentication) süreçlerinin haritalandırılması.
* **Kritik Analiz Noktaları:** * Bir saldırganın gözünden JWT, Session veya OAuth mekanizmalarına yönelik "Logic Bypass" senaryoları.
  * Rust dilinin bellek güvenliği özelliklerinin (Ownership/Borrowing) zafiyetleri (Örn: `unsafe` bloklarının taranması) ne ölçüde engellediğinin ispatı.

---

## 4. Proje Zaman Çizelgesi ve Teslimatlar (Agile Sprint)

| Zaman Çizelgesi | Hedef Aşama | Planlanan Somut Çıktı (Deliverable) |
| :--- | :--- | :--- |
| **1. Hafta (Gün 1-7)** | Kurulum Analizi, VM Temizlik Testleri ve CI/CD Güvenliği (Adım 1, 2 ve 3) | Kurulum hiyerarşisi, Hash doğrulama kanıtları, "İz Bırakmama" Diff analizi ve İş Akışı diyagramları. |
| **2. Hafta (Gün 8-14)** | Docker İzolasyonu, RAM/Kripto Analizi ve Final Dokümantasyon (Adım 4 ve 5) | `dive` aracı çıktıları, RAM Dump (Bellek Dökümü) Hex analiz ekran görüntüleri, STRIDE tehdit tablosu ve Final Vize Raporu. |

## 5. Başarı Kriterleri (Ölçülebilirlik)
* Tüm mimari yapının en az 3 detaylı veri akış diyagramı (Data Flow Diagram) ile görselleştirilmesi.
* Kurulum ve temizlik aşamalarının %100 tekrarlanabilir (reproducible) adımlarla belgelenmesi.
* Uygulamanın bellek (RAM) yönetimindeki güvenlik seviyesinin uygulamalı olarak kanıtlanması.

## 6. Araç Kutusu (Tech Stack & Toolkit)
* **Sanallaştırma & Konteyner:** Docker Engine, Docker Compose, VirtualBox/VMware.
* **Statik & Dinamik İkili Analiz:** Ghidra (Gerekirse), `strings`, `grep`, `strace`.
* **Bellek Analizi:** GDB, Volatility.
* **Ağ Trafiği ve İzolasyon:** Wireshark, `dive` (Docker layer analizi için).
* **Dokümantasyon:** Markdown, Mermaid.js.
