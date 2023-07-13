class TicketModel{
  final String name;
  final String age;
  final String gender;
  final String seatno;
  final String totalamount;
  final String dfrom;
  final String dto;
  final String busname;

  TicketModel({
    this.name,
    this.age,
    this.gender,
    this.seatno,
    this.totalamount,
    this.dfrom,
    this.dto,
    this.busname
  });

  factory TicketModel.fromJson(Map<String,dynamic> json){
    return TicketModel (
      name: json['name'] ?? "",
      age: json['age'] ?? "",
      gender: json['gender'] ?? "",
      seatno: json['seatno'] ?? "",
      totalamount: json['totalamount'] ?? "",
      dfrom: json['dfrom'] ?? "",
      dto: json['dto'] ?? "",
      busname: json['busname'] ?? "",
    );
  }
  

  Map<String,dynamic> toJson(){
    return{
      'name':name ?? "",
      'Age' : age ?? "",
      'Gender' :  gender ?? "",
      'Seatno' : seatno ?? "",
      'Totalamount' : totalamount ?? "",
      'Dfrom' : dfrom ?? "",
      'Dto' : dto ?? "",
      'Busname' : busname ?? "",
    };
  }


}
