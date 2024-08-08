import 'package:aug_task/features/medical_files/data/models/medical_model.dart';

abstract class MedicalState{}

class MedicalInitialState extends MedicalState{}
class ImageState extends MedicalState{}
class ChangeEditingState extends MedicalState{}
class StoreMedicalFileLoadingState extends MedicalState{}
class StoreMedicalFileSuccessStatee extends MedicalState{}
class StoreMedicalFileSuccessState extends MedicalState{

  // final MedicalModel medicalModel;
  // StoreMedicalFileSuccessState(this.medicalModel);
}
class StoreMedicalFileFailureState extends MedicalState{
  final String error;
  StoreMedicalFileFailureState(this.error);
}