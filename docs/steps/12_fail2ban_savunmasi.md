# 🛡️ Adım 12: Brute-Force Koruması ve Fail2Ban Entegrasyonu

## 1. Analiz Kapsamı ve Tehdit
Adım 5'te yapılan JWT ve Kimlik Doğrulama analizinde, sistemin "Brute-force" (Deneme-Yanılma) ve "Credential Stuffing" saldırılarına açık olabileceği tespit edilmiştir. Vaultwarden, doğası gereği tüm şifrelerin anahtarı olan "Master Password" ile korunur. Bu parolaya yönelik aralıksız denemelerin ağ (network) katmanında kesilmesi gerekmektedir.

## 2. Savunma Mimarisi (Fail2Ban)
Saldırıları proaktif olarak engellemek için projeye bir `vaultwarden-jail.local` kural dosyası eklenerek Fail2Ban entegrasyonu kurgulanmıştır.
* **Mekanizma:** Fail2Ban, uygulamanın log dosyalarını anlık olarak okur. Başarısız giriş denemelerini (HTTP 401 Unauthorized) tespit eder.
* **Kural:** Aynı IP adresi 10 dakika içinde 3 kez hatalı giriş yaparsa, `iptables` (Linux Güvenlik Duvarı) güncellenerek o IP adresi 1 saat (3600 saniye) boyunca tamamen engellenir.

## 3. Araştırmacı Notu (Süreç Günlüğü 🖋️)
Hocam, Docker analizini yaparken konteynır içindeki uygulamanın doğrudan host makinenin güvenlik duvarına müdahale edemediğini fark ettim. Bu yüzden Fail2Ban'in doğrudan host makineye (Konteynırın dışına) kurulması ve logların Docker "volume" yetkileriyle hosta aktarılması (Bind Mount) gerekmektedir. Hazırladığım jail.local dosyası bu savunma hattının temel taşıdır. Saldırgan uygulama katmanına ulaşamadan ağ katmanında engellenecektir.
