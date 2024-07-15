enum InvoiceYear {

  twentyThreeFour('2023 - 2024'),
  twentyTwoThree('2022 - 2023'),
  twentyOneTwo('2021 - 2022'),
  twentyZeroOne('2020 - 2021');

  const InvoiceYear(this.year);

  final String year;

}

enum InvoiceCompany {

  busisoft('BusiSoft'),
  busisoftOne('BusiSoft 1');

  const InvoiceCompany(this.name);

  final String name;

}