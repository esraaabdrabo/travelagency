import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travelagency/Helper/Colors.dart';
import 'package:travelagency/Helper/text_style.dart';
import 'package:travelagency/Screens/Widgets/widgets.dart';
import 'package:travelagency/view_model/hotels.dart';
import '../../../Helper/my_theme.dart';
import '../../../models/hotel/hotels.dart';
import '../../DesktopScreens/DesktopHotelScreen.dart';
import '../dialogs.dart';

class HotelCard extends StatefulWidget {
  late HotelsVM hotelProvider;
  late AppLocalizations translate;
  late HotelM hotel;
  late String fromDate;
  late String toDate;

  HotelCard(
      {super.key,
      required this.hotel,
      required this.hotelProvider,
      required this.translate,
      required this.fromDate,
      required this.toDate});

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
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

  var imgName = "passport image";
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
              return widget.hotelProvider.validateName(value!, context);
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
              return widget.hotelProvider.validatePhone(value!, context);
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
              return widget.hotelProvider.validateEmail(value!, context);
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
          return hotelProvider.validateEmail(value!, context);
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

    return Padding(
        padding: EdgeInsets.only(bottom: hight * .007),
        child: InkWell(
            onTap: () async {
              !widget.hotelProvider.isHotelClickAct
                  ? Dialogs.onlyTextContent(
                      context, "Please fill the required informations")
                  : showDialog(
                      context: context,
                      builder: (context) => StatefulBuilder(
                        builder: (BuildContext context, setState) {
                          return widget.hotelProvider.isLoading
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
                                            widget.hotel.image!),
                                      ),
                                      //form
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * .025,
                                              vertical: hight * .005),
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
                                                              .start,
                                                      children: [
                                                        //hotel name
                                                        hotelName(
                                                            "${widget.translate.welcomeIn} ${widget.hotel.name!}",
                                                            hight,
                                                            width),
                                                        fullNameTf(),
                                                        phoneTF(),
                                                        emailTF(),
                                                        noteTF(),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: hight *
                                                                        0.009),
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          hight *
                                                                              .015,
                                                                      horizontal:
                                                                          width *
                                                                              .005),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: AppColors
                                                                      .offWhiteColor
                                                                      .withOpacity(
                                                                          .8)),
                                                              width:
                                                                  width * .179,
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  imgName = await widget
                                                                      .hotelProvider
                                                                      .pickImg();
                                                                  if (imgName !=
                                                                      "") {
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          9,
                                                                      horizontal:
                                                                          8),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: AppColors
                                                                          .offWhiteColor
                                                                          .withOpacity(
                                                                              .8)),
                                                                  child: Row(
                                                                    children: [
                                                                      const Icon(
                                                                          Icons
                                                                              .upload,
                                                                          color: Color.fromARGB(
                                                                              170,
                                                                              61,
                                                                              61,
                                                                              61)),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                          imgName,
                                                                          style:
                                                                              black15lato(context)),
                                                                      const Spacer(),
                                                                      const Text(
                                                                          "*")
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            )),
                                                        CustomWidgets
                                                            .sizedbox15h,
                                                        MaterialButton(
                                                            onPressed:
                                                                () async {
                                                              if (formKey
                                                                      .currentState!
                                                                      .validate() &&
                                                                  widget.hotelProvider
                                                                          .img !=
                                                                      null) {
                                                                var result = widget.hotelProvider.reserveHotel(
                                                                    hotelId: widget
                                                                        .hotel
                                                                        .guid!,
                                                                    fullName:
                                                                        nameCont
                                                                            .text,
                                                                    phoneNumber:
                                                                        phoneCont
                                                                            .text,
                                                                    email:
                                                                        emailCont
                                                                            .text,
                                                                    fromDate: widget
                                                                        .fromDate,
                                                                    toDate: widget
                                                                        .toDate,
                                                                    note: noteCont
                                                                        .text);
                                                                // setState(() {});
                                                                if (await result) {
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              }
                                                            },
                                                            minWidth:
                                                                width * .2,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              vertical:
                                                                  hight * .03,
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
            child: hotelWidget(context,
                width: width, height: hight, hotel: widget.hotel)));
  }
}
