import 'dart:convert';
import 'dart:io';

import 'package:aug_task/features/medical_files/data/models/medical_model.dart';
import 'package:aug_task/features/medical_files/data/repositories/medical_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:intl/intl.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_constants.dart';
import 'medical_state.dart';

class MedicalCubit extends Cubit<MedicalState> {
  MedicalCubit(this.medicalRepository) : super(MedicalInitialState());

  final MedicalRepository medicalRepository;


  static MedicalCubit get(context) => BlocProvider.of(context);


  TextEditingController dateController=TextEditingController();
  File? imageData;
  String? fileName;
  Future<void> getImage()async{
    final ImagePicker picker=ImagePicker();
    XFile? image =await picker.pickImage(source: ImageSource.camera);
    fileName = image!.path.split('/').last;
    if(image!=null){
      var selected=File(image.path);
      imageData=selected;
      emit(ImageState());
      print(imageData!.path);
      print(imageData!.absolute);
      print('yes');
      emit(ChangeEditingState());
    }else{
      print('No');
    }
  }


  // MedicalModel? medicalModel;
  // Future<void> applyNow2() async {
  //   emit(StoreMedicalFileLoadingState());
  //   Either<Failure, MedicalModel> result = await medicalRepository.storeMedicalFiles(
  //     date: dateController.text,
  //     image: await MultipartFile.fromFile(
  //       imageData!.path,
  //       filename: fileName,
  //     ),
  //   );
  //   result.fold((failure) {
  //     print('===================================================');
  //     print(failure.error.toString());
  //     print('===================================================');
  //     emit(StoreMedicalFileFailureState(failure.error));
  //   }, ( medicalModel) {
  //     this.medicalModel = medicalModel;
  //     StoreMedicalFileSuccessState();
  //   });
  // }





  Future<void> storeMedicalFiles() async {
    emit(StoreMedicalFileLoadingState());
    Dio dio = Dio(BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
      // connectTimeout: const Duration(seconds: 10),
      // receiveTimeout: const Duration(seconds: 10),
    ));

    try {
      if (imageData != null) {
        FormData formData = FormData.fromMap({
          'medical_files[0][vaccinations_date][0][date]' :DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
          'medical_files[0][vaccinations_date][0][img]': await MultipartFile.fromFile(
            imageData!.path,
            filename: fileName,
          ),
        });
        dio.options.headers = {
          'Authorization': 'Bearer ${AppConstants.token}',
          'Accept': 'application/json',
        };
        Response response = await dio.post(EndPoints.medicalFile, data: formData,
            onSendProgress: (int send, int total) {
              print('$send $total');
            });

        print('///////////////////////////////////////////');
        print(DateTime.now().toString());
        print('///////////////////////////////////////////');
        emit(StoreMedicalFileSuccessState());
        return response.data;
      }
    } catch (error) {
      print(error.toString());
      print(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
      emit(StoreMedicalFileFailureState(error.toString()));
    }
  }



  storeMedicalFiles2() async {
    emit(StoreMedicalFileLoadingState());
    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(imageData!.openRead()));
    // get file length
    var length = await imageData!.length();

    // string to uri
    var uri = Uri.parse("https://alhayatmed.com/api/medical_files");
    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    // multipart that takes file
    var multipartFile = new http.MultipartFile('medical_files[0][vaccinations_date][0][img]', stream, length,
        filename: basename(imageData!.path));
    // add file to multipart
    request.headers.addAll({
      //'Content-Type':'multipart/form-data',
      'Authorization':'Bearer ${AppConstants.token}',
    });
    request.files.add(multipartFile);
    request.fields['medical_files[0][vaccinations_date][0][date]']=dateController.text;

    // send
    var response = await request.send();
    print(response.statusCode);
    print('osaamam');
    emit(StoreMedicalFileSuccessStatee());
    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);

    });
  }
}