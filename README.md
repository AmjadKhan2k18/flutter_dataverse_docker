# dataverse

A Flutter project to get, search and show Accounts in flutter application

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


### to build project it's required to update API's in `/lib/resources/config.dart`

```

 - static const url = "yourApiURL";

 - static const version = "9.2";

 - static const webapiurl = "$url/api/data/v" + version + "/";
 - static const clientId = 'clientId';
 - static const azureTenantId = "yourTenantId";  [Lab: how to get tenantId](https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-how-to-find-tenant)
 - static const redirectUrl = 'http://localhost:5050/authRedirect.html';

```


# How to build using docker

### run the following commands
` docker build . -t dataverse_docker `

once it build successfully run this command

`docker run -i -p 5050:5000 -td dataverse_docker`

Now open `localhost:5050` 