import 'package:flutter/material.dart';
import 'package:not_hesaplamaa/constants/app_constants.dart';
import 'package:not_hesaplamaa/helper/data_helper.dart';
import 'package:not_hesaplamaa/model/ders.dart';
import 'package:not_hesaplamaa/widgets/ortalama_goster.dart';


class OrtalamaHesapla extends StatefulWidget {
  const OrtalamaHesapla({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrtalamaHesaplaState createState() => _OrtalamaHesaplaState();
}

class _OrtalamaHesaplaState extends State<OrtalamaHesapla> {
  List<Ders> tumDersler = [];
  
  double secilen = 1;
  double secilenKredi = 1;
  String girilenDersAdi = 'Ders Adı Girilmemiş';
  double krediDegeri = 1;
  double notDegeri = 4;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'Ortalama Hesapla',
            style: Sabitler.textStyle(24, FontWeight.w900, Sabitler.anaRenk),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 2, child: myForm()),
              Expanded(
                child: OrtalamaGoster(
                  dersSayisi: tumDersler.length,
                  ortalama: ortalamaHesapla(),
                ),
              )
            ],
          ),
          Expanded(
            child: tumDersler.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) => Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (a) {
                        setState(() {
                          tumDersler.removeAt(index);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Card(
                          child: ListTile(
                            title: Text(tumDersler[index].ad),
                            leading: CircleAvatar(
                              backgroundColor: Sabitler.anaRenk,
                              // ignore: unnecessary_string_interpolations
                              child: Text('${(tumDersler[index].krediDegeri *
                                          tumDersler[index].harfDegeri)
                                      .toStringAsFixed(0)}'),
                            ),
                            subtitle: Text(
                                '${tumDersler[index].krediDegeri} Kredi, Not Değeri ${tumDersler[index].harfDegeri}'),
                          ),
                        ),
                      ),
                    ),
                    itemCount: tumDersler.length,
                  )
                : Container(
                    margin: const EdgeInsets.all(24),
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text('Lütfen ders ekleyiniz',
                              style: TextStyle(color: Sabitler.anaRenk)),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Form myForm() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: _buildTextFormField(),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: _buildHarfler(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: _buildKrediler(),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    var eklenecekDers =
                        Ders(girilenDersAdi, secilen, secilenKredi);
                    tumDersler.insert(0, eklenecekDers);
                    ortalamaHesapla();
                    setState(() {});
                  }
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Sabitler.anaRenk,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextFormField _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        girilenDersAdi = deger!;
      },
      validator: (s) {
        if (s!.isEmpty) {
          return 'Boş bırakma ders adını';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          hintText: 'Matematik',
          border: OutlineInputBorder(
            borderRadius: Sabitler.borderRadius,
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3)),
    );
  }

  Widget _buildHarfler() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.shade100.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<double>(
        iconEnabledColor: Sabitler.anaRenk.shade200,
        elevation: 16,
        items: DataHelper.tumDersHarfleri(),
        underline: Container(),
        onChanged: (dd) {
          setState(() {
            secilen = dd!;
            // ignore: avoid_print
            print(dd);
          });
        },
        value: secilen,
      ),
    );
  }

  Widget _buildKrediler() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.shade100.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<double>(
        iconEnabledColor: Sabitler.anaRenk.shade200,
        elevation: 16,
        items: DataHelper.tumKrediler(),
        underline: Container(),
        onChanged: (dd) {
          setState(() {
            secilenKredi = dd!;
            // ignore: avoid_print
            print(dd);
          });
        },
        value: secilenKredi,
      ),
    );
  }

  double ortalamaHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;
    for (var element in tumDersler) {
      toplamNot = toplamNot + (element.krediDegeri * element.harfDegeri);
      toplamKredi = toplamKredi + element.krediDegeri;
    }
    return toplamNot / toplamKredi;
  }
}
