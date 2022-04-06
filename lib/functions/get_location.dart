import 'package:location/location.dart';

getLocation()async{

LocationData l = await  Location.instance.getLocation();
return l;

}