# 🛠️ Adım 11: Ezel-Audit Otomatik Güvenlik Tarayıcısı (İnovasyon)

## 1. Geliştirme Amacı
Manuel analizler (Adım 1-7) sonucunda tespit edilen yapısal zafiyetlerin, otomatize edilmiş bir araçla saniyeler içinde bulunabilmesi için `ezel-audit.sh` adında özel bir Bash scripti kodlanmıştır.

## 2. Aracın Yetenekleri
Bu araç, Vaultwarden veya benzeri bir sunucuya atıldığında şu kontrolleri otomatik yapar:
1. **Zafiyetli İzinler:** Sistemde dışarıdan manipülasyona açık olan `777` yetkili dosyaları tespit eder. (Broken Access Control önlemi).
2. **Adli Bilişim Kalıntıları:** Disk üzerinde unutulan `.db-wal` uzantılı veritabanı loglarını bulur.
3. **Bütünlük Hataları:** Sistemdeki 0 byte'lık (içi boşaltılmış veya yazılması unutulmuş) güvenlik scriptlerini tespit eder.

## 3. Araştırmacı Notu (Süreç Günlüğü 🖋️)
Hocam, siber güvenlikte zafiyet bulmak kadar, bu bulguları otomatize edip sistemi düzenli olarak denetleyecek (audit) araçlar geliştirmek de önemlidir. Hazır araçlar kullanmak yerine, tam olarak bu projenin ihtiyaçlarına (ve bulduğumuz açıklara) yönelik "terzi işi" bir tarayıcı yazmayı tercih ettim. Bu script, potansiyel bir saldırganın sisteme sızmadan önce bakacağı ilk kapıları bizim için kontrol etmektedir.
