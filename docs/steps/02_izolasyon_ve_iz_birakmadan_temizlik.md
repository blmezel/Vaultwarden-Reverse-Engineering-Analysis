# 🕵️ Adım 2: İzolasyon ve İz Bırakmadan Temizlik (Adli İnceleme)

## 1. Analiz Kapsamı
Vaultwarden kurulduktan ve kaldırıldıktan sonra sistemde bıraktığı dijital izler "Forensics" (Adli Bilişim) perspektifiyle incelenmiştir.

## 2. Teknik Analiz ve Kritik Soru Yanıtı
> **Hocanın Kritik Sorusu:** İstediğiniz bir kayıt (log, toplam dosya, liman, arka plan servisi vb.) kalmadığından tam olarak nasıl emin olacaksınız? Bunu ispatlamanız gerekmektedir.

**İspat Yöntemleri:**
Bir sistemin tamamen temizlendiğinden emin olmak için şu 3 kontrol mekanizması uygulanmıştır:

1.  **Disk Analizi (Dosya Kalıntıları):** Sistem kaldırılsa bile `sqlite-wal` (Write-Ahead Logging) ve `sqlite-shm` (Shared Memory) dosyalarının diskte kalmaya devam ettiği tespit edilmiştir. Bu, sistemin tam bir "temizlik" yapmadığının kanıtıdır.
2.  **Port (Liman) Denetimi:** `netstat -tulpn` ve `nmap` komutları kullanılarak, servis durdurulduktan sonra 80, 443 veya 3012 gibi portların (limanların) "LISTEN" durumunda kalıp kalmadığı kontrol edilmiştir. Eğer port kapandıysa, arka plan servisi başarıyla durmuş demektir.
3.  **Log ve Cache Kontrolü:** `/var/log` ve uygulamanın kendi `logs/` dizini incelenmiş; `rm -rf` komutu sonrası bile diskte "Orphaned" (Sahipsiz) inode kalıntıları olup olmadığı `ls -la` ile denetlenmiştir.

## 3. Araştırmacı Notu (Süreç Günlüğü 🖋️)
Hocam, temizlik testlerini yaparken en çok `sqlite-wal` dosyası beni şaşırttı. Uygulamayı durdurmama rağmen bu dosya diskte 0 byte olmayan bir veriyle durmaya devam etti. Bu da demek oluyor ki, sadece "sil" demek yetmiyor; bu dosyaların üzerine "shred" (üzerine yazarak silme) komutuyla gidilmesi gerekiyor. İz kalmadığından ancak bu düşük seviyeli (low-level) disk analizleriyle emin olabiliriz.
