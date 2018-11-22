import 'package:flutter/material.dart';

Widget gelsiDropDownMenuItems(){

List<DropdownMenuItem<String>> _getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();

    items.add(DropdownMenuItem(
      value: '00',
      child: Text("Birim Seçiniz!"),
    ));

    items.add(DropdownMenuItem(
      value: '01',
      child: Text("Aksu Mehmet Süreyya Demiraslan MYO"),
    ));

    items.add(new DropdownMenuItem(
      value: '02',
      child: Text("Atabey MYO"),
    ));

    items.add(DropdownMenuItem(
      value: '03',
      child: Text("Bilgi İşlem Daire Başkanlığı"),
    ));

    items.add(DropdownMenuItem(
      value: '04',
      child: Text("Eğirdir Meslek Yüksekokulu"),
    ));

    items.add(DropdownMenuItem(
      value: '05',
      child: Text("Eğirdir Su Ürünleri Fakültesi"),
    ));
    items.add(DropdownMenuItem(
      value: '06',
      child: Text("Eğirdir Turizm Ve Otelcilik Yüksekokulu"),
    ));
    items.add(DropdownMenuItem(
      value: '07',
      child: Text("Gelendost MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '08',
      child: Text("Genel Sekreterlik"),
    ));
    items.add(DropdownMenuItem(
      value: '09',
      child: Text("Gönen MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '10',
      child: Text("Isparta MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '11',
      child: Text("Keçiborlu MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '12',
      child: Text("Lisansüstü Eğitim Enstitüsü"),
    ));
    items.add(DropdownMenuItem(
      value: '13',
      child: Text("Orman Fakültesi"),
    ));
    items.add(DropdownMenuItem(
      value: '14',
      child: Text("Personel Daire Başkanlığı"),
    ));
    items.add(DropdownMenuItem(
      value: '15',
      child: Text("Senirkent MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '16',
      child: Text("Sütçüler Prof. Dr. Hasan Gürbüz MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '17',
      child: Text("Şarkikaraağaç MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '18',
      child: Text("Şarkikaraağaç Turizm MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '19',
      child: Text("Tarım Bilimleri Ve Teknolojileri Fakültesi"),
    ));
    items.add(DropdownMenuItem(
      value: '20',
      child: Text("Teknik Bilimler MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '21',
      child: Text("Teknoloji Fakültesi"),
    ));
    items.add(DropdownMenuItem(
      value: '22',
      child: Text("Uluborlu Selahattin Karasoy MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '23',
      child: Text("Uzaktan Eğitim MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '24',
      child: Text("Yalvaç Büyükkutlu Uyg. Bil. Yüksekokulu"),
    ));
    items.add(DropdownMenuItem(
      value: '25',
      child: Text("Yalvaç MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '26',
      child: Text("Yalvaç Teknik Bilimler MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '27',
      child: Text("Yenişarbademli MYO"),
    ));

    return items;
  }
}

class DropDownPersonelArama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    gelsiDropDownMenuItems();
  }
}