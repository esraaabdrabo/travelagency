import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:travelagency/Helper/my_theme.dart';
import 'package:travelagency/Helper/text_style.dart';
import 'package:travelagency/Screens/Widgets/dialogs.dart';
import 'package:travelagency/Screens/Widgets/widgets.dart';
import 'package:travelagency/view_model/hotels.dart';
import '../../Helper/Colors.dart';
import '../../models/hotel/hotels.dart';
import '../Widgets/Drawer.dart';
import '../Widgets/RoomWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DesktopHotelScreen extends StatefulWidget {
  const DesktopHotelScreen({Key? key}) : super(key: key);

  @override
  State<DesktopHotelScreen> createState() => _desktopHotelScreenState();
}

class _desktopHotelScreenState extends State<DesktopHotelScreen> {
  // final roomController = Get.put(RoomController());

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  PageController pageCont = PageController();
  //un used cont//
  TextEditingController natCont = TextEditingController();
  TextEditingController currCont = TextEditingController();
  //*firstform soctrollers*//
  TextEditingController nameCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController noteCont = TextEditingController();

  TextEditingController checkInDateController = TextEditingController();
  TextEditingController checkoutDateController = TextEditingController();
  //*second form soctrollers*//
  TextEditingController adultCont = TextEditingController();
  TextEditingController childCont = TextEditingController();
  TextEditingController roomNumCont = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameCont.dispose();
    phoneCont.dispose();
    emailCont.dispose();
    checkInDateController.dispose();
    checkoutDateController.dispose();
    adultCont.dispose();
    childCont.dispose();
    roomNumCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations translate = AppLocalizations.of(context)!;
    var wedth = MediaQuery.of(context).size.width; //1536
    var heght = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
        create: (context) => HotelsVM(),
        builder: (context, child) {
          HotelsVM hotelsProvider = Provider.of(context);
          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            body: hotelsProvider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //left draw
                      const Expanded(flex: 1, child: CustomDrawer()),
                      Expanded(
                        flex: 4,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Text("HOTEL", style: red36lato),
                            //form fileds
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: wedth * .009),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(118, 0, 0, 0),
                                      offset: Offset(-2, 2),
                                      blurRadius: 2),
                                  BoxShadow(color: Colors.white),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5),
                              child: Column(
                                children: [
                                  //search with country
                                  countriesDropDown(hotelsProvider, wedth),
                                  SizedBox(height: heght * 0.003),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: searchNatTF(
                                            wedth: wedth, natCont: natCont),
                                      ),
                                      Expanded(
                                        child: searchCurrTF(
                                            wedth: wedth, currCont: currCont),
                                      ),
                                      //from date
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            right: wedth * 0.005,
                                          ),
                                          child: TextFormField(
                                              controller: checkInDateController,
                                              validator: (value) {
                                                return hotelsProvider
                                                    .validateDate(
                                                        value!, context);
                                              },
                                              onTap: () async {
                                                var date = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2030));
                                                checkInDateController.text =
                                                    date
                                                        .toString()
                                                        .substring(0, 10);
                                                log(checkInDateController.text);
                                              },
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                              decoration:
                                                  MyThemeData.inputDhintPre(
                                                      icon: const Icon(
                                                        Icons.date_range,
                                                        color: Colors.grey,
                                                        size: 20,
                                                      ),
                                                      label: translate
                                                          .checkInDate)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            right: wedth * 0.005,
                                          ),
                                          child: TextFormField(
                                              controller:
                                                  checkoutDateController,
                                              validator: (value) {
                                                return hotelsProvider
                                                    .validateDate(
                                                        value!, context);
                                              },
                                              onTap: () async {
                                                var date = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2030));
                                                checkoutDateController.text =
                                                    date
                                                        .toString()
                                                        .substring(0, 10);
                                              },
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                              decoration:
                                                  MyThemeData.inputDhintPre(
                                                      icon: const Icon(
                                                        Icons.date_range,
                                                        color: Colors.grey,
                                                        size: 20,
                                                      ),
                                                      label: translate
                                                          .checkOutDate)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomWidgets.sizedbox15h,
                                  /*          Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        height: 40,
                                        child: adultNumTF(
                                            hotelsProvider: hotelsProvider,
                                            context: context,
                                            wedth: wedth,
                                            height: heght,
                                            adultCont: adultCont),
                                      ),
                                      SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: childNumTF(
                                              hotelsProvider: hotelsProvider,
                                              context: context,
                                              wedth: wedth,
                                              heght: heght,
                                              childCont: childCont)),
                                      SizedBox(
                                        height: 40,
                                        width: wedth * .5,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: hotelsProvider.childNum,
                                          itemBuilder: (context, index) =>
                                              SizedBox(
                                            height: 40,
                                            width: 100,
                                            //child age
                                            child: TextFormField(
                                                decoration: InputDecoration(
                                                    label: Text(
                                                        "child ${index + 1} age"),
                                                    border:
                                                        OutlineInputBorder(),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide())),
                                                onChanged: (age) {
                                                  hotelsProvider.changeCildAge(
                                                      index: index, age: age);
                                                }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            */
                                  SizedBox(
                                      height: 100,
                                      child: ListView.builder(
                                        itemCount: hotelsProvider.rooms.length,
                                        itemBuilder: (context, roomIndex) =>
                                            RoomWidget(
                                                index: roomIndex,
                                                hotelsProvider: hotelsProvider,
                                                heght: heght,
                                                wedth: wedth),
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      addRoom(
                                          hotelsProvider: hotelsProvider,
                                          context: context),
                                      SizedBox(
                                        width: wedth * .005,
                                      ),
                                      searchBtn(
                                          hotelsProvider: hotelsProvider,
                                          inDate: checkInDateController,
                                          outDate: checkoutDateController,
                                          currency: currCont,
                                          nationality: natCont,
                                          context: context),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: heght * 0.02),
                            hotelList(heght, wedth, hotelsProvider,
                                translate: translate,
                                adultCont: adultCont,
                                childCont: childCont,
                                formKey2: formKey2,
                                roomNumCont: roomNumCont,
                                pageCont: pageCont,
                                formKey1: formKey1,
                                nameCont: nameCont,
                                noteCont: noteCont,
                                phoneCont: phoneCont,
                                emailCont: emailCont,
                                fromDateCont: checkInDateController,
                                toDateCont: checkoutDateController),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        });
  }
}

