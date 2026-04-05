use capstone::prelude::*;

fn main() {
    // Analiz edilecek örnek "Makine Kodu" (Raw Opcodes)
    // Bu baytlar aslında: "mov eax, 0x1234; add eax, ebx; ret" komutlarıdır.
    let code = [0xB8, 0x34, 0x12, 0x00, 0x00, 0x03, 0xC3, 0xC3];

    // Capstone motorunu x86_64 mimarisi için başlatıyoruz
    let cs = Capstone::new()
        .x86()
        .mode(arch::x86::ArchMode::Mode64)
        .build()
        .expect("Capstone başlatılamadı!");

    println!("--- EZEL KOMUT ÇEVİRİCİ (DISASSEMBLER) ---");
    println!("Makine Kodu: {:02X?}\n", code);

    // Çeviri işlemi (Disassemble)
    let insns = cs.disasm_all(&code, 0x1000)
        .expect("Çeviri başarısız!");

    for i in insns.as_ref() {
        println!("0x{:x}:  {}  {}", i.address(), i.mnemonic().unwrap(), i.op_str().unwrap());
    }
}
