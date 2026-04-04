# 🐋 Adım 4: Docker Mimarisi ve Konteynır Güvenliği

## 1. Analiz Kapsamı
Projenin konteynır yapısı, kullanılan imaj katmanları ve izolasyon seviyesi incelenmiştir. `docker-compose.yml` üzerinden depolama ve ağ yetkileri denetlenmiştir.

## 2. Teknik Analiz ve Kritik Soru Yanıtı
> **Hocanın Kritik Sorusu:** Docker imajı nedir? Hangi katmanlardan inşa ediliyor? Konteyner sistemi içindeki depolamaya erişilebiliyor mu? Ortamı güvenli hale nasıl getirebiliriz? Kubernetes ve VM ile fark nedir?

**Analiz Sonucu ve Yanıtlar:**

* **Docker İmajı Nedir?** Bir uygulamanın çalışması için gerekli olan kod, çalışma zamanı (runtime), kütüphaneler ve çevre değişkenlerini içeren, salt-okunur (read-only) ve taşınabilir bir pakettir.
* **Katman Analizi:** Docker imajları üst üste binen katmanlardan (Layers) oluşur. Vaultwarden, `alpine` gibi minimal bir "Base OS" katmanı üzerine Rust kütüphanelerini ekleyerek inşa edilir. Her yeni komut (`RUN`, `COPY`) yeni bir katman oluşturur.
* **Depolama Erişimi:** Konteynır içindeki veriler geçicidir. Kalıcı depolama için **Volumes** veya **Bind Mounts** kullanılır. Bu yolla, konteynır silinse bile veritabanı (`db.sqlite3`) host makinede güvenle saklanır.
* **Güvenlik Sıkılaştırma:** Ortamı güvenli kılmak için; root yetkisi olmayan (rootless) kullanıcılar tanımlanmalı, dosya sistemi "read-only" yapılmalı ve `docker-scan` ile zafiyet taraması yapılmalıdır.

**VM vs Docker vs Kubernetes:**
1.  **Sanal Makine (VM):** Donanımı sanallaştırır. Her VM kendi işletim sistemine (Kernel) sahiptir; bu yüzden ağırdır ve açılması dakikalar sürer.
2.  **Docker:** İşletim sistemini (Kernel) sanallaştırır. Host makinenin kernelini paylaştığı için çok hafiftir ve saniyeler içinde açılır.
3.  **Kubernetes:** Tek bir konteynırı değil, binlerce konteynırın (Docker) dağıtımını, ölçeklenmesini ve yönetimini yapan bir "orkestra şefi"dir.

## 3. Araştırmacı Notu (Süreç Günlüğü 🖋️)
Hocam, Docker analizinde dikkatimi çeken en önemli unsur izolasyon seviyesi oldu. VM'de bir hacker kernel seviyesine inerse tüm sistemi ele geçirebilirken, Docker'da kernel paylaşımı olduğu için "Container Escape" (Konteynırdan Kaçış) saldırıları teorik olarak mümkündür. Bu yüzden Vaultwarden gibi hassas verilerin tutulduğu sistemlerde Docker'ın mutlaka "Seccomp" ve "AppArmor" profilleriyle sıkılaştırılması gerektiğini düşünüyorum.