var sectionDivder = const Divider(
  thickness: 3,
);
//*********hotel widget design*********** */ */
priceContainer(
    {required double width, required String price, required String roomType}) {
  return Container(
    width: 80, // width * .07,
    margin: EdgeInsets.only(right: width * .009),
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(24, 61, 61, 61)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          roomType,
          style: black15lato,
        ),
        Text(
          price,
          style: black15lato,
        )
      ],
    ),
  );
}

//******search country *******/
searchBtn(
    {required HotelsVM hotelsProvider,
    required TextEditingController inDate,
    required TextEditingController outDate,
    required TextEditingController currency,
    required TextEditingController nationality,
    required BuildContext context}) {
  return Align(
    alignment: Alignment.topRight,
    child: MaterialButton(
        elevation: 0,
        hoverColor: Colors.black,
        color: AppColors.pomegranateColor.withOpacity(0.8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () {
          hotelsProvider.checkSearchReq(
              inDate: inDate.text,
              outDate: outDate.text,
              currency: currency.text,
              nationality: nationality.text);
          hotelsProvider.isHotelClickAct
              ? hotelsProvider.search(context)
              : Dialogs.onlyTextContent(
                  context, "Please fill the required informations");
        },
        child: Text("Search", style: white15lato)),
  );
}

addRoom({required HotelsVM hotelsProvider, required BuildContext context}) {
  return Align(
    alignment: Alignment.topRight,
    child: MaterialButton(
        elevation: 0,
        hoverColor: Colors.black,
        color: AppColors.grayColor.withOpacity(.4),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () {
          hotelsProvider.addRoom(context);
        },
        child: Text("Add Room", style: white15lato)),
  );
}

//search text fields////
//nationality
Padding searchNatTF(
    {required double wedth, required TextEditingController natCont}) {
  return Padding(
    padding: EdgeInsets.only(right: wedth * 0.005),
    child: TextFormField(
        controller: natCont,
        style: const TextStyle(fontSize: 16.0),
        decoration: MyThemeData.inputDhintPre(
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.grey,
              size: 20,
            ),
            label: "Nationality")),
  );
}

