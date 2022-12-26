import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travelagency/Helper/Colors.dart';
import 'package:travelagency/Helper/text_style.dart';
import 'package:travelagency/Screens/Widgets/Drawer.dart';
import 'package:travelagency/Screens/Widgets/widgets.dart';
import 'package:travelagency/view_model/visa.dart';
import '../../Helper/my_theme.dart';
import '../Widgets/PlaceWidget.dart';

class DesktopVisaScreen extends StatefulWidget {
  const DesktopVisaScreen({Key? key}) : super(key: key);

  @override
  State<DesktopVisaScreen> createState() => _DesktopVisaScreenState();
}

class _DesktopVisaScreenState extends State<DesktopVisaScreen> {
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
    var wedth = MediaQuery.of(context).size.width;
    var heght = MediaQuery.of(context).size.height;

    final ScrollController _scrollController = ScrollController();
    return ChangeNotifierProvider(
      create: (context) => VisaVM(),
      builder: (context, child) {
        AppLocalizations translate = AppLocalizations.of(context)!;

        VisaVM visaProvider = Provider.of(context);
        return Scaffold(
          body: visaProvider.isLoading
              ? CustomWidgets.loading
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 1, child: CustomDrawer()),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 14.0, left: 14.0, top: 12.0, bottom: 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text("VISA",
                                  style: GoogleFonts.lato(
                                      letterSpacing: 4,
                                      color: AppColors.pomegranateColor,
                                      fontSize: 36,
                                      fontWeight: FontWeight.w900)),
                            ),
                            Expanded(
                              flex: 4,
                              child: SizedBox(
                                  width: double.infinity,
                                  height: heght * 0.313,
                                  child: Stack(
                                    children: [
                                      ListView.builder(
                                        itemCount:
                                            visaProvider.visaCount.length,
                                        controller: _scrollController,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) => Column(
                                          children: [
                                            SizedBox(
                                              width: wedth * 0.011,
                                            ),
                                            PlaceWidget(
                                                countIndex: index,
                                                imageLink: visaProvider
                                                    .visaCount[index]
                                                    .countryImage!,
                                                capitalName: visaProvider
                                                    .visaCount[index]
                                                    .countryEn!),
                                          ],
                                        ),
                                      ),
                                      //next and previous country
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: IconButton(
                                              onPressed: () async {
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 300));
                                                SchedulerBinding.instance
                                                    .addPostFrameCallback((_) {
                                                  _scrollController.animateTo(
                                                      _scrollController.position
                                                          .minScrollExtent,
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      curve:
                                                          Curves.fastOutSlowIn);
                                                });
                                              },
                                              icon: const CircleAvatar(
                                                backgroundColor:
                                                    AppColors.pomegranateColor,
                                                radius: 100,
                                                child: Icon(Icons
                                                    .arrow_back_ios_rounded),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 70,
                                            height: 70,
                                            child: IconButton(
                                              onPressed: () async {
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 300));
                                                SchedulerBinding.instance
                                                    .addPostFrameCallback((_) {
                                                  _scrollController.animateTo(
                                                      _scrollController.position
                                                          .maxScrollExtent,
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      curve:
                                                          Curves.fastOutSlowIn);
                                                });
                                              },
                                              icon: const CircleAvatar(
                                                backgroundColor:
                                                    AppColors.pomegranateColor,
                                                radius: 100,
                                                child: Icon(Icons
                                                    .arrow_forward_ios_rounded),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(height: heght * 0.04),
                            //visa type btn => trade medical
                            Expanded(
                                child: ListView.builder(
                              itemCount: visaProvider
                                  .visaCount[visaProvider.currentCountry]
                                  .visaType!
                                  .length,
                              itemBuilder: (context, index) => visaType(
                                  visaProvider: visaProvider,
                                  visaTypeIndex: index),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                            )),
                            //bottom sction contain visa type and conditions
                            Expanded(
                              flex: 5,
                              child: Container(
                                height: heght * 0.375,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                        vertical: heght * 0.003,
                                        horizontal: wedth * .005)
                                    .copyWith(bottom: 0),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.offWhiteColor.withOpacity(0.4),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  border: Border.all(
                                    width: 0.05,
                                    color: AppColors.offWhiteColor,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: ListView.builder(
                                          itemCount:
                                              visaProvider.visaCondCont.length,
                                          itemBuilder: (context,
                                                  conditionIndex) =>
                                              condition(
                                                  wedth: wedth,
                                                  height: heght,
                                                  visaProvider: visaProvider,
                                                  conditionIndex:
                                                      conditionIndex),
                                          scrollDirection: Axis.horizontal,
                                        )),
                                    confiemBTN(
                                        width: wedth,
                                        context: context,
                                        height: heght,
                                        visaProvider: visaProvider,
                                        translate: translate,
                                        formKey: formKey,
                                        nameCont: nameCont,
                                        phoneCont: phoneCont,
                                        emailCont: emailCont)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  visaType({required VisaVM visaProvider, required int visaTypeIndex}) {
    return InkWell(
      onTap: () {
        visaProvider.onVisaTypeClicked(
            clickedVisaTypeIndex: visaTypeIndex, firstTimeCalling: false);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: ChoiceChip(
          label: Text(
              visaProvider.visaCount[visaProvider.currentCountry]
                  .visaType![visaTypeIndex],
              style: white15lato),
          selected: true,
          selectedColor: AppColors.pomegranateColor,
        ),
      ),
    );
  }

  conditionName(
      {required double wedth,
      required String condition,
      required int conditionIndex}) {
    return SizedBox(
        width: 150,
        // width: wedth * 0.150,
        child: Text(
          condition,
          style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              color: AppColors.pomegranateColor,
              fontSize: 18),
        ));
  }

  condition(
      {required double wedth,
      required double height,
      required VisaVM visaProvider,
      required int conditionIndex}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          //condition name
          conditionName(
              condition:
                  visaProvider.visaCondCont[conditionIndex].conditionCategory!,
              wedth: wedth,
              conditionIndex: conditionIndex),
          SizedBox(
            height: height * .008,
          ),
          SizedBox(
            height: height * 0.28,
            width: 150,
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount:
                  visaProvider.visaCondCont[conditionIndex].conditions!.length,
              itemBuilder: (context, index) {
                log(visaProvider
                    .visaCondCont[conditionIndex].conditions![index]);
                log("work");
                return conditionContent(
                    index: index,
                    content: visaProvider
                        .visaCondCont[conditionIndex].conditions![index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  conditionContent({required String content, required int index}) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Text(
        "${index + 1} - $content",
        style: GoogleFonts.lato(color: AppColors.grayColor, fontSize: 16),
      ),
    );
  }

  ///name
  fullNameTf({
    required TextEditingController nameCont,
    required VisaVM visaProvider,
    required double width,
    required double height,
    required BuildContext context,
    required AppLocalizations translate,
  }) {
    return //full name
        Padding(
      padding: EdgeInsets.only(right: width * 0.005, bottom: height * 0.009),
      child: TextFormField(
          controller: nameCont,
          validator: (value) {
            return visaProvider.validateName(value!, context);
          },
          keyboardType: TextInputType.name,
          minLines: null,
          style: const TextStyle(fontSize: 16.0),
          decoration: MyThemeData.inputDhintPre(
              icon: const Icon(
                Icons.person,
                color: Colors.grey,
                size: 20,
              ),
              label: translate.fullName)),
    );
  }

//phone
  phoneTF({
    required TextEditingController phoneCont,
    required VisaVM visaProvider,
    required double width,
    required double height,
    required BuildContext context,
    required AppLocalizations translate,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: width * 0.005, bottom: height * 0.009),
      child: TextFormField(
          validator: (value) {
            return visaProvider.validatePhone(value!, context);
          },
          controller: phoneCont,
          keyboardType: TextInputType.number,
          minLines: null,
          style: const TextStyle(fontSize: 16.0),
          decoration: MyThemeData.inputDhintPre(
              icon: const Icon(
                Icons.phone_android,
                color: Colors.grey,
                size: 20,
              ),
              label: translate.phoneNumber)),
    );
  }

//email
  emailTF({
    required TextEditingController emailCont,
    required VisaVM visaProvider,
    required double width,
    required double height,
    required BuildContext context,
    required AppLocalizations translate,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: width * 0.005, bottom: height * 0.009),
      child: TextFormField(
          validator: (value) {
            return visaProvider.validateEmail(value!, context);
          },
          controller: emailCont,
          keyboardType: TextInputType.emailAddress,
          minLines: null,
          onChanged: (value) {},
          style: const TextStyle(fontSize: 16.0),
          decoration: MyThemeData.inputDhintPre(
              icon: const Icon(
                Icons.email,
                color: Colors.grey,
                size: 20,
              ),
              label: translate.email)),
    );
  }

//email
  noteTF({
    required TextEditingController noteCont,
    required VisaVM visaProvider,
    required double width,
    required double height,
    required BuildContext context,
    required AppLocalizations translate,
  }) {
    return Container(
      //  width: width * .23,
      padding: EdgeInsets.only(right: width * 0.005, bottom: height * 0.009),
      child: TextFormField(
          /*  validator: (value) {
          return visaProvider.validateEmail(value!, context);
        },*/
          controller: noteCont,
          keyboardType: TextInputType.emailAddress,
          minLines: null,
          style: const TextStyle(fontSize: 16.0),
          decoration: MyThemeData.inputDhintPre(
              icon: const Icon(
                Icons.note_outlined,
                color: Colors.grey,
                size: 20,
              ),
              label: "note")),
    );
  }

  passportImg(
      {required BuildContext context,
      required double width,
      required double height,
      required AppLocalizations translate,
      required VisaVM visaProvider}) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.009),
      child: Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: height * .015, horizontal: width * .005),
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
              visaProvider.pickPassImg();
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
                  translate.passportImage,
                  style: black15lato.copyWith(
                      color: const Color.fromARGB(200, 61, 61, 61)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  idImg(
      {required BuildContext context,
      required double width,
      required double height,
      required AppLocalizations translate,
      required VisaVM visaProvider}) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.009),
      child: Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: height * .015, horizontal: width * .005),
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
              visaProvider.pickIdImg();
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
                  style: black15lato.copyWith(
                      color: const Color.fromARGB(200, 61, 61, 61)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  pdfFile(
      {required BuildContext context,
      required double width,
      required double height,
      required AppLocalizations translate,
      required VisaVM visaProvider}) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.009),
      child: Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: height * .015, horizontal: width * .005),
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
              await visaProvider.pickPdf();
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
                  "form image",
                  style: black15lato.copyWith(
                      color: const Color.fromARGB(200, 61, 61, 61)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  confiemBTN(
      {required double width,
      required BuildContext context,
      required double height,
      required VisaVM visaProvider,
      required AppLocalizations translate,
      required GlobalKey<FormState> formKey,
      required TextEditingController nameCont,
      required TextEditingController phoneCont,
      required TextEditingController emailCont}) {
    return Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
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
                                    visaProvider.getCountIMG()),
                              ),
                              //form
                              Expanded(
                                child: Stack(
                                  children: [
                                    CustomWidgets.exit(context),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * .025,
                                          vertical: height * .009),
                                      child: SingleChildScrollView(
                                        child: Form(
                                          key: formKey,
                                          child: SizedBox(
                                            height: height * .85,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                fullNameTf(
                                                    nameCont: nameCont,
                                                    visaProvider: visaProvider,
                                                    width: width,
                                                    height: height,
                                                    context: context,
                                                    translate:
                                                        translate), //phone num
                                                phoneTF(
                                                    phoneCont: phoneCont,
                                                    visaProvider: visaProvider,
                                                    width: width,
                                                    height: height,
                                                    context: context,
                                                    translate: translate),
                                                emailTF(
                                                    emailCont: emailCont,
                                                    visaProvider: visaProvider,
                                                    width: width,
                                                    height: height,
                                                    context: context,
                                                    translate:
                                                        translate), //from date
                                                noteTF(
                                                    noteCont: noteCont,
                                                    visaProvider: visaProvider,
                                                    width: width,
                                                    height: height,
                                                    context: context,
                                                    translate: translate),
                                                passportImg(
                                                    height: height,
                                                    width: width,
                                                    visaProvider: visaProvider,
                                                    translate: translate,
                                                    context: context),
                                                idImg(
                                                    height: height,
                                                    width: width,
                                                    context: context,
                                                    translate: translate,
                                                    visaProvider: visaProvider),
                                                pdfFile(
                                                    context: context,
                                                    height: height,
                                                    width: width,
                                                    translate: translate,
                                                    visaProvider: visaProvider),

                                                MaterialButton(
                                                    onPressed: () {
                                                      log(" visa form ");

                                                      if (formKey.currentState!
                                                              .validate() &&
                                                          visaProvider.idImg !=
                                                              null &&
                                                          visaProvider
                                                                  .passImg !=
                                                              null &&
                                                          visaProvider
                                                                  .pdfFile !=
                                                              null) {
                                                        log("reserve visa form vaild");
                                                        visaProvider.reserveVisa(
                                                            visaId:
                                                                "cf2973e2-564b-4380-bdc0-fbce5f948a91",
                                                            userId:
                                                                "3e4ba9aa-878e-4f2d-a780-3c734f03650a",
                                                            fullName:
                                                                nameCont.text,
                                                            phoneNumber:
                                                                phoneCont.text,
                                                            email:
                                                                emailCont.text,
                                                            note:
                                                                noteCont.text);
                                                      }
                                                    },
                                                    minWidth: width * .185,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical: height * .03,
                                                    ),
                                                    color: AppColors
                                                        .pomegranateColor,
                                                    child: Text(
                                                      "Save",
                                                      style: white15lato,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.pomegranateColor),
                    child: const Text("Confirm"))),
          ],
        ));
  }
}
