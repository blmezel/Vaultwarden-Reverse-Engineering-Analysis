# ⛓️ Adım 3: İş Akışları ve CI/CD Pipeline Analizi

## 1. Analiz Kapsamı
Projenin GitHub üzerindeki otomatik derleme, test ve yayına alma (CI/CD) süreçleri incelenmiştir. `.github/workflows` dizini üzerinden otomasyon paketlerinin güvenliği denetlenmiştir.

## 2. Teknik Analiz ve Kritik Soru Yanıtı
> **Hocanın Kritik Sorusu:** "Webhook" nedir ve bu projenin özelinde (veya genel CI/CD analizinde) tam olarak ne işe yarar?

**Analiz Sonucu:**
Analiz sırasında yerel repoda `.github/workflows` dizininin bulunmadığı tespit edilmiştir. Bu durum, projenin CI/CD süreçlerinin (otomatik testlerin) yerel araştırmacıya kapalı olduğunu ve "Shadow CI/CD" (görünmeyen otomasyon) riskini taşıdığını gösterir.

**Webhook Nedir?**
Webhook, bir uygulamada (örneğin GitHub) belirli bir olay gerçekleştiğinde (kod gönderilmesi - `push`), bu olayı önceden belirlenmiş bir URL'ye gerçek zamanlı "haber veren" bir HTTP geri çağırma (callback) mekanizmasıdır.

**CI/CD Analizindeki Rolü:**
* **Tetikleme:** Geliştirici kodu GitHub'a gönderdiğinde, GitHub bir **Webhook** tetikleyerek CI/CD sunucusuna (Jenkins, GitHub Actions vb.) "Yeni kod geldi, testleri başlat!" sinyali gönderir.
* **Otomasyon:** Webhook sayesinde kodun güvenliği manuel müdahaleye gerek kalmadan anlık olarak taranabilir.

## 3. Araştırmacı Notu (Süreç Günlüğü 🖋️)
Hocam, `.github/workflows` klasörüne ulaşamayınca projenin Webhook mimarisini genel dökümantasyon üzerinden analiz ettim. Bir siber güvenlikçi olarak şunu söyleyebilirim: Webhook'lar doğru yapılandırılmazsa (Secret token kullanılmazsa), saldırganlar sahte Webhook paketleri göndererek CI/CD sunucusunu manipüle edebilir ve sisteme zararlı kod enjekte edebilirler. Bu projenin en büyük "gizli" risklerinden biri budur.
