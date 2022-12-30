import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelagency/Helper/Colors.dart';
import 'package:travelagency/Helper/text_style.dart';
import 'package:travelagency/Screens/Widgets/dialogs.dart';
import 'package:travelagency/Screens/Widgets/widgets.dart';
import '../../../Helper/my_theme.dart';
import '../../../view_model/group.dart';

// ignore: must_be_immutable
class ConfirmBTN extends StatefulWidget {
  late GroupsVM groupsProvider;
  late AppLocalizations translate;

  ConfirmBTN({
    super.key,
    required this.groupsProvider,
    required this.translate,
  });

  @override
  State<ConfirmBTN> createState() => _ConfirmBTNState();
}

class _ConfirmBTNState extends State<ConfirmBTN> {
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

    ////////////text form field ////////////////////
    ///name
    fullNameTf() {
      return //full name
          Padding(
        padding: EdgeInsets.only(right: wedth * 0.005, bottom: heght * 0.025),
        child: TextFormField(
            controller: nameCont,
            validator: (value) {
              return widget.groupsProvider.validateName(value!, context);
            },
            keyboardType: TextInputType.name,
            minLines: null,
            style: const TextStyle(fontSize: 16.0),
            decoration: MyThemeData.inputDhintPre(context,
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: wedth * .015,
                ),
                label: widget.translate.fullName)),
      );
    }

//phone
    phoneTF() {
      return Padding(
        padding: EdgeInsets.only(right: wedth * 0.005, bottom: heght * 0.025),
        child: TextFormField(
            validator: (value) {
              return widget.groupsProvider.validatePhone(value!, context);
            },
            controller: phoneCont,
            keyboardType: TextInputType.number,
            minLines: null,
            style: const TextStyle(fontSize: 16.0),
            decoration: MyThemeData.inputDhintPre(context,
                icon: Icon(
                  Icons.phone_android,
                  color: Colors.grey,
                  size: wedth * .015,
                ),
                label: widget.translate.phoneNumber)),
      );
    }

//email
    emailTF() {
      return Padding(
        padding: EdgeInsets.only(right: wedth * 0.005, bottom: heght * 0.025),
        child: TextFormField(
            validator: (value) {
              return widget.groupsProvider.validateEmail(value!, context);
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
                  size: wedth * .015,
                ),
                label: widget.translate.email)),
      );
    }

//note
    noteTF() {
      return Padding(
        padding: EdgeInsets.only(right: wedth * 0.005, bottom: heght * 0.025),
        child: TextFormField(
            /*  validator: (value) {
          return groupsProvider.validateEmail(value!, context);
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
                  size: wedth * .015,
                ),
                label: "note")),
      );
    }

//reserve type
    reserveTypeTF() {
      return SizedBox(
        child: DropdownButtonFormField(
          // isExpanded: true,
          isDense: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            labelStyle: TextStyle(fontSize: heght * .024),
            labelText: 'ReserveType',
            border: const OutlineInputBorder(),
          ),
          value: widget.groupsProvider.clickedReserveType,
          items: widget.groupsProvider.reserveType
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item.toString(),
                        style: GoogleFonts.lato(fontSize: heght * .029)),
                  ))
              .toList(),
          onChanged: (val) {},
        ),
      );
    }

//*******second form**** */
    passportImg() {
      return InkWell(
        onTap: () async {
          widget.groupsProvider.pickImg();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColors.grayColor.withOpacity(.5)),
              color: AppColors.offWhiteColor.withOpacity(.8)),
          child: Row(
            children: [
              const Icon(Icons.upload, color: Color.fromARGB(170, 61, 61, 61)),
              const SizedBox(
                width: 5,
              ),
              Text(widget.translate.passportImage, style: black15lato(context)),
              const Spacer(),
              const Text("*")
            ],
          ),
        ),
      );
    }

    return SizedBox(
        height: heght * .1,
        child: Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              !widget.groupsProvider.canOpenReserveForm()
                  ? Dialogs.onlyTextContent(
                      context, "must select hotel and date")
                  : showDialog(
                      context: context,
                      builder: (context) => StatefulBuilder(
                        builder: (BuildContext context, setState) {
                          return widget.groupsProvider.isLoading
                              ? CustomWidgets.loading
                              : Dialog(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //hotel img
                                      Expanded(
                                        flex: 3,
                                        child: CustomWidgets.cachedImg(
                                            widget.groupsProvider.getImage()),
                                      ),
                                      //form
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: wedth * .025,
                                              vertical: heght * .005),
                                          child: SingleChildScrollView(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  CustomWidgets.exit(context),
                                                  Form(
                                                    key: formKey,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        fullNameTf(), //phone num
                                                        phoneTF(),
                                                        emailTF(), //from date

                                                        noteTF(), passportImg(),
                                                        SizedBox(
                                                          height: heght * .015,
                                                        ),
                                                        reserveTypeTF(),

                                                        CustomWidgets
                                                            .sizedbox15h,

                                                        MaterialButton(
                                                            onPressed:
                                                                () async {
                                                              if (formKey
                                                                      .currentState!
                                                                      .validate() &&
                                                                  widget.groupsProvider
                                                                          .img !=
                                                                      null) {
                                                                var result = widget.groupsProvider.reserveGroup(
                                                                    userId:
                                                                        "1a6bb561-e9a4-48b0-8e7d-100bb14d39f9",
                                                                    fullName:
                                                                        nameCont
                                                                            .text,
                                                                    phoneNumber:
                                                                        phoneCont
                                                                            .text,
                                                                    email:
                                                                        emailCont
                                                                            .text,
                                                                    note: noteCont
                                                                        .text);
                                                                setState(() {});
                                                                if (await result) {
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              }
                                                            },
                                                            minWidth:
                                                                wedth * .2,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              vertical:
                                                                  heght * .03,
                                                            ),
                                                            color: AppColors
                                                                .pomegranateColor,
                                                            child: Text(
                                                              "Save",
                                                              style:
                                                                  white15lato(
                                                                      context),
                                                            )),
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                        },
                      ),
                    );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.pomegranateColor,
                  borderRadius: BorderRadius.circular(wedth * .005)),
              padding: EdgeInsets.symmetric(
                  horizontal: wedth * .045, vertical: heght * .02),
              child: Text(
                "Confirm",
                style: white15lato(context),
              ),
            ),
          ),
        ));
  }
}
