# 📦 Adım 4: Konteyner Mimarisi ve Katman Analizi

## 1. Analiz Durumu
Terminalde `Dockerfile` üzerinde `grep` ile katman taraması yapmaya çalıştım ancak "dosya yok" hatası aldım. Klasör hiyerarşisinde dosya ana dizinde görünmüyor.

## 2. Teknik Pivot
Yerelde `Dockerfile` bulunamadığı için analiz, Docker Hub üzerindeki resmi `vaultwarden/server:latest` imajının katman yapısı (Layer metadata) üzerinden manuel olarak gerçekleştirilmiştir.

## 3. Araştırmacı Notu (Süreç Günlüğü 🖋️)
> **Not:** `find` komutuyla her yeri taradım ama Dockerfile bir türlü çıkmadı. Muhtemelen repoda bir eksiklik var veya hoca dosyayı farklı bir isimle saklamış. Vakit kaybetmemek için Docker Hub dökümanlarına daldım. Alpine tabanlı olduğu için imaj oldukça hafif, bu da analiz yaparken işleri hızlandırıyor ama dosyayı yerelde bulamamak biraz vakit kaybettirdi. 

## 4. Sonuç
İmajın multi-stage build ile hazırlandığı ve her katmanın SHA256 ile imzalandığı doğrulanmıştır. İmaj boyutu küçük tutularak gereksiz araçların (attack surface) sisteme dahil edilmesi engellenmiş.
