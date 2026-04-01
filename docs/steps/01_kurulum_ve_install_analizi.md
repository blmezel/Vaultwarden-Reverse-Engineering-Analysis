# 🔍 Adım 1: Kurulum, Bağımlılık ve Statik Dosya Analizi

## 1. Analiz Hedefi
Vaultwarden'ın kurulum sürecinde dışarıdan çektiği paketlerin güvenliğini ve `Dockerfile` yapısını "Supply Chain Security" (Tedarik Zinciri Güvenliği) perspektifiyle incelemek.

## 2. Teknik Bulgular (Static Analysis)
* **Temel İmaj:** Uygulama `alpine` ve `rust:alpine` imajları üzerine inşa edilmiş. Bu, saldırı yüzeyini küçültmek için (minimal footprint) doğru bir tercihtir.
* **Hash Doğrulama:** `Cargo.lock` dosyası incelendiğinde, tüm bağımlılıkların (dependencies) SHA-256 hash değerlerinin kayıtlı olduğu görülmüştür. Bu, kurulum sırasında "Man-in-the-Middle" saldırılarıyla sahte paket yüklenmesini engeller.
* **Kritik Dosya:** `Dockerfile` içerisinde `USER vaultwarden` komutu ile uygulamanın **root olmayan (non-privileged)** bir kullanıcıyla çalışması hedeflenmiştir.

## 3. İlk Sonuç
Kurulum mekanizması, dış kaynaklı paketlerin bütünlüğünü (integrity) korumaktadır. Ancak, kurulum scriptleri içindeki `curl | sh` kullanımı potansiyel bir risk olarak not edilmiştir.
