import 'dart:io';

// List<String> antrian = [];
List<Map<String, dynamic>> antrian = [];
void main() {
  while (true) {
  print('===== SISTEM CUCI MOBIL =====');
  print('1. Tambah pelanggan');
  print('2. Tampilkan antrian');
  print('3. Keluar');
  print('4. Lihat jumlah pelanggan');
  print('5. Ubah status pencucian');
  print('6. Hapus antrian pelanggan');

  stdout.write('Pilih menu: ');
  String pilihan = stdin.readLineSync() ?? '';

  switch (pilihan) {
    case '1':
      // print('Menambahkan pelanggan...');
      stdout.write('Masukkan nama pelanggan: ');
      String namaplg = stdin.readLineSync() ?? '';

      stdout.write('Masukkan nomor plat kendaraan: ');
      String plat = stdin.readLineSync() ?? '';

      stdout.write('Masukkan jenis mobil: ');
      String jenismobil = stdin.readLineSync() ?? '';

      Map<String, dynamic> pelanggan = {
        'namaplg': namaplg,
        'plat': plat,
        'jenis': jenismobil,
        'status': 'Menunggu',
      };

      antrian.add(pelanggan);

      print('$namaplg berhasil ditambahkan');
      break;
      
    
  case '2':
    print('\n=== DAFTAR ANTRIAN ===');

    if (antrian.isEmpty) {
      print('Belum ada pelanggan.');
    } else {
      for (int i = 0; i < antrian.length; i++) {
        print('\nPelanggan ke-${i + 1}');
        print('Nama   : ${antrian[i]['namaplg']}');
        print('Plat   : ${antrian[i]['plat']}');
        print('Jenis  : ${antrian[i]['jenis']}');
        print('Status : ${antrian[i]['status']}');
      }
    }
  break;

    // case '2':
    //   // print('Menampilkan antrian...');
    //   print('\n==== DAFTAR ANTRIAN ===');

    //   for (Map<String, dynamic> pelanggan in antrian) {
    //   print('Nama   : ${pelanggan['nama']}');
    //   print('Plat   : ${pelanggan['plat']}');
    //   print('Jenis  : ${pelanggan['jenis']}');
    //   print('Status : ${pelanggan['status']}');
    //   print('----------------------');
    // }
    // break;

    case '3':
      print('Program selesai.');
      // break;
      return;

    case '4':
      print('Jumlah pelanggan: ${antrian.length}');
      break;

    case '5':
      if(antrian.isEmpty) {
        print('Belum ada pelanggan dalam antrian');
        break;
      }

      print('\n==== PILIH PELANGGAN ====');

      for (int i = 0; i < antrian.length; i++) {
        print('${i + 1}. ${antrian[i]['namaplg']} - ${antrian[i]['status']}');
      }

      stdout.write('Pilih nomor pelanggan: ');
      int nomor = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

      if (nomor >= 1 && nomor <= antrian.length) {
        stdout.write('Status baru (1. Sedang dicuci, 2. Selesai): ');
        String statusPilihan = stdin.readLineSync() ?? '';

        if (statusPilihan == '1') {
          antrian[nomor - 1]['status'] = 'Sedang dicuci';
          print('Status berhasil diubah');
        } else if (statusPilihan =='2') {
          antrian[nomor - 1]['status'] = 'Selesai';
          print('Status berhasil diubah');
        } else {
          print('Pilihan status tidak valid');
        }
      } else {
        print('Nomor pelanggan tidak valid');
      }
    break;

    case '6':
      if (antrian.isEmpty) {
        print('Belum ada pelanggan dalam antrian');
        break;
      }

      print('\n==== Hapus Antrian Pelanggan ====');

      for (int i = 0; i < antrian.length; i++) {
        print('${i + 1}. ${antrian[i]['namaplg']}');
      }

      stdout.write('Pilih nomor pelanggan yang ingin dihapus: ');
      int nomor = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

      if (nomor >= 1 && nomor <= antrian.length) {
        String namaplg = antrian[nomor -1]['namaplg'];

        antrian.removeAt(nomor -1);

        print('$namaplg berhasil dihapus dari antrian');
      } else {
        print('Nomor pelanggan tidak valid');
      }
      break;

    default:
      print('Pilihan tidak valid.');

    }

  // print('Pilihan anda adalah $pilihan');
  }
}