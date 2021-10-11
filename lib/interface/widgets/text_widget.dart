import 'package:flutter/material.dart';
import 'package:ikinyarwanda/shared/styles.dart';

class TextWiget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign textAlign;

  TextWiget.headline1(
    this.text, {
    Key? key,
    TextAlign align = TextAlign.start,
    Color? color,
  })  : textStyle = headline1Style.apply(
          color: color ?? Colors.black.withOpacity(.87),
        ),
        textAlign = align,
        super(key: key);

  TextWiget.headline2(
    this.text, {
    Key? key,
    TextAlign align = TextAlign.start,
    Color? color,
  })  : textStyle = headline2Style.apply(
          color: color ?? Colors.black.withOpacity(.87),
        ),
        textAlign = align,
        super(key: key);

  TextWiget.headline3(
    this.text, {
    Key? key,
    TextAlign align = TextAlign.start,
    Color? color,
  })  : textStyle = headline3Style.apply(
          color: color ?? Colors.black.withOpacity(.87),
        ),
        textAlign = align,
        super(key: key);

  TextWiget.body(
    this.text, {
    Key? key,
    TextAlign align = TextAlign.start,
    Color? color,
    int? fontWeight,
  })  : textStyle = bodyStyle.apply(
          color: color ?? Colors.black.withOpacity(.87),
          fontWeightDelta: fontWeight ?? 0,
        ),
        textAlign = align,
        super(key: key);

  TextWiget.caption(
    this.text, {
    Key? key,
    TextAlign align = TextAlign.start,
    Color? color,
  })  : textStyle = captionStyle.apply(
          color: color ?? Colors.black.withOpacity(.87),
        ),
        textAlign = align,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
    );
  }
}
