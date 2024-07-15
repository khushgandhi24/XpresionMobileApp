enum ReportsList {

  awbHold('AWB No Hold UnHold'),
  dailyReport('Daily Report'),
  mis('MIS Report'),
  ledger('Ledger Details Report'),
  vendorAwb('Vendor AWB Report');

  const ReportsList(this.val);

  final String val;
}