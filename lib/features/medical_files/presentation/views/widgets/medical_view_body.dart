import 'package:aug_task/core/functions/show_snack_bar.dart';
import 'package:aug_task/core/widgets/custom_loading.dart';
import 'package:aug_task/features/medical_files/presentation/cubits/medical_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/medical_state.dart';

class MedicalViewBody extends StatelessWidget {
  const MedicalViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedicalCubit, MedicalState>(
      listener: (context, state) {
        if (state is StoreMedicalFileSuccessState) {
         showSuccessSnackBar(context: context, message: 'the medical files has been uploaded successfully');
        }else if (state is StoreMedicalFileFailureState ) {
          showErrorSnackBar(context: context, message: state.error.toString());
        }
      },
      builder: (context, state) {
        return CustomLoading(
          isLoading: state is StoreMedicalFileLoadingState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MedicalCubit.get(context).imageData!=null?SizedBox(
                height: 200,
                width: 200,
                child: Image(image: FileImage(MedicalCubit.get(context).imageData!),height: 150,width: 150,),
              ):
              InkWell(
                onTap: (){
                  MedicalCubit.get(context).getImage();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle
                  ),
                  child: Icon(Icons.camera_alt_outlined,size: 100,color: Colors.white,),
                ),
              ),
              TextFormField(
                controller: MedicalCubit.get(context).dateController,
                decoration: const InputDecoration(
                  hintText: 'Date',
                ),
              ),
          
              ElevatedButton(onPressed: (){
                MedicalCubit.get(context).storeMedicalFiles();
              }, child: const Text('Submit')),
            ],
          ),
        );
      },
    );
  }
}
