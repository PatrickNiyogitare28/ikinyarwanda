import 'package:flutter/material.dart';
import 'package:ikinyarwanda/shared/styles.dart';

class TextWiget extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final Color? color;

  const TextWiget.headline1(
    this.text, {
    this.color,
    Key? key,
    TextAlign align = TextAlign.start,
  })  : textStyle = headline1Style,
        textAlign = align,
        super(key: key);

  const TextWiget.headline2(
    this.text, {
    this.color,
    Key? key,
    TextAlign align = TextAlign.start,
  })  : textStyle = headline2Style,
        textAlign = align,
        super(key: key);

  const TextWiget.headline3(
    this.text, {
    this.color,
    Key? key,
    TextAlign align = TextAlign.start,
  })  : textStyle = headline3Style,
        textAlign = align,
        super(key: key);

  TextWiget.body(
    this.text, {
    this.color,
    Key? key,
    TextAlign align = TextAlign.start,
    int? fontWeight,
  })  : textStyle = bodyStyle.apply(
          fontWeightDelta: fontWeight ?? 0,
        ),
        textAlign = align,
        super(key: key);

  const TextWiget.caption(
    this.text, {
    this.color,
    Key? key,
    TextAlign align = TextAlign.start,
  })  : textStyle = captionStyle,
        textAlign = align,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkModeOn = brightness == Brightness.dark;
    var textColor = isDarkModeOn
        ? Colors.white.withOpacity(.87)
        : Colors.black.withOpacity(.87);
    return Text(
      text,
      style: textStyle.apply(
        color: color ?? textColor,
      ),
      textAlign: textAlign,
    );
  }
}
