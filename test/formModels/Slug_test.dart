import 'package:app/formModels/Slug.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("Slug Model", () {
    test("Doit retouner une erreur", () async {
      // ARRANGE
      Slug slug = Slug.dirty();

      // ACT
      bool res = slug.valid;

      // ASSERT
      expect(res, false);
    });

    test("Doit retourner une error la chaine contient des espaces", () async {
      // ARRANGE
      Slug slug = Slug.dirty('john doe');

      // ACT
      bool res = slug.valid;

      // ASSERT
      expect(res, false);
    });

    test(
        "Doit retourner une error avec la chaine contient des chaine en majuscule",
        () async {
      // ARRANGE
      Slug slug = Slug.dirty('john-DOE');

      // ACT
      bool res = slug.valid;

      // ASSERT
      expect(res, false);
    });

    test("Doit retourner un succes", () async {
      // ARRANGE
      Slug slug = Slug.dirty('john-doe');

      // ACT
      bool res = slug.valid;

      // ASSERT
      expect(res, true);
    });
  });
}
