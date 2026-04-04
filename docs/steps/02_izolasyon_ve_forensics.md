# 🕵️ Adım 2: İzolasyon ve Sistem Forensics Analizi

## 1. Analiz Metodolojisi
Vaultwarden konteynırı çalışırken ve durdurulduktan sonra sistemde bıraktığı dijital izler (digital artifacts) incelenmiştir. "İz bırakmama" (Anti-forensics) kapasitesi test edilmiştir.

## 2. Gerçek Zamanlı Bulgular (Terminal Kayıtları)
* **Ağ İzleri (Network Persistence):** Konteynır durdurulduğunda dahi `docker0` köprüsü üzerinde sanal bir veth (virtual ethernet) kalıntısı tespit edildi.
  `ip addr show | grep veth` komutu ile yapılan kontrolde arayüzün pasif duruma geçtiği ancak tamamen silinmediği görüldü.
  
* **Dosya Sistemi Kalıntıları:**
  `find /var/lib/docker/volumes/ -mmin -10` komutuyla yapılan taramada, Vaultwarden'ın `sqlite3` veritabanının `WAL` (Write-Ahead Logging) dosyalarının konteynır kapandıktan sonra dahi diskte yazılı kaldığı tespit edildi. 

## 3. Risk Değerlendirmesi ve Notlar
Analiz sırasında Kali üzerinde Docker daemon'ın yüksek CPU kullanımı nedeniyle (85%+) analiz bir kez kesintiye uğradı, ancak Docker servisi restart edilerek işleme devam edildi.
> **Kritik Tespit:** Vaultwarden varsayılan kurulumda bellekten (RAM) veri temizleme (Zeroing memory) işlemi yapmıyor gibi görünüyor. Bu durum Adım 7'deki RAM Analizi için büyük bir fırsat sunuyor.
