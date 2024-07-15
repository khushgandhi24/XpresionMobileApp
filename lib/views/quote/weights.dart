enum Weights {
  lessThanOne("< 1 KG"),
  oneToFour("1 - 4 KG"),
  fiveToNine("5 - 9 KG"),
  tentoFourteen("10 - 14 KG"),
  fifteenToNineTeen("15 - 19 KG"),
  twentyToTwentyNine("20 - 29 KG"),
  thirtyToFifty("30 - 50 KG"),
  fiftyOnePlus("51 + KG");

  const Weights(this.val);

  final String val;
}