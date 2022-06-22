//We can use Mockito package to mock data as well

class TestData {
  static Map<String, dynamic> successJson = {
    'value': [
      {
        'name': 'Amjad',
        'accountnumber': 'Amj2k18',
        'address1_stateorprovince': 'KP',
        'statecode': 0,
      },
      {
        'name': 'Khan',
        'accountnumber': 'Khan007',
        'address1_stateorprovince': 'KP',
        'statecode': 1,
      },
      {
        'name': 'John',
        'accountnumber': 'RANDOM007',
        'address1_stateorprovince': 'NY',
        'statecode': 0,
      },
    ]
  };

  static Map<String, dynamic> failureJson = {'value': 'invalid'};
}
