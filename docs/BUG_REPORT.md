# 🐞 [BUG-001] Disassembler Unhandled Opcode Panic

## Tanım
Rust tabanlı Disassembler aracımız, Vaultwarden binary dosyası içindeki "obfuscated" (kasıtlı olarak gizlenmiş/şifrelenmiş) veya geçersiz byte dizilimleriyle (opcode) karşılaştığında, bu satırları atlamak yerine bellek okuma hatası (Panic) vererek çalışmayı durdurmaktadır.

## Etki
Statik analiz süreci sekteye uğramakta ve analiz otomasyonu (Denial of Service) kesilmektedir.

## Yeniden Üretme (Steps to Reproduce)
1. Hedef binary içine kasıtlı olarak anlamsız bir hex değeri (`0xFF 0xFF`) enjekte edilir.
2. `cargo run` ile disassembler başlatılır.
3. Araç, tanımsız opcode'u işlemeye çalışırken `thread 'main' panicked` hatası vererek çöker.

## Çözüm Önerisi (Fix)
Capstone motoruna gönderilen byte dizilerini işlerken `unwrap()` kullanmak yerine `match` ile hata yönetimi (Error Handling) yapılmalı ve geçersiz opcode'lar atlanarak (skip) analize devam edilmelidir.
