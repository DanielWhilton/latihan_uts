import 'dart:io';

List<Map<String, dynamic>> kamar = [
  {'nomor': 101, 'tipe': 'Standard', 'harga': 250000, 'tersedia': true},
  {'nomor': 102, 'tipe': 'Deluxe', 'harga': 400000, 'tersedia': true},
  {'nomor': 103, 'tipe': 'Suite', 'harga': 700000, 'tersedia': true},
  {'nomor': 201, 'tipe': 'Deluxe', 'harga': 400000, 'tersedia': true},
];

List<Map<String, dynamic>> reservasi = [];
int nomorReservasi = 1;

String input(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync() ?? '';
}

void lihatKamar() {
  for (var k in kamar) {
    print(
      "Kamar ${k['nomor']} | ${k['tipe']} | "
      "Rp${k['harga']}/malam | "
      "${k['tersedia'] ? 'Tersedia' : 'Terisi'}",
    );
  }
}

void pesanKamar() {
  lihatKamar();

  int nomor = int.tryParse(input('Nomor kamar: ')) ?? 0;
  int index = kamar.indexWhere((k) => k['nomor'] == nomor);

  if (index == -1 || kamar[index]['tersedia'] != true) {
    print('Kamar tidak ditemukan atau sudah terisi.');
    return;
  }

  String nama = input('Nama tamu: ');
  int malam = int.tryParse(input('Jumlah malam: ')) ?? 0;

  if (nama.trim().isEmpty || malam <= 0) {
    print('Data reservasi tidak valid.');
    return;
  }

  int total = kamar[index]['harga'] * malam;

  kamar[index]['tersedia'] = false;

  reservasi.add({
    'id': nomorReservasi++,
    'nomorKamar': nomor,
    'nama': nama,
    'malam': malam,
    'total': total,
    'dibayar': false,
  });

  print('Reservasi berhasil. Total: Rp$total');
}

void lihatReservasi() {
  if (reservasi.isEmpty) {
    print('Belum ada reservasi.');
    return;
  }

  for (var r in reservasi) {
    print(
      "ID ${r['id']} | Kamar ${r['nomorKamar']} | "
      "${r['nama']} | ${r['malam']} malam | "
      "Rp${r['total']} | ${r['dibayar'] ? 'Lunas' : 'Belum bayar'}",
    );
  }
}

void pembayaran() {
  int id = int.tryParse(input('ID reservasi: ')) ?? 0;
  int index = reservasi.indexWhere((r) => r['id'] == id);

  if (index == -1) {
    print('Reservasi tidak ditemukan.');
    return;
  }

  if (reservasi[index]['dibayar']) {
    print('Reservasi sudah dibayar.');
    return;
  }

  int total = reservasi[index]['total'];
  int bayar = int.tryParse(input('Total Rp$total. Bayar: Rp')) ?? 0;

  if (bayar < total) {
    print('Uang tidak cukup.');
    return;
  }

  reservasi[index]['dibayar'] = true;
  print('Pembayaran berhasil. Kembalian: Rp${bayar - total}');
}

void checkout() {
  int nomor = int.tryParse(input('Nomor kamar: ')) ?? 0;
  int index = reservasi.indexWhere((r) => r['nomorKamar'] == nomor);

  if (index == -1) {
    print('Reservasi tidak ditemukan.');
    return;
  }

  if (!reservasi[index]['dibayar']) {
    print('Pembayaran harus diselesaikan sebelum checkout.');
    return;
  }

  int indexKamar = kamar.indexWhere((k) => k['nomor'] == nomor);
  kamar[indexKamar]['tersedia'] = true;

  reservasi.removeAt(index);
  print('Checkout berhasil.');
}

void batalkanReservasi() {
  int id = int.tryParse(input('ID reservasi: ')) ?? 0;
  int index = reservasi.indexWhere((r) => r['id'] == id);

  if (index == -1) {
    print('Reservasi tidak ditemukan.');
    return;
  }

  int nomor = reservasi[index]['nomorKamar'];
  int indexKamar = kamar.indexWhere((k) => k['nomor'] == nomor);

  kamar[indexKamar]['tersedia'] = true;
  reservasi.removeAt(index);

  print('Reservasi berhasil dibatalkan.');
}

void main() {
  while (true) {
    print('\n=== SISTEM HOTEL ===');
    print('1. Lihat kamar');
    print('2. Pesan kamar');
    print('3. Lihat reservasi');
    print('4. Pembayaran');
    print('5. Checkout');
    print('6. Batalkan reservasi');
    print('0. Keluar');

    switch (input('Pilih menu: ')) {
      case '1':
        lihatKamar();
        break;
      case '2':
        pesanKamar();
        break;
      case '3':
        lihatReservasi();
        break;
      case '4':
        pembayaran();
        break;
      case '5':
        checkout();
        break;
      case '6':
        batalkanReservasi();
        break;
      case '0':
        return;
      default:
        print('Pilihan tidak valid.');
    }
  }
}