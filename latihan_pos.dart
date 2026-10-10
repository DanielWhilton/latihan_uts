import 'dart:io';

Map<String, Map<String, int>> barang = {
  'Beras': {'harga': 15000, 'stok': 20},
  'Minyak': {'harga': 18000, 'stok': 15},
  'Gula': {'harga': 14000, 'stok': 25},
  'Telur': {'harga': 28000, 'stok': 10},
};

Map<String, int> keranjang = {};
int totalPendapatan = 0;
int nomorTransaksi = 1;

String input(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync() ?? '';
}

void lihatBarang() {
  barang.forEach((nama, data) {
    print('$nama | Rp${data['harga']} | Stok: ${data['stok']}');
  });
}

void tambahBarang() {
  String nama = input('Nama barang: ');

  if (nama.trim().isEmpty || barang.containsKey(nama)) {
    print('Nama kosong atau barang sudah tersedia.');
    return;
  }

  int harga = int.tryParse(input('Harga: Rp')) ?? 0;
  int stok = int.tryParse(input('Stok awal: ')) ?? 0;

  if (harga <= 0 || stok < 0) {
    print('Harga atau stok tidak valid.');
    return;
  }

  barang[nama] = {'harga': harga, 'stok': stok};
  print('Barang berhasil ditambahkan.');
}

void tambahKeranjang() {
  lihatBarang();

  String nama = input('Nama barang: ');

  if (!barang.containsKey(nama)) {
    print('Barang tidak ditemukan.');
    return;
  }

  int jumlah = int.tryParse(input('Jumlah: ')) ?? 0;

  if (jumlah <= 0 || jumlah > barang[nama]!['stok']!) {
    print('Jumlah tidak valid atau stok tidak cukup.');
    return;
  }

  keranjang[nama] = (keranjang[nama] ?? 0) + jumlah;
  print('Barang ditambahkan ke keranjang.');
}

int hitungTotal() {
  int total = 0;

  keranjang.forEach((nama, jumlah) {
    total += barang[nama]!['harga']! * jumlah;
  });

  return total;
}

void lihatKeranjang() {
  if (keranjang.isEmpty) {
    print('Keranjang kosong.');
    return;
  }

  keranjang.forEach((nama, jumlah) {
    int subtotal = barang[nama]!['harga']! * jumlah;
    print('$nama x$jumlah = Rp$subtotal');
  });

  print('Total: Rp${hitungTotal()}');
}

void hapusKeranjang() {
  String nama = input('Nama barang: ');

  if (!keranjang.containsKey(nama)) {
    print('Barang tidak ada di keranjang.');
    return;
  }

  keranjang.remove(nama);
  print('Barang dihapus dari keranjang.');
}

void checkout() {
  if (keranjang.isEmpty) {
    print('Keranjang kosong.');
    return;
  }

  lihatKeranjang();

  int total = hitungTotal();
  int bayar =
      int.tryParse(input('Uang pembayaran: Rp')) ?? 0;

  if (bayar < total) {
    print('Uang tidak cukup. Transaksi belum diproses.');
    return;
  }

  keranjang.forEach((nama, jumlah) {
    barang[nama]!['stok'] =
        barang[nama]!['stok']! - jumlah;
  });

  totalPendapatan += total;

  print('\n=== STRUK PEMBAYARAN ===');
  print('Nomor transaksi: $nomorTransaksi');

  keranjang.forEach((nama, jumlah) {
    print('$nama x$jumlah = Rp${barang[nama]!['harga']! * jumlah}');
  });

  print('Total: Rp$total');
  print('Bayar: Rp$bayar');
  print('Kembalian: Rp${bayar - total}');

  nomorTransaksi++;
  keranjang.clear();
}

void laporan() {
  print('\n=== LAPORAN KASIR ===');
  print('Transaksi selesai: ${nomorTransaksi - 1}');
  print('Pendapatan: Rp$totalPendapatan');
  print('Jumlah jenis barang: ${barang.length}');
}

void main() {
  while (true) {
    print('\n=== SISTEM KASIR POS ===');
    print('1. Lihat barang');
    print('2. Tambah barang');
    print('3. Tambah ke keranjang');
    print('4. Lihat keranjang');
    print('5. Hapus dari keranjang');
    print('6. Checkout');
    print('7. Laporan');
    print('0. Keluar');

    switch (input('Pilih menu: ')) {
      case '1':
        lihatBarang();
        break;
      case '2':
        tambahBarang();
        break;
      case '3':
        tambahKeranjang();
        break;
      case '4':
        lihatKeranjang();
        break;
      case '5':
        hapusKeranjang();
        break;
      case '6':
        checkout();
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