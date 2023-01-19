import 'package:flutter/material.dart';
import 'package:ikinyarwanda/shared/styles.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final Color? color;

  const TextWidget.headline1(
    this.text, {
    this.color,
    Key? key,
    TextAlign align = TextAlign.start,
  })  : textStyle = headline1Style,
        textAlign = align,
        super(key: key);

  const TextWidget.headline2(
    this.text, {
    this.color,
    Key? key,
    TextAlign align = TextAlign.start,
  })  : textStyle = headline2Style,
        textAlign = align,
        super(key: key);

  const TextWidget.headline3(
    this.text, {
    this.color,
    Key? key,
    TextAlign align = TextAlign.start,
  })  : textStyle = headline3Style,
        textAlign = align,
        super(key: key);

  TextWidget.body(
    this.text, {
    this.color,
    Key? key,
    TextAlign align = TextAlign.start,
    int? fontWeight,
    Color? bgColor,
  })  : textStyle = bodyStyle.apply(
          fontWeightDelta: fontWeight ?? 0,
          backgroundColor: bgColor,
        ),
        textAlign = align,
        super(key: key);
  const TextWidget.caption(
    this.text, {
    this.color,
    Key? key,
    TextAlign align = TextAlign.start,
  })  : textStyle = captionStyle,
        textAlign = align,
        super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: textStyle.apply(color: color),
        textAlign: textAlign,
      );
}
