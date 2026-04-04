# 📦 Adım 13: Yazılım Bağımlılık Analizi (SCA) ve Tedarik Zinciri Güvenliği

## 1. Analiz Kapsamı ve Tehdit (Supply Chain)
Vaultwarden, Rust programlama dili ile yazılmış olup, dışarıdan birçok üçüncü parti kütüphane (Crate) kullanmaktadır. SCA analizi, projenin kendi kodunun ötesine geçerek, bu hazır paketlerde bilinen bir zafiyet (CVE - Common Vulnerabilities and Exposures) olup olmadığını denetlemeyi hedefler.

## 2. Denetim Yöntemi (Cargo Audit)
Rust tabanlı sistemlerde bağımlılık güvenliği `cargo audit` aracı ile sağlanır. Bu araç, projenin `Cargo.lock` dosyasını tarayarak kullanılan paketlerin sürümlerini "RustSec Advisory Database" (Güvenlik Bildirim Veritabanı) ile karşılaştırır. 

* **Saldırı Senaryosu:** Eğer Vaultwarden'ın kullandığı eski bir şifreleme kütüphanesinde (örneğin eski bir `openssl` veya `jsonwebtoken` sürümünde) kritik bir açık bulunursa, uygulamanın kendi kodu ne kadar güvenli olursa olsun sistem hacklenebilir. Bu duruma "Tedarik Zinciri Saldırısı" (Supply Chain Attack) denir.

## 3. Araştırmacı Notu (Süreç Günlüğü 🖋️)
Hocam, Docker analizinde Alpine Linux kullanıldığını ve gereksiz paketlerin silindiğini görmüştüm. Ancak uygulama katmanındaki (Rust crates) bağımlılıkların güvenliği tamamen geliştirici ekibin güncellemelerine kalmıştır. CI/CD süreçlerinde (Adım 3'te eksik olduğunu belirttiğim kısımda) mutlaka otomatik bir `cargo audit` veya `Dependabot` entegrasyonu olmalıdır. Aksi takdirde, aylar önce keşfedilmiş bir kütüphane zafiyeti, bu sistemi anında tehlikeye atabilir.
