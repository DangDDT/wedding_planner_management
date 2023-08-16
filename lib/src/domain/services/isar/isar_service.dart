import '../../../../core/core.dart';
import 'daos/isar_sample_dao.dart';

abstract class IsarService {
  static final String tag = {AppCore.tag, 'IsarService'}.join('_');

  IsarSampleDAO get isarSampleDAO;
}
