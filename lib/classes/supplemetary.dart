import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  final String _name;
  final String _address;
  final String _tin;
  Company(this._name, this._address, this._tin);
  
  String get name {
    return _name;
  }

  String get address {
    return _address;
  }

  String get tin {
    return _tin;
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'tin': tin,
    };
  } 
  factory Company.fromMap(Map<String, dynamic> map) {
  return Company(
    map['name'] as String,
    map['address'] as String,
    map['tin'] as String,
  );
  } 
}


class Details {
  final String _place;
  final String _issuance;
  final DateTime _dateOfSale;
  final DateTime _dateOfPayment;
  final String _id;
  Details(this._place, this._issuance, this._dateOfSale, this._dateOfPayment,
      this._id);
  String get place {
    return _place;
  }

  String get issuance {
    return _issuance;
  }

  DateTime get dateOfSale {
    return _dateOfSale;
  }

  DateTime get dateOfPayment {
    return _dateOfPayment;
  }

  String get id {
    return _id;
  }
  Map<String, dynamic> toMap() {
    return {
      'place': _place,
      'issuance': _issuance,
      'dateOfSale': _dateOfSale,
      'dateOfPayment': _dateOfPayment,
      'id': id
    };
  }
   factory Details.fromMap(Map<String, dynamic> map) {
    
    return Details(
      map['place'] as String,
      map['issuance'] as String,
      (map['dateOfSale'] as Timestamp).toDate(),
      (map['dateOfPayment'] as Timestamp).toDate(),
      map['id'] as String,
    );
  }
}

class Address {
  String street;
  Address(this.street);
}

class Item {
  final double _price;
  final String _name;
  final int _tax;
  final int _quantity;
  Item(this._price, this._name, this._tax, this._quantity);

  String get name {
    return _name;
  }
  double get price {
    return _price;
  }
  int get tax {
    return _tax;
  }
  int get quantity{
    return _quantity;
  }
  Map<String, dynamic> toMap() {
    return {
      'price': _price,
      'name': _name,
      'tax': _tax,
      'quantity': _quantity,
    };
  }
  factory Item.fromMap(Map<String, dynamic> map) {
  return Item(
    map['price'] as double,
    map['name'] as String,
    map['tax'] as int,
    map['quantity'] as int,
  );
}  
}
