import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File>imagePicker(ImageSource imageSource)async{

 PickedFile pickedFile = await ImagePicker().getImage(source: imageSource, imageQuality: 60);

 return File(pickedFile.path);


}