import 'package:app/formModels/PhoneNumber.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
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
