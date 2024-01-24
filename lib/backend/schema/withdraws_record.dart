import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/ff/ff_util.dart';

class WithdrawsRecord extends FirestoreRecord {
  WithdrawsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "amount" field.
  int? _amount;
  int get amount => _amount ?? 0;
  bool hasAmount() => _amount != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "user" field.
  String? _user;
  String get user => _user ?? '';
  bool hasUser() => _user != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  void _initializeFields() {
    _amount = castToType<int>(snapshotData['amount']);
    _date = snapshotData['date'] as DateTime?;
    _user = snapshotData['user'] as String?;
    _status = snapshotData['status'] as String?;
    _type = snapshotData['type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('withdraws');

  static Stream<WithdrawsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => WithdrawsRecord.fromSnapshot(s));

  static Future<WithdrawsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => WithdrawsRecord.fromSnapshot(s));

  static WithdrawsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      WithdrawsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static WithdrawsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      WithdrawsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'WithdrawsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is WithdrawsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createWithdrawsRecordData({
  int? amount,
  DateTime? date,
  String? user,
  String? status,
  String? type,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'amount': amount,
      'date': date,
      'user': user,
      'status': status,
      'type': type,
    }.withoutNulls,
  );

  return firestoreData;
}

class WithdrawsRecordDocumentEquality implements Equality<WithdrawsRecord> {
  const WithdrawsRecordDocumentEquality();

  @override
  bool equals(WithdrawsRecord? e1, WithdrawsRecord? e2) {
    return e1?.amount == e2?.amount &&
        e1?.date == e2?.date &&
        e1?.user == e2?.user &&
        e1?.status == e2?.status &&
        e1?.type == e2?.type;
  }

  @override
  int hash(WithdrawsRecord? e) => const ListEquality()
      .hash([e?.amount, e?.date, e?.user, e?.status, e?.type]);

  @override
  bool isValidKey(Object? o) => o is WithdrawsRecord;
}
