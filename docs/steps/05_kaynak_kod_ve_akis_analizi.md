# 🎯 Adım 5: Kaynak Kod ve Akış Analizi (Tehdit Modelleme)

## 1. Analiz Kapsamı
Uygulamanın giriş noktası (Entry Point), kimlik doğrulama (Authentication) akışı ve şifreleme kütüphaneleri incelenmiştir. Vaultwarden'ın Rust tabanlı mimarisi üzerinden potansiyel zafiyet noktaları haritalandırılmıştır.

## 2. Teknik Analiz ve Kritik Soru Yanıtı
> **Hocanın Kritik Sorusu:** Bir hacker bu reponun kaynak kodunu incelerken ne tür bir veriyi çalabilir? Bulduğunuz yerde kimlik doğrulama aralığına dışarıdan nasıl saldırılabilir?

**Analiz Sonucu ve Yanıtlar:**

* **Kaynak Koddan Ne Çalınabilir?** 1. **Veritabanı Şeması:** Hacker, verilerin nasıl tablolaştığını görerek "SQL Injection" noktalarını daha kolay tespit edebilir.
    2. **Hardcoded Secrets:** Geliştiricinin yanlışlıkla kodun içine gömdüğü API anahtarları, gizli tuzlama (salt) değerleri veya default admin şifreleri çalınabilir.
    3. **Algoritma Zafiyetleri:** Kullanılan şifreleme kütüphanesinin (Örn: PBKDF2 iterasyon sayısı) güncel olup olmadığı görülerek "Brute-force" süresi hesaplanabilir.

* **Kimlik Doğrulama Saldırıları (JWT/Session):**
    Vaultwarden, kullanıcı oturumları için **JWT (JSON Web Token)** kullanır. Bir hacker dışarıdan şu yollarla saldırabilir:
    1. **JWT Hijacking:** Eğer bağlantı HTTPS değilse, token "Man-in-the-Middle" ile çalınabilir ve hacker kullanıcı gibi içeri girebilir.
    2. **Brute Force:** Kimlik doğrulama aralığında bir "Rate Limiting" (istek sınırlama) yoksa, hacker milyonlarca şifre denemesi yaparak ana anahtarı kırmaya çalışabilir.
    3. **Token Replay:** Hacker ele geçirdiği bir token'ı süresi bitene kadar tekrar tekrar kullanarak yetkisiz erişim sağlayabilir.

## 3. Araştırmacı Notu (Süreç Günlüğü 🖋️)
Hocam, kaynak kod klasörünün (`src`) yerel repoda eksik olması sebebiyle analizi Vaultwarden'ın resmi dökümantasyonu ve mimari şemaları üzerinden yürüttüm. Bir hackerın kod içinden çalabileceği en büyük veri, uygulamanın **hata yönetimi (error handling)** mantığıdır. Kodun nerede hata verdiğini bilen bir saldırgan, sistemi "Logic Bypass" (mantık atlatma) saldırılarıyla manipüle edebilir. Kimlik doğrulama kısmında ise Vaultwarden'ın "Master Password"u asla sunucuya açık metin (plain-text) göndermemesi, en büyük savunma kalkanıdır.
