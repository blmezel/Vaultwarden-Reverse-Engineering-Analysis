# 🧪 Adım 0: Laboratuvar Ön Gereksinimleri ve Sandbox Hazırlığı

Vaultwarden projesinin güvenlik analizine başlamadan önce, sistem bütünlüğünü korumak amacıyla aşağıdaki izole ortam hazırlanmıştır.

## 1. İzole Ortam (Sandbox) Yapılandırması
Uygulama doğrudan Host işletim sistemine kurulmayacaktır. 
* **Kullanılan Script:** `scripts/tools/izole-sandbox.sh`
* **Amacı:** Dosyaları indireceği ve derleyeceği sahte bir kök dizini (/tmp) oluşturmak.

## 2. Otomatik Denetçi (Auto-Auditor) ve Loglama
* **Kullanılan Script:** `scripts/tools/auto-auditor.py`
* **Amacı:** Kurulum sırasında dosya sistemindeki hash değişikliklerini yakalayıp `logs/analysis-results/logla.log` dosyasına kaydetmek.
