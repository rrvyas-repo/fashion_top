class SchoolModel {
  String schoolName = '';
  String schoolAddress = '';
  String schoolContact = '';
  String schoolPinCode = '';
  String schoolContactPerson = '';
  String key = '';

  SchoolModel({
    required this.schoolName,
    required this.schoolContactPerson,
    required this.schoolContact,
    required this.schoolAddress,
    required this.schoolPinCode,
    required this.key,
  });
}

List<SchoolModel> schoolData = [
  // SchoolModel(
  //   schoolName: 'School1',
  //   schoolContactPerson: 'schoolContactPerson1',
  //   schoolContact: '1234567890',
  //   schoolAddress: 'schoolAddress1',
  //   schoolPinCode: '395004',
  //   key:'key',
  // ),
  // SchoolModel(
  //   schoolName: 'School2',
  //   schoolContactPerson: 'schoolContactPerson2',
  //   schoolContact: '1234567890',
  //   schoolAddress: 'schoolAddress2',
  //   schoolPinCode: '395004',
  //   key: 'key',
  // ),
  // SchoolModel(
  //   schoolName: 'School3',
  //   schoolContactPerson: 'schoolContactPerson3',
  //   schoolContact: '1234567890',
  //   schoolAddress: 'schoolAddress3',
  //   schoolPinCode: '395004',
  //   key: 'key',
  // ),
  // School(
  //   schoolName: 'School4',
  //   schoolContactPerson: 'schoolContactPerson4',
  //   schoolContact: '1234567890',
  //   schoolAddress: 'schoolAddress4',
  //   schoolPinCode: '395004',
  // ),
  // School(
  //   schoolName: 'School5',
  //   schoolContactPerson: 'schoolContactPerson5',
  //   schoolContact: '1234567890',
  //   schoolAddress: 'schoolAddress5',
  //   schoolPinCode: '395004',
  // ),
];
