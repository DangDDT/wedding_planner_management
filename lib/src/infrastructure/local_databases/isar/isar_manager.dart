import '../../../domain/services/isar/daos/isar_sample_dao.dart';
import '../../../domain/services/isar/isar_service.dart';
import 'isar_sample_dao_impl.dart';

class IsarManager extends IsarService {
  final IsarSampleDAO _isarSampleDAO;

  IsarManager({
    IsarSampleDAO? isarSampleDAO,
  }) : _isarSampleDAO = isarSampleDAO ?? IsarSampleDAOImpl();

  @override
  IsarSampleDAO get isarSampleDAO => _isarSampleDAO;
}
