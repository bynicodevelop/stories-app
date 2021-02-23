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

  group("PhoneNumber Model", () {
    test("Doit retouner une erreur avec un valeur vide", () async {
      // ARRANGE
      PhoneNumber phoneNumber = PhoneNumber.dirty();

      // ACT
      bool res = phoneNumber.valid;

      // ASSERT
      expect(res, false);
    });

    test("Doit retouner une erreur (33601010101)", () async {
      // ARRANGE
      PhoneNumber phoneNumber = PhoneNumber.dirty('33601010101');

      // ACT
      bool res = phoneNumber.valid;

      // ASSERT
      expect(res, false);
    });

    test("Doit retouner une erreur (33601010101)", () async {
      // ARRANGE
      PhoneNumber phoneNumber = PhoneNumber.dirty('+336010101');

      // ACT
      bool res = phoneNumber.valid;

      // ASSERT
      expect(res, false);
    });

    test("Doit retouner une erreur (+3360101010100)", () async {
      // ARRANGE
      PhoneNumber phoneNumber = PhoneNumber.dirty('+3360101010100');

      // ACT
      print(phoneNumber.error);
      bool res = phoneNumber.valid;

      // ASSERT
      expect(res, false);
    });

    test("Doit retouner une erreur (+3360101010)", () async {
      // ARRANGE
      PhoneNumber phoneNumber = PhoneNumber.dirty('+3360101010');

      // ACT
      bool res = phoneNumber.valid;

      // ASSERT
      expect(res, false);
    });

    test("Doit un success", () async {
      // ARRANGE
      PhoneNumber phoneNumber = PhoneNumber.dirty('+33601010101');

      // ACT
      bool res = phoneNumber.valid;

      // ASSERT
      expect(res, true);
    });
  });
}
