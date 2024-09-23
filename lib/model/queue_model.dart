class Queue {
  final int no;
  final int pax;
  final String customerName;
  final String? customerPhone; // Nullable, bisa kosong
  final String storeName;
  final int dateIn; // Tanggal dalam format timestamp
  final int? dateConfirm; // Nullable, bisa kosong
  final String? storeId; // Nullable
  final int id;
  final bool currentCustomer;

  Queue({
    required this.no,
    required this.pax,
    required this.customerName,
    this.customerPhone,
    required this.storeName,
    required this.dateIn,
    this.dateConfirm,
    this.storeId,
    required this.id,
    required this.currentCustomer,
  });

  // Konversi dari JSON ke objek Queue
  factory Queue.fromJson(Map<String, dynamic> json) {
    return Queue(
      no: json['no'] as int,
      pax: json['pax'] as int,
      customerName: json['customerName'] as String,
      customerPhone: json['customerPhone'] as String?,
      storeName: json['storeName'] as String,
      dateIn: json['dateIn'] as int,
      dateConfirm: json['dateConfirm'] != null ? json['dateConfirm'] as int : null,
      storeId: json['storeId'] as String?,
      id: json['id'] as int,
      currentCustomer: json['currentCustomer'] as bool,
    );
  }

  // Konversi dari objek Queue ke JSON (opsional)
  Map<String, dynamic> toJson() {
    return {
      'no': no,
      'pax': pax,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'storeName': storeName,
      'dateIn': dateIn,
      'dateConfirm': dateConfirm,
      'storeId': storeId,
      'id': id,
      'currentCustomer': currentCustomer,
    };
  }

  // Metode untuk mengonversi list JSON menjadi list Queue
  static List<Queue> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Queue.fromJson(json as Map<String, dynamic>)).toList();
  }
}
