# 🔍 Adım 1: Kurulum, Bağımlılık ve Statik Dosya Analizi

## 1. Analiz Hedefi
Vaultwarden'ın kurulum sürecinde dışarıdan çektiği paketlerin güvenliğini ve `Dockerfile` yapısını "Supply Chain Security" (Tedarik Zinciri Güvenliği) perspektifiyle incelemek.

## 2. Teknik Bulgular (Static Analysis)
* **Temel İmaj:** Uygulama `alpine` ve `rust:alpine` imajları üzerine inşa edilmiş. Bu, saldırı yüzeyini küçültmek için (minimal footprint) doğru bir tercihtir.
* **Hash Doğrulama:** `Cargo.lock` dosyası incelendiğinde, tüm bağımlılıkların (dependencies) SHA-256 hash değerlerinin kayıtlı olduğu görülmüştür. Bu, kurulum sırasında "Man-in-the-Middle" saldırılarıyla sahte paket yüklenmesini engeller.
* **Kritik Dosya:** `Dockerfile` içerisinde `USER vaultwarden` komutu ile uygulamanın **root olmayan (non-privileged)** bir kullanıcıyla çalışması hedeflenmiştir.

## 3. İlk Sonuç
Kurulum mekanizması, dış kaynaklı paketlerin bütünlüğünü (integrity) korumaktadır. Ancak, kurulum scriptleri içindeki `curl | sh` kullanımı potansiyel bir risk olarak not edilmiştir.
# 🛠️ Adım 1: Kurulum ve install.sh Analizi

## 1. Analiz Durumu
Dizindeki `before_install.txt` dosyası incelenmiştir. Kurulumun "Körü körüne" (blind execution) yapılıp yapılmadığı denetlenmiştir.

## 2. Kritik Cevap (Hocaya Cevap)
Kurulum sırasında paketlerin `sha256sum` gibi hash kontrollerinin yapılmadığı görülmüştür. Bu bir "Man-in-the-Middle" (Aradaki Adam) saldırısı riskini doğurur. Saldırgan paketleri yolda değiştirirse sistem bunu fark edemez.
# 🛠️ Adım 1: Kurulum ve install.sh Analizi (Tersine Mühendislik)

## 1. Analiz Kapsamı
Projenin kurulum süreçlerini yöneten `before_install.txt` ve genel kurulum mantığı incelenmiştir. Sistemin dış kaynaklara ne kadar güvendiği test edilmiştir.

## 2. Teknik Analiz ve Kritik Soru Yanıtı
> **Hocanın Kritik Sorusu:** Onların indirdiği kaynaklar ne kadar güvenli? Dışarıdan paket çekerken hash (imza) kontrolü yapıyor mu, yoksa körü körüne `curl | bash` mantığıyla mı çalışıyor?

**Analiz Sonucu:**
Vaultwarden kurulum scriptleri incelendiğinde, paketlerin çoğunlukla doğrudan resmi repolardan çekildiği ancak çekilen bu paketlerin **`sha256sum` gibi hash (imza) kontrollerinden geçirilmediği** tespit edilmiştir. 

* **Risk:** Bu durum "Blind Execution" (Körü körüne çalıştırma) riskini doğurur. 
* **Saldırı Senaryosu:** Eğer saldırgan araya girip (MitM - Man in the Middle) indirilen dosyayı kendi zararlı koduyla değiştirirse, sistem bunu kontrol etmediği için zararlı kod doğrudan sunucuya kurulacaktır.

## 3. Araştırmacı Notu (Süreç Günlüğü 🖋️)
`before_install.txt` dosyasındaki komutları tek tek incelediğimde, paket yönetiminin tamamen paket yöneticisine (apt/cargo) bırakıldığını gördüm. Güvenli bir mimaride bu paketlerin imzalarının (checksum) kurulumdan önce doğrulanması gerekirdi. Hocam, bu projenin kurulum aşamasında "güven zinciri" (chain of trust) sadece sunucu güvenliğine dayalıdır.
