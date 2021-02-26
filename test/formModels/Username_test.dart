import 'package:app/formModels/PhoneNumber.dart';
import 'package:app/formModels/Slug.dart';
import 'package:app/formModels/Username.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("Username Model", () {
    test("Doit retouner une erreur", () async {
      // ARRANGE
      Username username = Username.dirty();

      // ACT
      bool res = username.valid;

      // ASSERT
      expect(res, false);
    });

    test("Doit être un success", () async {
      // ARRANGE
      Username username = Username.dirty('john doe');

      // ACT
      bool res = username.valid;

      // ASSERT
      expect(res, true);
    });
  });
}
