import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LargeButtonCustom extends StatefulWidget {
  final VoidCallback callback;
  final String text;
  const LargeButtonCustom(
      {super.key, required this.callback, required this.text});
  @override
  State<LargeButtonCustom> createState() => _LargeButtonCustomState();
}

class _LargeButtonCustomState extends State<LargeButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callback,
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class CustomANimatedButton extends StatelessWidget {
  VoidCallback onpress;
  var height;
  Alignment alignment;
  String text;
  int lines;
  double value;
  CustomANimatedButton({
    super.key,
    required this.onpress,
    required this.height,
    required this.text,
    this.alignment = Alignment.center,
    this.lines = 2,
    this.value = 0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: alignment,
              child: Text(
                text.toString(),
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: lines,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: LinearProgressIndicator(
                value: value.toDouble(),
                color: Colors.green,
                minHeight: 5,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// class CustomANimatedButton extends StatelessWidget { 
//   VoidCallback onpress;
//   var height;
//   Alignment alignment;
//   String text;
//   int lines;
//   CustomANimatedButton({
//     super.key,
//     required this.onpress,
//     required this.height,
//     required this.text,
//     this.alignment = Alignment.center,
//     this.lines = 2,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedButton(
//       onPress: onpress,
//       animatedOn: AnimatedOn.onTap,
//       animationDuration: const Duration(milliseconds: 300),
//       height: height,
//       text: text,
//       isReverse: true,
//       selectedTextColor: Colors.white,
//       transitionType: TransitionType.LEFT_TO_RIGHT,
//       textStyle: TextStyle(
//         fontSize: 18,
//         color: Colors.green,
//         fontWeight: FontWeight.w500,
//       ),
//       backgroundColor: Colors.white.withOpacity(0),
//       borderColor: Colors.green,
//       selectedBackgroundColor: Colors.green,
//       borderRadius: 10,
//       borderWidth: 2,
//       textAlignment: alignment,
//       textMaxLine: lines,
//       textOverflow: TextOverflow.ellipsis,
//     );
//   }
// }