//currency
Padding searchCurrTF(
    {required double wedth, required TextEditingController currCont}) {
  return Padding(
    padding: EdgeInsets.only(right: wedth * 0.005),
    child: TextFormField(
        controller: currCont..text = "\$",
        style: const TextStyle(fontSize: 16.0),
        decoration: MyThemeData.inputDhintPre(
            icon: const Icon(
              Icons.money_off,
              color: Colors.grey,
              size: 20,
            ),
            label: "Currency")),
  );
}

hotelWidget(
    {required double width, required double height, required HotelM hotel}) {
  return Container(
      width: width * .5,
      height: height * .19,
      padding: const EdgeInsets.all(10),
      color: const Color.fromARGB(10, 61, 61, 61),
      child: Row(
        children: [
          //hotel img
          SizedBox(
            width: width * .1,
            child: CustomWidgets.cachedImg(hotel.image!),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //name && country
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      hotel.name!,
                      maxLines: 1,
                      style: black20LatoTS,
                    ),
                    Text(
                      hotel.locationEn!,
                      maxLines: 1,
                      style: black15lato,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    hotel.sngPrice != null
                        ? priceContainer(
                            width: width,
                            price: hotel.sngPrice.toString(),
                            roomType: "SNG")
                        : const SizedBox(),
                    hotel.dblPrice != null
                        ? priceContainer(
                            width: width,
                            price: hotel.dblPrice.toString(),
                            roomType: "DBL")
                        : const SizedBox(),
                    hotel.trplPrice != null
                        ? priceContainer(
                            width: width,
                            price: hotel.trplPrice.toString(),
                            roomType: "TRP")
                        : const SizedBox(),
                    hotel.fmlyPrice != null
                        ? priceContainer(
                            width: width,
                            price: hotel.fmlyPrice.toString(),
                            roomType: "Fam")
                        : const SizedBox()
                  ],
                )
              ],
            ),
          )
        ],
      ));
}

hotelList(double heght, double wedth, HotelsVM hotelsProvider,
    {required AppLocalizations translate,
    required GlobalKey<FormState> formKey1,
    required GlobalKey<FormState> formKey2,
    required TextEditingController nameCont,
    required TextEditingController phoneCont,
    required TextEditingController emailCont,
    required TextEditingController noteCont,
    required TextEditingController fromDateCont,
    required TextEditingController toDateCont,
    required TextEditingController adultCont,
    required TextEditingController childCont,
    required TextEditingController roomNumCont,
    required PageController pageCont}) {
  return SizedBox(
      height: heght * .45,
      child: ListView.builder(
          itemCount: hotelsProvider.searchResults.isEmpty
              ? hotelsProvider.hotels.length
              : hotelsProvider.searchResults.length,
          itemBuilder: (context, index) => hotelCard(
              width: wedth,
              context: context,
              height: heght,
              hotel: hotelsProvider.searchResults.isEmpty
                  ? hotelsProvider.hotels[index]
                  : hotelsProvider.searchResults[index],
              translate: translate,
              formKey1: formKey1,
              formKey2: formKey2,
              nameCont: nameCont,
              phoneCont: phoneCont,
              emailCont: emailCont,
              noteCont: noteCont,
              fromDateCont: fromDateCont,
              toDateCont: toDateCont,
              adultCont: adultCont,
              childCont: childCont,
              roomNumCont: roomNumCont,
              hotelsProvider: hotelsProvider,
              pageCont: pageCont)));
}

