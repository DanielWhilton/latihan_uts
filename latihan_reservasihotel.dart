import 'dart:io';

List<Map<String, dynamic>> kamar = [
  {'nomor': 101, 'tipe': 'Standard', 'harga': 250000, 'tersedia': true},
  {'nomor': 102, 'tipe': 'Deluxe', 'harga': 400000, 'tersedia': true},
  {'nomor': 103, 'tipe': 'Suite', 'harga': 700000, 'tersedia': true},
];

List<Map<String, dynamic>> reservasi = [];
int nomorReservasi = 1;

void lihatKamar() {
  for (var k in kamar) {
    print(
      "Kamar ${k['nomor']} | ${k['tipe']} | Rp${k['harga']}/malam | "
      "${k['tersedia'] ? 'Kosong' : 'Terisi'}",
    );
  }
}

void pesanKamar() {
  lihatKamar();

  stdout.write('Nomor kamar: ');
  int nomorKamar = int.parse(stdin.readLineSync()!);

  int index = kamar.indexWhere((k) => k['nomor'] == nomorKamar);

  if (index == -1 || kamar[index]['tersedia'] == false) {
    print('Kamar tidak tersedia.');
    return;
  }

  stdout.write('Nama tamu: ');
  String nama = stdin.readLineSync()!;

  stdout.write('Jumlah malam: ');
  int malam = int.parse(stdin.readLineSync()!);

  int total = kamar[index]['harga'] * malam;

  kamar[index]['tersedia'] = false;

  reservasi.add({
    'id': nomorReservasi++,
    'nomorKamar': nomorKamar,
    'nama': nama,
    'total': total,
  });

  print('Reservasi berhasil. Total: Rp$total');
}

void checkout() {
  stdout.write('Nomor kamar: ');
  int nomorKamar = int.parse(stdin.readLineSync()!);

  int index = reservasi.indexWhere(
    (r) => r['nomorKamar'] == nomorKamar,
  );

  if (index == -1) {
    print('Reservasi tidak ditemukan.');
    return;
  }

  int indexKamar = kamar.indexWhere((k) => k['nomor'] == nomorKamar);
  kamar[indexKamar]['tersedia'] = true;
  reservasi.removeAt(index);

  print('Checkout berhasil.');
}

void main() {
  while (true) {
    print('\n=== SISTEM RESERVASI HOTEL ===');
    print('1. Lihat kamar');
    print('2. Pesan kamar');
    print('3. Checkout');
    print('0. Keluar');
    stdout.write('Pilih: ');

    switch (stdin.readLineSync()) {
      case '1':
        lihatKamar();
      case '2':
        pesanKamar();
      case '3':
        checkout();
      case '0':
        return;
      default:
        print('Pilihan tidak valid.');
    }
  }
}