
import 'dart:io';

// SISTEM BANK SEDERHANA
// Fitur: Registrasi, Login, Cek Saldo, Setor Tunai,
// Tarik Tunai, Transfer, dan Riwayat Transaksi.

List<Map<String, dynamic>> daftarRekening = [];
int nomorTransaksi = 1;

// Fungsi untuk menerima input teks.
String input(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync()?.trim() ?? '';
}

// Fungsi untuk menerima input angka bulat yang valid.
int inputAngka(String pesan) {
  while (true) {
    stdout.write(pesan);
    String teks = stdin.readLineSync()?.trim() ?? '';
    int? angka = int.tryParse(teks);

    if (angka != null && angka >= 0) {
      return angka;
    }

    print('Input harus berupa angka nol atau lebih.');
  }
}

// Mencari rekening berdasarkan nomor rekening.
Map<String, dynamic>? cariRekening(String nomor) {
  for (var rekening in daftarRekening) {
    if (rekening['nomor'] == nomor) {
      return rekening;
    }
  }
  return null;
}

// Mencatat transaksi ke riwayat rekening.
void catatTransaksi(
  Map<String, dynamic> rekening,
  String jenis,
  int jumlah,
  String keterangan,
) {
  rekening['riwayat'].add({
    'id': nomorTransaksi++,
    'jenis': jenis,
    'jumlah': jumlah,
    'keterangan': keterangan,
    'waktu': DateTime.now().toString(),
  });
}

// REGISTRASI REKENING
void registrasiRekening() {
  print('\n=== REGISTRASI REKENING ===');

  String nama = input('Nama lengkap: ');

  if (nama.isEmpty) {
    print('Nama tidak boleh kosong.');
    return;
  }

  String pin = input('Buat PIN (4-6 digit): ');

  if (!RegExp(r'^\d{4,6}$').hasMatch(pin)) {
    print('PIN harus terdiri dari 4-6 digit angka.');
    return;
  }

  String nomor =
      (daftarRekening.length + 1).toString().padLeft(6, '0');

  Map<String, dynamic> rekening = {
    'nomor': nomor,
    'nama': nama,
    'pin': pin,
    'saldo': 0,
    'riwayat': <Map<String, dynamic>>[],
  };

  daftarRekening.add(rekening);

  catatTransaksi(
    rekening,
    'REGISTRASI',
    0,
    'Rekening berhasil dibuat',
  );

  print('\nRegistrasi berhasil!');
  print('Nama          : $nama');
  print('Nomor rekening: $nomor');
  print('Saldo awal    : Rp0');
}

// LOGIN NASABAH
Map<String, dynamic>? loginNasabah() {
  print('\n=== LOGIN NASABAH ===');

  String nomor = input('Nomor rekening: ');
  String pin = input('PIN: ');

  var rekening = cariRekening(nomor);

  if (rekening == null || rekening['pin'] != pin) {
    print('Nomor rekening atau PIN salah.');
    return null;
  }

  print('Login berhasil. Selamat datang, ${rekening['nama']}!');
  return rekening;
}

// CEK SALDO
void cekSaldo(Map<String, dynamic> rekening) {
  print('\n=== CEK SALDO ===');
  print('Nama           : ${rekening['nama']}');
  print('Nomor rekening : ${rekening['nomor']}');
  print('Saldo          : Rp${rekening['saldo']}');
}

// SETOR TUNAI
void setorTunai(Map<String, dynamic> rekening) {
  print('\n=== SETOR TUNAI ===');

  int jumlah = inputAngka('Jumlah setoran: Rp');

  if (jumlah <= 0) {
    print('Setoran harus lebih dari Rp0.');
    return;
  }

  rekening['saldo'] = rekening['saldo'] + jumlah;

  catatTransaksi(
    rekening,
    'SETOR TUNAI',
    jumlah,
    'Setoran tunai berhasil',
  );

  print('Setoran berhasil!');
  print('Saldo sekarang: Rp${rekening['saldo']}');
}

// TARIK TUNAI
void tarikTunai(Map<String, dynamic> rekening) {
  print('\n=== TARIK TUNAI ===');

  int jumlah = inputAngka('Jumlah penarikan: Rp');

  if (jumlah <= 0) {
    print('Penarikan harus lebih dari Rp0.');
    return;
  }

  if (jumlah > rekening['saldo']) {
    print('Saldo tidak mencukupi.');
    return;
  }

  rekening['saldo'] = rekening['saldo'] - jumlah;

  catatTransaksi(
    rekening,
    'TARIK TUNAI',
    jumlah,
    'Penarikan tunai berhasil',
  );

  print('Penarikan berhasil!');
  print('Saldo sekarang: Rp${rekening['saldo']}');
}

