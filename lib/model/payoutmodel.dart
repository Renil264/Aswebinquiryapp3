class PayoutReportModel {
  final double retailSales;
  final double wholeSales;
  final double onlineSales;
  final double layawaySales;
  final double salesTax;
  final double totalSales;
  final double salesReturns;
  final double voids;
  final double totalSalesWithReturns;
  final double flatComm;
  final double commOnSales;
  final double consignComm;
  final double ccCharges;
  final double adjustments;
  final double receivableTotal;
  final double rentalDues;

  PayoutReportModel({
    required this.retailSales,
    required this.wholeSales,
    required this.onlineSales,
    required this.layawaySales,
    required this.salesTax,
    required this.totalSales,
    required this.salesReturns,
    required this.voids,
    required this.totalSalesWithReturns,
    required this.flatComm,
    required this.commOnSales,
    required this.consignComm,
    required this.ccCharges,
    required this.adjustments,
    required this.receivableTotal,
    required this.rentalDues,
  });

  factory PayoutReportModel.fromJson(Map<String, dynamic> json) {
    return PayoutReportModel(
      retailSales: (json['retailSales'] ?? 0).toDouble(),
      wholeSales: (json['wholeSales'] ?? 0).toDouble(),
      onlineSales: (json['onlineSales'] ?? 0).toDouble(),
      layawaySales: (json['layawaySales'] ?? 0).toDouble(),
      salesTax: (json['salesTax'] ?? 0).toDouble(),
      totalSales: (json['totalSales'] ?? 0).toDouble(),
      salesReturns: (json['salesReturns'] ?? 0).toDouble(),
      voids: (json['voids'] ?? 0).toDouble(),
      totalSalesWithReturns: (json['totalSalesWithReturns'] ?? 0).toDouble(),
      flatComm: (json['flatComm'] ?? 0).toDouble(),
      commOnSales: (json['commOnSales'] ?? 0).toDouble(),
      consignComm: (json['consignComm'] ?? 0).toDouble(),
      ccCharges: (json['ccCharges'] ?? 0).toDouble(),
      adjustments: (json['adjustments'] ?? 0).toDouble(),
      receivableTotal: (json['receivableTotal'] ?? 0).toDouble(),
      rentalDues: (json['rentalDues'] ?? 0).toDouble(),
    );
  }

  factory PayoutReportModel.empty() {
    return PayoutReportModel(
      retailSales: 0,
      wholeSales: 0,
      onlineSales: 0,
      layawaySales: 0,
      salesTax: 0,
      totalSales: 0,
      salesReturns: 0,
      voids: 0,
      totalSalesWithReturns: 0,
      flatComm: 0,
      commOnSales: 0,
      consignComm: 0,
      ccCharges: 0,
      adjustments: 0,
      receivableTotal: 0,
      rentalDues: 0,
    );
  }
}
