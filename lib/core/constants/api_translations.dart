import 'package:muscle_zone/core/utils/translation_helper.dart';

/// Exercise translations from English to Turkish
/// Since the API returns the datas in English,
/// we need to translate them to Turkish.
/// Translation is handled in the [TranslationHelper] class.
class ApiTranslations {
  /// Body part translations
  static const Map<String, String> bodyParts = {
    'back': 'Sırt',
    'chest': 'Göğüs',
    'lower arms': 'Ön Kol',
    'lower legs': 'Alt Bacak',
    'neck': 'Boyun',
    'shoulders': 'Omuz',
    'upper arms': 'Üst Kol',
    'upper legs': 'Üst Bacak, Kalça',
    'waist': 'Bel, Karın Kası',
  };

  /// Equipment translations
  static const Map<String, String> equipment = {
    'assisted': 'Destekli',
    'band': 'Lastik',
    'barbell': 'Halter',
    'body weight': 'Vücut Ağırlığı',
    'bosu ball': 'Bosu Topu',
    'cable': 'Kablo',
    'dumbbell': 'Dambıl',
    'elliptical machine': 'Eliptik',
    'ez barbell': 'Ez Bar',
    'hammer': 'Çekiç',
    'kettlebell': 'Kettlebell',
    'leverage machine': 'Makine',
    'medicine ball': 'Sağlık Topu',
    'olympic barbell': 'Olimpik Bar',
    'resistance band': 'Direnç Lastiği',
    'roller': 'Roller',
    'rope': 'İp',
    'skierg machine': 'Kayak Makinesi',
    'smith machine': 'Smith Makinesi',
    'stability ball': 'Pilates Topu',
    'stationary bike': 'Sabit Bisiklet',
    'stepmill machine': 'Merdiven Makinesi',
    'tire': 'Lastik',
    'trap bar': 'Trap Bar',
    'upper body ergometer': 'Üst Vücut Ergometresi',
    'weighted': 'Ağırlıklı',
    'wheel roller': 'Tekerlek',
  };

  /// Target muscle translations
  static const Map<String, String> targets = {
    'abductors': 'Abduktör',
    'abs': 'Karın',
    'adductors': 'Adduktör',
    'biceps': 'Biseps',
    'calves': 'Baldır',
    'cardiovascular system': 'Kardiyovasküler Sistem',
    'delts': 'Deltoid',
    'forearms': 'Ön Kol',
    'glutes': 'Kalça',
    'hamstrings': 'Arka Bacak',
    'lats': 'Sırt',
    'levator scapulae': 'Levator Skapula',
    'pectorals': 'Göğüs',
    'quads': 'Ön Bacak',
    'serratus anterior': 'Serratus Anterior',
    'spine': 'Omurga',
    'traps': 'Trapez',
    'triceps': 'Triseps',
    'upper back': 'Üst Sırt',
  };
}