// TRANSFER ANTAR REKENING
void transfer(Map<String, dynamic> pengirim) {
  print('\n=== TRANSFER ===');

  String nomorTujuan = input('Nomor rekening tujuan: ');
  var penerima = cariRekening(nomorTujuan);

  if (penerima == null) {
    print('Rekening tujuan tidak ditemukan.');
    return;
  }

  if (penerima['nomor'] == pengirim['nomor']) {
    print('Tidak dapat transfer ke rekening sendiri.');
    return;
  }

  print('Nama penerima: ${penerima['nama']}');

  String konfirmasi =
      input('Lanjutkan transfer? (y/n): ').toLowerCase();

  if (konfirmasi != 'y') {
    print('Transfer dibatalkan.');
    return;
  }

  int jumlah = inputAngka('Jumlah transfer: Rp');

  if (jumlah <= 0) {
    print('Transfer harus lebih dari Rp0.');
    return;
  }

  if (jumlah > pengirim['saldo']) {
    print('Saldo tidak mencukupi.');
    return;
  }

  // Mengurangi saldo pengirim.
  pengirim['saldo'] = pengirim['saldo'] - jumlah;

  // Menambahkan saldo penerima.
  penerima['saldo'] = penerima['saldo'] + jumlah;

  catatTransaksi(
    pengirim,
    'TRANSFER KELUAR',
    jumlah,
    'Transfer ke ${penerima['nomor']} (${penerima['nama']})',
  );

  catatTransaksi(
    penerima,
    'TRANSFER MASUK',
    jumlah,
    'Transfer dari ${pengirim['nomor']} (${pengirim['nama']})',
  );

  print('Transfer berhasil!');
  print('Saldo sekarang: Rp${pengirim['saldo']}');
}

// RIWAYAT TRANSAKSI
void riwayatTransaksi(Map<String, dynamic> rekening) {
  print('\n=== RIWAYAT TRANSAKSI ===');

  List riwayat = rekening['riwayat'];

  if (riwayat.isEmpty) {
    print('Belum ada transaksi.');
    return;
  }

  for (var transaksi in riwayat) {
    print('------------------------------');
    print('ID         : ${transaksi['id']}');
    print('Jenis      : ${transaksi['jenis']}');
    print('Jumlah     : Rp${transaksi['jumlah']}');
    print('Keterangan : ${transaksi['keterangan']}');
    print('Waktu      : ${transaksi['waktu']}');
  }

  print('------------------------------');
}

// MENU NASABAH
void menuNasabah(Map<String, dynamic> rekening) {
  while (true) {
    print('\n==============================');
    print('          MENU NASABAH');
    print('==============================');
    print('Nama: ${rekening['nama']}');
    print('1. Cek saldo');
    print('2. Setor tunai');
    print('3. Tarik tunai');
    print('4. Transfer');
    print('5. Riwayat transaksi');
    print('0. Logout');

    String pilihan = input('Pilih menu: ');

    switch (pilihan) {
      case '1':
        cekSaldo(rekening);
        break;
      case '2':
        setorTunai(rekening);
        break;
      case '3':
        tarikTunai(rekening);
        break;
      case '4':
        transfer(rekening);
        break;
      case '5':
        riwayatTransaksi(rekening);
        break;
      case '0':
        print('Logout berhasil.');
        return;
      default:
        print('Pilihan tidak tersedia.');
    }
  }
}

// DAFTAR REKENING UNTUK DEMONSTRASI
void tampilkanSemuaRekening() {
  print('\n=== DAFTAR REKENING ===');

  if (daftarRekening.isEmpty) {
    print('Belum ada rekening terdaftar.');
    return;
  }

  for (var rekening in daftarRekening) {
    print(
      'Nomor: ${rekening['nomor']} | '
      'Nama: ${rekening['nama']} | '
      'Saldo: Rp${rekening['saldo']}',
    );
  }
}

// PROGRAM UTAMA
void main() {
  while (true) {
    print('\n==============================');
    print('     SISTEM BANK SEDERHANA');
    print('==============================');
    print('1. Registrasi rekening');
    print('2. Login nasabah');
    print('3. Lihat semua rekening (demo)');
    print('0. Keluar');

    String pilihan = input('Pilih menu: ');

    switch (pilihan) {
      case '1':
        registrasiRekening();
        break;

      case '2':
        var rekening = loginNasabah();

        if (rekening != null) {
          menuNasabah(rekening);
        }
        break;

      case '3':
        tampilkanSemuaRekening();
        break;

      case '0':
        print('Terima kasih telah menggunakan sistem bank.');
        return;

      default:
        print('Pilihan tidak tersedia.');
    }
  }
}