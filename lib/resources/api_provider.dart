import 'package:dartz/dartz.dart';
import 'package:dataverse/models/account.dart';
import 'package:dataverse/models/response.dart';
import 'package:http/http.dart' show Client;

class ApiProvider {
  Client client = Client();
  Future<Either<Failure, List<Account>>> fetchAccounts(
      String url, Map<String, String> header) async {
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: header,
      );

      if (response.statusCode == 200) {
        final _accounts = ApiResponse.fromJson(response.body).value;
        return Right(_accounts);
      } else {
        return Left(Failure('Something went wrong!'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
