#!/usr/bin/env python3
import os
import hashlib
import time

LOG_FILE = "logs/analysis-results/logla.log"
WATCH_DIR = "/tmp/vaultwarden_sandbox"

def get_hash(filepath):
    hasher = hashlib.md5()
    try:
        with open(filepath, 'rb') as afile:
            buf = afile.read()
            hasher.update(buf)
        return hasher.hexdigest()
    except Exception:
        return None

print(f"[*] Denetçi başlatıldı. {WATCH_DIR} izleniyor...")
# Temel izleme kaydı
with open(LOG_FILE, "a") as log:
    log.write(f"[{time.ctime()}] Auditor başlatıldı. İzleme dizini: {WATCH_DIR}\n")
