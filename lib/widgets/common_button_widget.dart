
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


// ignore: must_be_immutable
class CommonButtonWidget extends StatelessWidget {
  CommonButtonWidget({
    Key? key,
    this.onTap,
    this.text,
    this.alignmentForContent,
    this.buttonColor,
    this.textColor,
    this.boxShadow,
    this.border,
    this.fontWeight,
    this.fontSize,
    this.padding,
    this.image,
    this.maxwidth,
    this.width,
    this.icon,
    this.textAlign,
    this.buttonPadding,
    this.shape, this.child, this.borderRadius,

    //  this.width,
  }) : super(key: key);
  final Function()? onTap;
  final String? text;
  final Color? buttonColor;
  final Color? textColor;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  final FontWeight? fontWeight;
  final double? fontSize;
  final EdgeInsets? padding;
  final String? image;
  final double? maxwidth;
  final double? width;
  final MainAxisAlignment? alignmentForContent;
  final Icon? icon;
  final TextAlign? textAlign;
  final EdgeInsets? buttonPadding;
  final BoxShape? shape;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: buttonPadding ?? EdgeInsets.zero,
        child:child ?? Container(
          
          constraints:
              (maxwidth != null) ? BoxConstraints(maxWidth: maxwidth!) : null,
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: shape ?? BoxShape.rectangle,
            border: border,
            color: buttonColor ?? Colors.green,
            borderRadius: 
              borderRadius  ?? 
            (shape == null
              ?
              BorderRadius.all(
                    Radius.circular(8),
                  ):null)
                ,
            boxShadow: boxShadow,
          ),
          child: Row(
            mainAxisAlignment: alignmentForContent ?? MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (image != null) ...[
                Expanded(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child:
                        image != null ? Image.asset(image!) : const SizedBox(),
                  ),
                ),
              ],
              if (icon != null) ...[
                Container(
                  alignment: Alignment.center,
                  child: icon ?? const SizedBox(),
                ),
              ],
              // const SizedBox(
              //   width: 20,
              // ),
              if (text != null)
                Expanded(
                  flex: 4,
                  child: Text(
                    text!,
                    textAlign: textAlign ?? TextAlign.center,
                    style: GoogleFonts.oxygen(
                      fontSize: fontSize ?? 18,
                      fontWeight: fontWeight ?? FontWeight.bold,
                      color: textColor ?? Colors.white,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
