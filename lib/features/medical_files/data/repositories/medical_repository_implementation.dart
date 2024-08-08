import 'package:aug_task/core/utils/app_constants.dart';
import 'package:aug_task/features/medical_files/data/models/medical_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


import '../../../../core/api/api_services.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/errors/failures.dart';
import 'medical_repository.dart';



class MedicalRepositoryImplementation extends MedicalRepository {
  final ApiServices apiServices;

  MedicalRepositoryImplementation(this.apiServices);

  @override
  Future<Either<Failure, MedicalModel>> storeMedicalFiles({
    required dynamic image,
    required String date,

  }) async {
    try {
      Response data = await apiServices.post(
          endPoint: EndPoints.medicalFile,
          token: AppConstants.token,
          data: {
            'medical_files[0][vaccinations_date][0][img]': image,
            'medical_files[0][vaccinations_date][0][date]': date,
          });
      return Right(MedicalModel.fromJson(data.data));
    } catch (error) {
      if (error is DioError) {
        return Left(ServerFailure(error.response!.data['message'].toString()));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}
