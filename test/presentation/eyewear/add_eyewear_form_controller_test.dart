import 'package:flutter_test/flutter_test.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';
import 'package:my_eyes/presentation/eyewear/controller/add_eyewear_form_controller.dart';

void main() {
  final tDate = DateTime(2024, 1, 15);

  final tRxWithDates = Prescription(
    id: 'rx1',
    label: 'Current',
    issueDate: tDate,
    rightEye: const EyeMeasurement(
      sphere: -2.5,
      cylinder: -0.75,
      axis: 180,
      addition: 0.5,
      pd: 62.0,
    ),
    leftEye: const EyeMeasurement(
      sphere: -2.25,
      cylinder: -0.5,
      axis: 170,
      addition: 0.5,
      pd: 62.0,
    ),
    updatedAt: tDate,
  );

  final tItem = EyewearItem(
    id: 'e1',
    name: 'Daily Frames',
    category: EyewearCategory.sunglasses,
    updatedAt: tDate,
    selectedOptionIndex: 2,
    prescription: tRxWithDates,
  );

  group('default constructor', () {
    test('initialises with empty controllers and default category', () {
      final form = AddEyewearFormController();
      expect(form.name.text, '');
      expect(form.sphereRight.text, '');
      expect(form.selectedCategory, EyewearCategory.nearSightedGlasses);
      expect(form.selectedOptionIndex, 0);
      form.dispose();
    });

    test('accepts an explicit initial category', () {
      final form = AddEyewearFormController(EyewearCategory.sunglasses);
      expect(form.selectedCategory, EyewearCategory.sunglasses);
      form.dispose();
    });
  });

  group('fromItem constructor', () {
    test('pre-fills name and category from item', () {
      final form = AddEyewearFormController.fromItem(tItem);
      expect(form.name.text, 'Daily Frames');
      expect(form.selectedCategory, EyewearCategory.sunglasses);
      form.dispose();
    });

    test('restores selectedOptionIndex from item', () {
      final form = AddEyewearFormController.fromItem(tItem);
      expect(form.selectedOptionIndex, 2);
      form.dispose();
    });

    test('pre-fills prescription fields from item', () {
      final form = AddEyewearFormController.fromItem(tItem);
      expect(form.sphereRight.text, '-2.5');
      expect(form.cylinderRight.text, '-0.75');
      expect(form.axisRight.text, '180');
      expect(form.sphereLeft.text, '-2.25');
      expect(form.cylinderLeft.text, '-0.5');
      expect(form.axisLeft.text, '170');
      form.dispose();
    });

    test('leaves prescription fields empty when item has no prescription', () {
      final itemNoPrescription = EyewearItem(
        id: 'e2',
        name: 'Shades',
        category: EyewearCategory.sunglasses,
        updatedAt: tDate,
      );
      final form = AddEyewearFormController.fromItem(itemNoPrescription);
      expect(form.sphereRight.text, '');
      expect(form.sphereLeft.text, '');
      form.dispose();
    });
  });

  group('isFormValid', () {
    test('returns true when all registered controllers are valid', () {
      final form = AddEyewearFormController();
      form.setValidity(form.name, true);
      expect(form.isFormValid, isTrue);
      form.dispose();
    });

    test('returns false when any controller is invalid', () {
      final form = AddEyewearFormController();
      form.setValidity(form.name, true);
      form.setValidity(form.sphereRight, false);
      expect(form.isFormValid, isFalse);
      form.dispose();
    });

    test('returns true when no validity has been registered yet', () {
      // Empty map — every() on empty iterable returns true
      final form = AddEyewearFormController();
      expect(form.isFormValid, isTrue);
      form.dispose();
    });
  });

  group('hasPrescriptionData', () {
    test('returns false when all prescription fields are empty', () {
      final form = AddEyewearFormController();
      expect(form.hasPrescriptionData, isFalse);
      form.dispose();
    });

    test('returns true when at least one prescription field has content', () {
      final form = AddEyewearFormController();
      form.sphereRight.text = '-2.5';
      expect(form.hasPrescriptionData, isTrue);
      form.dispose();
    });
  });

  group('buildItem — new item', () {
    test('builds item with generated id and correct fields', () {
      final form = AddEyewearFormController(EyewearCategory.sunglasses);
      form.name.text = 'My Shades';
      form.selectedOptionIndex = 1;

      final item = form.buildItem();

      expect(item.id, startsWith('eyewear-'));
      expect(item.name, 'My Shades');
      expect(item.category, EyewearCategory.sunglasses);
      expect(item.selectedOptionIndex, 1);
      expect(item.prescription, isNull);
      form.dispose();
    });

    test('trims whitespace from name', () {
      final form = AddEyewearFormController();
      form.name.text = '  Frames  ';

      final item = form.buildItem();

      expect(item.name, 'Frames');
      form.dispose();
    });

    test('creates prescription when prescription fields are filled', () {
      final form = AddEyewearFormController();
      form.name.text = 'Frames';
      form.sphereRight.text = '-2.5';
      form.cylinderRight.text = '-0.75';
      form.axisRight.text = '180';
      form.sphereLeft.text = '-2.25';
      form.cylinderLeft.text = '-0.5';
      form.axisLeft.text = '170';

      final item = form.buildItem();

      expect(item.prescription, isNotNull);
      expect(item.prescription!.rightEye.sphere, -2.5);
      expect(item.prescription!.leftEye.sphere, -2.25);
      expect(item.prescription!.id, startsWith('rx-'));
      form.dispose();
    });

    test('defaults unparseable prescription fields to 0', () {
      final form = AddEyewearFormController();
      form.name.text = 'Frames';
      form.sphereRight.text = 'bad';
      form.cylinderRight.text = '-0.75';
      form.axisRight.text = '180';

      final item = form.buildItem();

      expect(item.prescription!.rightEye.sphere, 0.0);
      form.dispose();
    });
  });

  group('buildItem — editing existing item', () {
    test('preserves original id when existing item is passed', () {
      final form = AddEyewearFormController.fromItem(tItem);
      final updated = form.buildItem(existing: tItem);

      expect(updated.id, 'e1');
      form.dispose();
    });

    test('preserves original prescription id and issueDate', () {
      final form = AddEyewearFormController.fromItem(tItem);
      final updated = form.buildItem(existing: tItem);

      expect(updated.prescription!.id, 'rx1');
      expect(updated.prescription!.issueDate, tDate);
      form.dispose();
    });

    test('preserves addition and pd from existing prescription', () {
      final form = AddEyewearFormController.fromItem(tItem);
      final updated = form.buildItem(existing: tItem);

      expect(updated.prescription!.rightEye.addition, 0.5);
      expect(updated.prescription!.rightEye.pd, 62.0);
      form.dispose();
    });

    test('clears prescription when all fields are emptied during edit', () {
      final form = AddEyewearFormController.fromItem(tItem);
      // Clear all prescription fields
      for (final c in form.prescriptionControllers) {
        c.text = '';
      }
      final updated = form.buildItem(existing: tItem);

      expect(updated.prescription, isNull);
      form.dispose();
    });
  });
}
