// We can also create .env file to avoid pushing it to github for now i keep it in a class to make it easy

class ConfigAPI {
  static const url = 'your url';

  static const version = '9.2';

  static const webapiurl = '$url/api/data/v' + version + '/';
  static const clientId = 'your client id';
  static const azureTenantId = 'your azure tenant id';
  static const redirectUrl = 'http://localhost:5050/authRedirect.html';
}
