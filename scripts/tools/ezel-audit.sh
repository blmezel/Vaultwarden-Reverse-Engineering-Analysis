#!/bin/bash

echo "================================================="
echo "   🛡️ EZEL-AUDIT OTOMATİK GÜVENLİK TARAYICISI 🛡️   "
echo "================================================="
echo "Başlatılıyor..."
sleep 1

# 1. Tehlikeli Yetki Kontrolü
echo -e "\n[*] 1. AŞAMA: Tehlikeli Dosya İzinleri Taranıyor (777 yetkisi)..."
TEHLIKELI_DOSYALAR=$(find . -type f -perm 0777 2>/dev/null | wc -l)
if [ "$TEHLIKELI_DOSYALAR" -gt 0 ]; then
    echo "[!] DİKKAT: Sistemde herkesin okuyup yazabileceği $TEHLIKELI_DOSYALAR adet güvensiz dosya bulundu!"
else
    echo "[+] Temiz: 0777 yetkili dosya bulunamadı."
fi

# 2. Veritabanı Kalıntı (Forensics) Kontrolü
echo -e "\n[*] 2. AŞAMA: SQLite WAL/SHM Kalıntıları Aranıyor..."
KALINTI=$(find . -name "*.db-wal" 2>/dev/null | wc -l)
if [ "$KALINTI" -gt 0 ]; then
    echo "[!] DİKKAT: Diskte silinmemiş veritabanı kalıntıları tespit edildi!"
else
    echo "[+] Temiz: Veritabanı izi bulunamadı."
fi

# 3. Boş Dosya Kontrolü
echo -e "\n[*] 3. AŞAMA: İçi Boş (0 byte) Güvenlik Scriptleri Kontrol Ediliyor..."
BOS_DOSYA=$(find ./scripts/tools -type f -empty 2>/dev/null | wc -l)
if [ "$BOS_DOSYA" -gt 0 ]; then
    echo "[!] KRİTİK: Sistemde $BOS_DOSYA adet içi boş (yazılmamış) script bulundu!"
else
    echo "[+] Temiz: Tüm scriptler dolu."
fi

echo -e "\n================================================="
echo "   TARAMA TAMAMLANDI. LÜTFEN EKSİKLERİ GİDERİN.  "
echo "================================================="
