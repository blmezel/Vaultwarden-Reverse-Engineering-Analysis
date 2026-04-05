use capstone::prelude::*;

fn main() {
    let code = [0xB8, 0x34, 0x12, 0x00, 0x00, 0x03, 0xC3, 0xC3];

    let cs = Capstone::new()
        .x86()
        .mode(arch::x86::ArchMode::Mode64)
        .build()
        .expect("Capstone başlatılamadı!");

    println!("--- EZEL KOMUT ÇEVİRİCİ (DISASSEMBLER) ---");
    println!("Makine Kodu: {:02X?}\n", code);

    let insns = cs.disasm_all(&code, 0x1000)
        .expect("Çeviri başarısız!");

    for i in insns.as_ref() {
        println!("0x{:x}:  {}  {}", i.address(), i.mnemonic().unwrap(), i.op_str().unwrap());
    }
}
