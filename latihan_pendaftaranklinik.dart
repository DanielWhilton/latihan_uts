import 'dart:io';

List<Map<String, dynamic>> pasien = [];
int nomorAntrean = 1;

String input(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync() ?? '';
}

void daftarPasien() {
  String nama = input('Nama pasien: ');
  int umur = int.tryParse(input('Umur: ')) ?? -1;
  String keluhan = input('Keluhan: ');

  if (nama.trim().isEmpty || umur < 0 || keluhan.trim().isEmpty) {
    print('Data pasien tidak valid.');
    return;
  }

  print('\n=== PILIH DOKTER ===');
  print('1. Dokter umum - Rp50000');
  print('2. Dokter gigi - Rp100000');
  print('3. Dokter anak - Rp75000');

  int pilihan = int.tryParse(input('Pilih dokter: ')) ?? 0;
  String dokter;
  int biaya;

  switch (pilihan) {
    case 1:
      dokter = 'Dokter umum';
      biaya = 50000;
      break;
    case 2:
      dokter = 'Dokter gigi';
      biaya = 100000;
      break;
    case 3:
      dokter = 'Dokter anak';
      biaya = 75000;
      break;
    default:
      print('Pilihan dokter tidak valid.');
      return;
  }

  pasien.add({
    'nomor': nomorAntrean++,
    'nama': nama,
    'umur': umur,
    'keluhan': keluhan,
    'dokter': dokter,
    'biaya': biaya,
    'status': 'Menunggu',
    'dibayar': false,
  });

  print('Pendaftaran berhasil.');
}

void lihatPasien() {
  if (pasien.isEmpty) {
    print('Belum ada pasien.');
    return;
  }

  for (var p in pasien) {
    print(
      "No.${p['nomor']} | ${p['nama']} | ${p['umur']} tahun | "
      "${p['dokter']} | ${p['keluhan']} | ${p['status']}",
    );
  }
}

void panggilPasien() {
  int index = pasien.indexWhere((p) => p['status'] == 'Menunggu');

  if (index == -1) {
    print('Tidak ada pasien yang menunggu.');
    return;
  }

  pasien[index]['status'] = 'Sedang diperiksa';
  print("Memanggil ${pasien[index]['nama']}.");
}

void selesaikanPemeriksaan() {
  int nomor = int.tryParse(input('Nomor antrean: ')) ?? 0;

  int index = pasien.indexWhere((p) => p['nomor'] == nomor);

  if (index == -1) {
    print('Pasien tidak ditemukan.');
    return;
  }

  if (pasien[index]['status'] != 'Sedang diperiksa') {
    print('Pasien belum sedang diperiksa.');
    return;
  }

  pasien[index]['status'] = 'Selesai diperiksa';
  print('Pemeriksaan selesai.');
}

void pembayaran() {
  int nomor = int.tryParse(input('Nomor antrean: ')) ?? 0;

  int index = pasien.indexWhere((p) => p['nomor'] == nomor);

  if (index == -1) {
    print('Pasien tidak ditemukan.');
    return;
  }

  if (pasien[index]['dibayar']) {
    print('Pasien sudah membayar.');
    return;
  }

  int total = pasien[index]['biaya'];
  int bayar = int.tryParse(input('Biaya Rp$total. Bayar: Rp')) ?? 0;

  if (bayar < total) {
    print('Uang tidak cukup.');
    return;
  }

  pasien[index]['dibayar'] = true;
  print('Pembayaran berhasil. Kembalian: Rp${bayar - total}');
}

void batalkanPendaftaran() {
  int nomor = int.tryParse(input('Nomor antrean: ')) ?? 0;

  int index = pasien.indexWhere((p) => p['nomor'] == nomor);

  if (index == -1) {
    print('Pasien tidak ditemukan.');
    return;
  }

  pasien.removeAt(index);
  print('Pendaftaran berhasil dibatalkan.');
}

void laporan() {
  print('\n=== LAPORAN KLINIK ===');
  print('Total pasien: ${pasien.length}');
  print('Menunggu: ${pasien.where((p) => p['status'] == 'Menunggu').length}');
  print('Sedang diperiksa: ${pasien.where((p) => p['status'] == 'Sedang diperiksa').length}');
  print('Selesai diperiksa: ${pasien.where((p) => p['status'] == 'Selesai diperiksa').length}');
}

void main() {
  while (true) {
    print('\n=== SISTEM KLINIK ===');
    print('1. Daftar pasien');
    print('2. Lihat pasien');
    print('3. Panggil pasien berikutnya');
    print('4. Selesaikan pemeriksaan');
    print('5. Pembayaran');
    print('6. Batalkan pendaftaran');
    print('7. Laporan');
    print('0. Keluar');

    switch (input('Pilih menu: ')) {
      case '1':
        daftarPasien();
        break;
      case '2':
        lihatPasien();
        break;
      case '3':
        panggilPasien();
        break;
      case '4':
        selesaikanPemeriksaan();
        break;
      case '5':
        pembayaran();
        break;
      case '6':
        batalkanPendaftaran();
        break;
      case '7':
        laporan();
        break;
      case '0':
        return;
      default:
        print('Pilihan tidak valid.');
    }
  }
}