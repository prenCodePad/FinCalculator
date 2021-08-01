class ScheduledEMI {
  DateTime? installmentDate;
  double interest;
  double principal;
  double outstandingBalance;

  ScheduledEMI({
    this.installmentDate,
    this.interest = 0,
    this.principal = 0,
    this.outstandingBalance = 0,
  });
}
