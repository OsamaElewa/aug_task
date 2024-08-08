import 'package:aug_task/features/medical_files/data/models/medical_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';


abstract class MedicalRepository {
  Future<Either<Failure, MedicalModel>> storeMedicalFiles({
    required dynamic image,
    required String date,
  });
}
