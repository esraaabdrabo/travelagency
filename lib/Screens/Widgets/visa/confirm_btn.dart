import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travelagency/Helper/Colors.dart';
import 'package:travelagency/Helper/text_style.dart';
import 'package:travelagency/Screens/Widgets/widgets.dart';
import 'package:travelagency/view_model/visa.dart';
import '../../../Helper/my_theme.dart';

class ConfirmBtnVisa extends StatefulWidget {
  late VisaVM visaProvider;
  late AppLocalizations translate;

  ConfirmBtnVisa({
    super.key,
    required this.visaProvider,
    required this.translate,
  });

  @override
  State<ConfirmBtnVisa> createState() => _ConfirmBtnVisaState();
}

class _ConfirmBtnVisaState extends State<ConfirmBtnVisa> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController noteCont = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameCont.dispose();
    phoneCont.dispose();
    emailCont.dispose();
    noteCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hight = MediaQuery.of(context).size.height;

    ///name
    fullNameTf() {
      return //full name
          Padding(
        padding: EdgeInsets.only(right: width * 0.005, bottom: hight * 0.009),
        child: TextFormField(
            controller: nameCont,
            validator: (value) {
              return widget.visaProvider.validateName(value!, context);
            },
            keyboardType: TextInputType.name,
            minLines: null,
            style: const TextStyle(fontSize: 16.0),
            decoration: MyThemeData.inputDhintPre(context,
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: width * .015,
                ),
                label: widget.translate.fullName)),
      );
    }

//phone
    phoneTF() {
      return Padding(
        padding: EdgeInsets.only(right: width * 0.005, bottom: hight * 0.009),
        child: TextFormField(
            validator: (value) {
              return widget.visaProvider.validatePhone(value!, context);
            },
            controller: phoneCont,
            keyboardType: TextInputType.number,
            minLines: null,
            style: const TextStyle(fontSize: 16.0),
            decoration: MyThemeData.inputDhintPre(context,
                icon: Icon(
                  Icons.phone_android,
                  color: Colors.grey,
                  size: width * .015,
                ),
                label: widget.translate.phoneNumber)),
      );
    }

//email
    emailTF() {
      return Padding(
        padding: EdgeInsets.only(right: width * 0.005, bottom: hight * 0.009),
        child: TextFormField(
            validator: (value) {
              return widget.visaProvider.validateEmail(value!, context);
            },
            controller: emailCont,
            keyboardType: TextInputType.emailAddress,
            minLines: null,
            onChanged: (value) {},
            style: const TextStyle(fontSize: 16.0),
            decoration: MyThemeData.inputDhintPre(context,
                icon: Icon(
                  Icons.email,
                  color: Colors.grey,
                  size: width * .015,
                ),
                label: widget.translate.email)),
      );
    }

