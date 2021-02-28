import 'package:app/formModels/Password.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("Password model", () {
    test("Doit retouner si aucun mot de passe est saisi", () {
      // ARRANGE
      Password password = Password.dirty();

      // ACT
      bool res = password.valid;

      // ASSERT
      expect(res, false);
    });

    test(
        "Doit retouner une erreur si le mot de passe contient moins de 6 caractères",
        () {
      // ARRANGE
      Password password = Password.dirty('12345');

      // ACT
      bool res = password.valid;

      // ASSERT
      expect(res, false);
    });

    test("Doit retourner un succès", () {
      // ARRANGE
      Password password = Password.dirty('123456');

      // ACT
      bool res = password.valid;

      // ASSERT
      expect(res, true);
    });
  });
}
