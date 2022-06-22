import 'dart:convert';

class Account {
  String name;
  String? accountnumber;
  String? address;
  int? statecode;
  Account({
    required this.name,
    required this.accountnumber,
    required this.address,
    required this.statecode,
  });

  Account copyWith({
    String? name,
    String? accountnumber,
    String? address,
    int? statecode,
  }) {
    return Account(
      name: name ?? this.name,
      accountnumber: accountnumber ?? this.accountnumber,
      address: address ?? this.address,
      statecode: statecode ?? this.statecode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'accountnumber': accountnumber,
      'address1_stateorprovince': address,
      'statecode': statecode,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      name: map['name'],
      accountnumber: map['accountnumber'],
      address: map['address1_stateorprovince'],
      statecode: map['statecode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source));

  List<Object?> get props => [name, accountnumber, address, statecode];
}