////////////text form field ////////////////////
///name
fullNameTf({
  required TextEditingController nameCont,
  required HotelsVM hotelsProvider,
  required double width,
  required double height,
  required BuildContext context,
  required AppLocalizations translate,
}) {
  return //full name
      Padding(
    padding: EdgeInsets.only(right: width * 0.005, bottom: height * 0.025),
    child: TextFormField(
        controller: nameCont,
        validator: (value) {
          return hotelsProvider.validateName(value!, context);
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
  required HotelsVM hotelsProvider,
  required double width,
  required double height,
  required BuildContext context,
  required AppLocalizations translate,
}) {
  return Padding(
    padding: EdgeInsets.only(right: width * 0.005, bottom: height * 0.025),
    child: TextFormField(
        validator: (value) {
          return hotelsProvider.validatePhone(value!, context);
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
  required HotelsVM hotelsProvider,
  required double width,
  required double height,
  required BuildContext context,
  required AppLocalizations translate,
}) {
  return Padding(
    padding: EdgeInsets.only(right: width * 0.005, bottom: height * 0.025),
    child: TextFormField(
        validator: (value) {
          return hotelsProvider.validateEmail(value!, context);
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
  required HotelsVM hotelsProvider,
  required double width,
  required double height,
  required BuildContext context,
  required AppLocalizations translate,
}) {
  return Padding(
    padding: EdgeInsets.only(right: width * 0.005, bottom: height * 0.025),
    child: TextFormField(
        /*  validator: (value) {
          return hotelsProvider.validateEmail(value!, context);
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

//from date
fromDateTF({
  required TextEditingController fromDateCont,
  required HotelsVM hotelsProvider,
  required double width,
  required double height,
  required BuildContext context,
  required AppLocalizations translate,
}) {
  return Padding(
    padding: EdgeInsets.only(right: width * 0.005, bottom: height * 0.025),
    child: SizedBox(
      height: 40,
      child: TextFormField(
          controller: fromDateCont,
          validator: (value) {
            return hotelsProvider.validateDate(value!, context);
          },
          onTap: () async {
            var date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2030));
            fromDateCont.text = date.toString().substring(0, 10);
          },
          style: const TextStyle(fontSize: 16.0),
          decoration: MyThemeData.inputDhintPre(
              icon: const Icon(
                Icons.date_range,
                color: Colors.grey,
                size: 20,
              ),
              label: translate.checkInDate)),
    ),
  );
}

//to date
toDateTF({
  required TextEditingController toDateCont,
  required HotelsVM hotelsProvider,
  required double width,
  required double height,
  required BuildContext context,
  required AppLocalizations translate,
}) {
  return Padding(
    padding: EdgeInsets.only(right: width * 0.005, bottom: height * 0.025),
    child: SizedBox(
      height: 40,
      child: TextFormField(
          controller: toDateCont,
          validator: (value) {
            return hotelsProvider.validateDate(value!, context);
          },
          onTap: () async {
            var date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2030));
            toDateCont.text = date.toString().substring(0, 10);
            log(toDateCont.text);
          },
          style: const TextStyle(fontSize: 16.0),
          decoration: MyThemeData.inputDhintPre(
              icon: const Icon(
                Icons.date_range,
                color: Colors.grey,
                size: 20,
              ),
              label: translate.checkOutDate)),
    ),
  );
}

//go next
nextBtn({
  required HotelsVM hotelsProvider,
  required double width,
  required PageController pageCont,
  required double height,
  required GlobalKey<FormState> formKey1,
}) {
  return MaterialButton(
      onPressed: () {
        if (formKey1.currentState!.validate()) {
          pageCont.nextPage(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOutCubic);
        }
      },
      minWidth: width * .2,
      padding: EdgeInsets.symmetric(
        vertical: height * .03,
      ),
      color: AppColors.pomegranateColor,
      child: Text(
        "Next",
        style: white15lato,
      ));
}

//*******second form**** */
passportImg(
    {required BuildContext context,
    required AppLocalizations translate,
    required HotelsVM hotelProvider}) {
  return InkWell(
    onTap: () async {
      hotelProvider.pickImg();
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
          Text(
            translate.passportImage,
            style: black15lato.copyWith(
                color: const Color.fromARGB(200, 61, 61, 61)),
          )
        ],
      ),
    ),
  );
}
/*
adultNumTF({
  required HotelsVM hotelsProvider,
  required BuildContext context,
  required double wedth,
  required double height,
  required TextEditingController adultCont,
}) {
  return Padding(
    padding: EdgeInsets.only(right: wedth * 0.005, bottom: height * 0.025),
    child: TextFormField(
        controller: adultCont,
        validator: (value) {
          return hotelsProvider.validateAdultNum(value!, context);
        },
        keyboardType: TextInputType.name,
        minLines: null,
        style: const TextStyle(fontSize: 16.0),
        decoration: MyThemeData.inputDhintPre(
            icon: const Icon(
              Icons.man,
              color: Colors.grey,
              size: 20,
            ),
            label: // translate.fullName
                "adult num")),
  );
}

childNumTF({
  String index = "",
  required HotelsVM hotelsProvider,
  required BuildContext context,
  required double wedth,
  required double heght,
  required TextEditingController childCont,
}) {
  return Padding(
    padding: EdgeInsets.only(right: wedth * 0.005, bottom: heght * 0.025),
    child: TextFormField(
        controller: childCont,
        validator: (value) {
          return hotelsProvider.validateChildNum(value!, context);
        },
        onChanged: (value) => hotelsProvider.changeCildNum(num: value),
        keyboardType: TextInputType.number,
        minLines: 1,
        style: const TextStyle(fontSize: 16.0),
        decoration: MyThemeData.inputDhintPre(
            icon: const Icon(
              Icons.boy,
              color: Colors.grey,
              size: 20,
            ),
            label: // translate.fullName
                "child num")),
  );
}

secondForm({
  required HotelsVM hotelsProvider,
  required BuildContext context,
  required double width,
  required double height,
  required TextEditingController childCont,
  required TextEditingController adultCont,
  required GlobalKey<FormState> formKey2,
  required AppLocalizations translate,
}) {
  return Form(
    key: formKey2,
    child: Column(
      children: [
        passportImg(
            hotelProvider: hotelsProvider,
            translate: translate,
            context: context),
        CustomWidgets.sizedbox15h,
        //adult num
        adultNumTF(
            hotelsProvider: hotelsProvider,
            context: context,
            wedth: width,
            height: height,
            adultCont: adultCont),
        //child num
        childNumTF(
            hotelsProvider: hotelsProvider,
            context: context,
            wedth: width,
            heght: height,
            childCont: childCont),
        //room num

        MaterialButton(
            onPressed: () {
              if (formKey2.currentState!.validate()) {
                print("valid");
              }
            },
            minWidth: width * .2,
            padding: EdgeInsets.symmetric(
              vertical: height * .03,
            ),
            color: AppColors.pomegranateColor,
            child: Text(
              "Save",
              style: white15lato,
            )),
      ],
    ),
  );
}
*/
//name num email from-date to-date
/*firstForm({
  required double width,
  required BuildContext context,
  required double height,
  required AppLocalizations translate,
  required GlobalKey<FormState> formKey1,
  required PageController pageCont,
  required TextEditingController nameCont,
  required TextEditingController phoneCont,
  required TextEditingController emailCont,
  required TextEditingController fromDateCont,
  required TextEditingController toDateCont,
  required HotelsVM hotelsProvider,
}) {
  return Form(
    key: formKey1,
    child: SingleChildScrollView(
      child: Column(
        children: [
          fullNameTf(
              nameCont: nameCont,
              hotelsProvider: hotelsProvider,
              width: width,
              height: height,
              context: context,
              translate: translate), //phone num
          phoneTF(
              phoneCont: phoneCont,
              hotelsProvider: hotelsProvider,
              width: width,
              height: height,
              context: context,
              translate: translate),
          emailTF(
              emailCont: emailCont,
              hotelsProvider: hotelsProvider,
              width: width,
              height: height,
              context: context,
              translate: translate), //from date
          fromDateTF(
              fromDateCont: fromDateCont,
              hotelsProvider: hotelsProvider,
              width: width,
              height: height,
              context: context,
              translate: translate), //to date
          toDateTF(
              toDateCont: toDateCont,
              hotelsProvider: hotelsProvider,
              width: width,
              height: height,
              context: context,
              translate: translate),
          nextBtn(
              hotelsProvider: hotelsProvider,
              width: width,
              pageCont: pageCont,
              height: height,
              formKey1: formKey1)
        ],
      ),
    ),
  );
}
*/
//***reserve dialog********* */

hotelName(String title, double height, double width) {
  return Padding(
    padding: EdgeInsets.only(bottom: height * .05),
    child: Text(title, textAlign: TextAlign.center, style: black20LatoWShadow),
  );
}

hotelCard(
    {required double width,
    required BuildContext context,
    required double height,
    required HotelM hotel,
    required AppLocalizations translate,
    required GlobalKey<FormState> formKey1,
    required GlobalKey<FormState> formKey2,
    required TextEditingController nameCont,
    required TextEditingController phoneCont,
    required TextEditingController emailCont,
    required TextEditingController fromDateCont,
    required TextEditingController toDateCont,
    required TextEditingController adultCont,
    required TextEditingController childCont,
    required TextEditingController roomNumCont,
    required TextEditingController noteCont,
    required HotelsVM hotelsProvider,
    required PageController pageCont}) {
  return InkWell(
      onTap: () async {
        !hotelsProvider.isHotelClickAct
            ? Dialogs.onlyTextContent(
                context, "Please fill the required informations")
            : showDialog(
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return hotelsProvider.isLoading
                        ? CustomWidgets.loading
                        : Dialog(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //hotel img
                                Expanded(
                                  flex: 3,
                                  child: CustomWidgets.cachedImg(hotel.image!),
                                ),
                                //form
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * .025,
                                        vertical: height * .005),
                                    child: SingleChildScrollView(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomWidgets.exit(context),
                                            Form(
                                              key: formKey1,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  //hotel name
                                                  hotelName(
                                                      "${translate.welcomeIn} ${hotel.name!}",
                                                      height,
                                                      width),

                                                  fullNameTf(
                                                      nameCont: nameCont,
                                                      hotelsProvider:
                                                          hotelsProvider,
                                                      width: width,
                                                      height: height,
                                                      context: context,
                                                      translate:
                                                          translate), //phone num
                                                  phoneTF(
                                                      phoneCont: phoneCont,
                                                      hotelsProvider:
                                                          hotelsProvider,
                                                      width: width,
                                                      height: height,
                                                      context: context,
                                                      translate: translate),
                                                  emailTF(
                                                      emailCont: emailCont,
                                                      hotelsProvider:
                                                          hotelsProvider,
                                                      width: width,
                                                      height: height,
                                                      context: context,
                                                      translate:
                                                          translate), //from date
                                                  noteTF(
                                                      noteCont: noteCont,
                                                      hotelsProvider:
                                                          hotelsProvider,
                                                      width: width,
                                                      height: height,
                                                      context: context,
                                                      translate: translate),
                                                  passportImg(
                                                      hotelProvider:
                                                          hotelsProvider,
                                                      translate: translate,
                                                      context: context),
                                                  CustomWidgets.sizedbox15h,
                                                  MaterialButton(
                                                      onPressed: () async {
                                                        if (formKey1
                                                                .currentState!
                                                                .validate() &&
                                                            hotelsProvider
                                                                    .img !=
                                                                null) {
                                                          var result = hotelsProvider
                                                              .reserveHotel(
                                                                  hotelId: hotel
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
                                                                  fromDate:
                                                                      fromDateCont
                                                                          .text,
                                                                  toDate:
                                                                      toDateCont
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
                                                      minWidth: width * .2,
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
                                            )
                                            /*      Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                height: height * .6,
                                child: PageView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: pageCont,
                                  children: [
                                    //name num email from date to date
                                    firstForm(
                                        width: width,
                                        context: context,
                                        height: height,
                                        pageCont: pageCont,
                                        translate: translate,
                                        formKey1: formKey1,
                                        nameCont: nameCont,
                                        phoneCont: phoneCont,
                                        emailCont: emailCont,
                                        fromDateCont: fromDateCont,
                                        toDateCont: toDateCont,
                                        hotelsProvider: hotelsProvider),
                                    //passport img , adult num ,child num ,room num ,room type, book btn
                                    secondForm(
                                        hotelsProvider: hotelsProvider,
                                        context: context,
                                        width: width,
                                        height: height,
                                        childCont: childCont,
                                        adultCont: adultCont,
                                        formKey2: formKey2,
                                        translate: translate)
                                  ],
                                ),
                              )
                                              */
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
      child: hotelWidget(width: width, height: height, hotel: hotel));
}

////////////////search with country//////////////////////
countriesDropDown(HotelsVM hotelsProvider, double wedth) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: DropdownButton(
        isExpanded: true,
        value: hotelsProvider.selectedCountry,
        items: List.generate(hotelsProvider.countries.length, (index) {
          return DropdownMenuItem(
              value: hotelsProvider.countries[index],
              child: Text(
                hotelsProvider.countries[index],
                style: black15lato,
              ));
        }),
        onChanged: (country) {
          hotelsProvider.changeSelectedCountry(country.toString());
        }),
  );
}
