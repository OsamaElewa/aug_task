import 'package:aug_task/core/api/api_services_implementation.dart';
import 'package:aug_task/features/medical_files/data/repositories/medical_repository.dart';
import 'package:aug_task/features/medical_files/data/repositories/medical_repository_implementation.dart';
import 'package:aug_task/features/medical_files/presentation/views/widgets/medical_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/medical_cubit.dart';


class MedicalView extends StatelessWidget {
  const MedicalView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:  (context) => MedicalCubit(MedicalRepositoryImplementation(ApiServicesImplementation())),
      child: Scaffold(
        appBar: AppBar(),
        body: const MedicalViewBody(),
      ),
    );
  }
}