//note
    noteTF() {
      return Padding(
        padding: EdgeInsets.only(right: width * 0.005, bottom: hight * 0.009),
        child: TextFormField(
            /*  validator: (value) {
          return visaProvider.validateEmail(value!, context);
        },*/
            controller: noteCont,
            keyboardType: TextInputType.emailAddress,
            minLines: null,
            style: const TextStyle(fontSize: 16.0),
            decoration: MyThemeData.inputDhintPre(context,
                isRequired: false,
                icon: Icon(
                  Icons.note_outlined,
                  color: Colors.grey,
                  size: width * .015,
                ),
                label: "note")),
      );
    }

    idImg() {
      return Padding(
        padding: EdgeInsets.only(bottom: hight * 0.009),
        child: Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: hight * .015, horizontal: width * .005),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                /* border: Border(
                  bottom: BorderSide(
                      color: AppColors.grayColor.withOpacity(
                          .5))),*/ //.all(color: AppColors.grayColor.withOpacity(.5)),
                color: AppColors.offWhiteColor.withOpacity(.8)),
            width: width * .178,
            child: InkWell(
              onTap: () async {
                widget.visaProvider.pickIdImg();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.upload,
                      color: Color.fromARGB(170, 61, 61, 61)),
                  SizedBox(
                    width: width * .001,
                  ),
                  Text(
                    "id image",
                    style: black15lato(context),
                  ),
                  const Spacer(),
                  const Text("*")
                ],
              ),
            ),
          ),
        ),
      );
    }

    pdfFile() {
      return Padding(
        padding: EdgeInsets.only(bottom: hight * 0.009),
        child: Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: hight * .015, horizontal: width * .005),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                /* border: Border(
                  bottom: BorderSide(
                      color: AppColors.grayColor.withOpacity(
                          .5))),*/ //.all(color: AppColors.grayColor.withOpacity(.5)),
                color: AppColors.offWhiteColor.withOpacity(.8)),
            width: width * .178,
            child: InkWell(
              onTap: () async {
                await widget.visaProvider.pickPdf();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.upload,
                      color: Color.fromARGB(170, 61, 61, 61)),
                  SizedBox(
                    width: width * .001,
                  ),
                  Text("form image", style: black15lato(context)),
                  const Spacer(),
                  const Text("*")
                ],
              ),
            ),
          ),
        ),
      );
    }

    passportImg() {
      return Padding(
        padding: EdgeInsets.only(bottom: hight * .007),
        child: InkWell(
          onTap: () async {
            widget.visaProvider.pickPassImg();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.offWhiteColor.withOpacity(.8)),
            child: Row(
              children: [
                const Icon(Icons.upload,
                    color: Color.fromARGB(170, 61, 61, 61)),
                const SizedBox(
                  width: 5,
                ),
                Text(widget.translate.passportImage,
                    style: black15lato(context)),
                const Spacer(),
                const Text("*")
              ],
            ),
          ),
        ),
      );
    }

    return SizedBox(
        height: hight * .09,
        child: Padding(
            padding: EdgeInsets.only(bottom: hight * .007),
            child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //hotel img
                                Expanded(
                                  flex: 3,
                                  child: CustomWidgets.cachedImg(
                                      widget.visaProvider.getCountIMG()),
                                ),
                                //form
                                Expanded(
                                  child: Stack(
                                    children: [
                                      CustomWidgets.exit(context),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * .025,
                                              vertical: hight * .009),
                                          child: SingleChildScrollView(
                                            child: Form(
                                              key: formKey,
                                              child: SizedBox(
                                                height: hight * .85,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    fullNameTf(), //phone num
                                                    phoneTF(),
                                                    emailTF(), //from date
                                                    noteTF(), passportImg(),
                                                    idImg(), pdfFile(),
                                                    MaterialButton(
                                                        onPressed: () {
                                                          log(" visa form ");

                                                          if (formKey
                                                                  .currentState!
                                                                  .validate() &&
                                                              widget.visaProvider
                                                                      .idImg !=
                                                                  null &&
                                                              widget.visaProvider
                                                                      .passImg !=
                                                                  null &&
                                                              widget.visaProvider
                                                                      .pdfFile !=
                                                                  null) {
                                                            log("reserve visa form vaild");
                                                            widget.visaProvider.reserveVisa(
                                                                visaId:
                                                                    "cf2973e2-564b-4380-bdc0-fbce5f948a91",
                                                                userId:
                                                                    "3e4ba9aa-878e-4f2d-a780-3c734f03650a",
                                                                fullName:
                                                                    nameCont
                                                                        .text,
                                                                phoneNumber:
                                                                    phoneCont
                                                                        .text,
                                                                email: emailCont
                                                                    .text,
                                                                note: noteCont
                                                                    .text);
                                                          }
                                                        },
                                                        minWidth: width * .185,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          vertical: hight * .03,
                                                        ),
                                                        color: AppColors
                                                            .pomegranateColor,
                                                        child: Text(
                                                          "Save",
                                                          style: white15lato(
                                                              context),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.pomegranateColor,
                        borderRadius: BorderRadius.circular(width * .005)),
                    padding: EdgeInsets.symmetric(
                        horizontal: width * .045, vertical: hight * .02),
                    child: Text(
                      "Confirm",
                      style: white15lato(context),
                    ),
                  ),
                ))));
  }
}
