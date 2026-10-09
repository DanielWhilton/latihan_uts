
void main() {
  Map<String, dynamic> pelanggan = {
    'nama': 'Andi',
    'plat': 'KB 1234 AA',
    'jenis': 'SUV',
    'status': 'Menunggu',
  };

  // print(pelanggan['nama']);
  // print(pelanggan['plat']);
  // print(pelanggan['jenis']);
  // print(pelanggan['status']);

  pelanggan['status'] = 'Sedang dicuci';

  print(pelanggan['status']);
}