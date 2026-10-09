
void main() {
  List<Map<String, dynamic>> antrian = [];

  Map<String, dynamic> pelanggan1 = {
    'nama': 'Andi',
    'plat': 'KB 1234 AA',
    'jenis': 'SUV',
    'status': 'Menunggu',
  };

  Map<String, dynamic> pelanggan2 = {
    'nama': 'Budi',
    'plat': 'KB 5678 BB',
    'jenis': 'Sedan',
    'status': 'Menunggu',
  };

  antrian.add(pelanggan1);
  antrian.add(pelanggan2);

  print(antrian[0]['nama']);
  print(antrian[1]['plat']);
}