import 'package:scoped_model/scoped_model.dart';


import './connected_personeller.dart';

class MainModel extends Model with ConnectedPersonellerModel, PersonellerModel, KullaniciModel, YardimciModel, StudentModel {
}