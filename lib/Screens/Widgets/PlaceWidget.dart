import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Helper/Colors.dart';

class PlaceWidget extends StatefulWidget {
  String imageLink;
  String capitalName;
  PlaceWidget({Key? key, required this.imageLink, required this.capitalName})
      : super(key: key);

  @override
  State<PlaceWidget> createState() => _PlaceWidgetState();
}

class _PlaceWidgetState extends State<PlaceWidget> {
  bool isHover = false;
  bool isSelected = false;
  Offset mousPos = new Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) {
        setState(() {
          isHover = true;
        });
      },
      onHover: (e) {
        setState(() {
          mousPos += e.delta;
          mousPos *= 0.12;
        });
      },
      onExit: (e) {
        setState(() {
          isHover = false;
        });
      },
      child: InkWell(
        onTap: () {
          isSelected = !isSelected;
        },
        child: Container(
          height: 300,
          width: 220,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              blurRadius: isHover ? 15 : 2,
              spreadRadius: isHover ? 5 : 2,
              color: isHover ? AppColors.grayColor : AppColors.offWhiteColor,
            )
          ]),
          child: Stack(
            children: [
              backImage(),
              gradiant(),
              Positioned(
                bottom: 20.0,
                left: 2.0,
                width: 200,
                child: texts(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  backImage() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 1000),
      top: isHover ? -40 + mousPos.dy : 0,
      left: isHover ? -100 + mousPos.dx : -100,
      height: isHover ? 600 : 400,
      width: 500,
      curve: Curves.easeOutCubic,
      child: Container(
        width: 500,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(widget.imageLink),
        )),
      ),
    );
  }

  gradiant() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topRight,
          colors: [
            AppColors.pomegranateColor.withOpacity(isHover ? 0.8 : 0),
            Colors.transparent
          ],
        ),
      ),
    );
  }

  texts() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedDefaultTextStyle(
              style: GoogleFonts.lato(
                  color: AppColors.whiteColor.withOpacity(isHover ? 1 : 0.8),
                  fontSize: 33,
                  fontWeight: FontWeight.w900),
              duration: const Duration(milliseconds: 1000),
              child: TextButton(
                onPressed: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.pomegranateColor
                        : Colors.transparent,
                    borderRadius: isSelected
                        ? const BorderRadius.all(Radius.circular(5))
                        : const BorderRadius.all(Radius.circular(2)),
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: isSelected ? 20 : 10,
                        vertical: isSelected ? 2 : 0),
                    child: Text(
                      widget.capitalName,
                      style: GoogleFonts.lato(
                          fontSize: 22,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
