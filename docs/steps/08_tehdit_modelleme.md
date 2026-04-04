# 🛡️ Adım 8: STRIDE Metodolojisi ile Tehdit Modelleme

## 1. STRIDE Matrisi
Vaultwarden bileşenleri üzerindeki potansiyel tehditler Microsoft'un STRIDE modeliyle kategorize edilmiştir.

| Tehdit Türü | Açıklama (Vaultwarden Özelinde) | Risk Seviyesi | Önemli Bulgu |
| :--- | :--- | :--- | :--- |
| **S**poofing | Sahte bir Bitwarden istemcisi ile API'ya sızma. | Orta | TLS sertifika kontrolü zorunludur. |
| **T**ampering | SQLite veritabanına doğrudan müdahale. | Yüksek | WAL dosyalarının temizlenmediği tespit edildi (Bkz. Adım 2). |
| **R**epudiation | Admin işlemlerinin inkar edilmesi. | Düşük | Log sisteminin eksikliği bu riski artırıyor. |
| **I**nfo Disclosure | Bellekte (RAM) açık metin şifre sızıntısı. | Kritik | Data-in-use güvenliği zayıf (Bkz. Adım 7). |
| **D**enial of Service | Brute-force saldırısıyla servisi çökertme. | Yüksek | Rate-limiting (istek sınırlama) kontrol edilmeli. |
| **E**levation of Privilege | Konteynırdan host sisteme sızma. | Orta | Alpine imajı bu riski minimize ediyor (Bkz. Adım 4). |

## 2. Araştırmacı Notu (Süreç Günlüğü 🖋️)
> **Not:** STRIDE tablosunu oluştururken hangi tehdidin hangi kategoriye tam oturduğu konusunda biraz kafa karışıklığı yaşadım. Özellikle "Repudiation" (İnkar Etme) kısmını Vaultwarden gibi tek kullanıcılı/küçük ekipli yapılar için anlamlandırmak zordu. Ancak hoca derste "her adımı metodolojiye uydurun" dediği için, log sistemindeki eksiklikleri (Adım 6'da gördüğümüz boş loglar) bu kategoriye dahil ettim. Teknik olarak en büyük riskin "Information Disclosure" (Bilgi İfşası) olduğunu düşünüyorum.

## 3. Sonuç
STRIDE analizi, projenin en zayıf noktasının **Veri Gizliliği (I)** ve **Bütünlük (T)** olduğunu açıkça ortaya koymaktadır.
