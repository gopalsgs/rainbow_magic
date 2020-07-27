import 'dart:math';

import 'package:flutter/material.dart';
import 'package:magic/core/enums.dart';
import 'package:magic/features/home/ui/models/rainbow_model.dart';
import 'package:magic/main.dart';

import 'QRDisplayPage.dart';

class Vibgyor extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;
  const Vibgyor({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _VibgyorState createState() => _VibgyorState();
}

class _VibgyorState extends State<Vibgyor> {

  ButtonState shuffleButtonState = ButtonState.Inactive;
  bool didWin = false;

  List<RainbowColor> colors = [
    RainbowColor(color: Color(0xff9400D3), code:'V'),
    RainbowColor(color: Colors.indigo, code:'I'),
    RainbowColor(color: Colors.blue, code:'B'),
    RainbowColor(color: Colors.green, code:'G'),
    RainbowColor(color: Colors.yellow, code:'Y'),
    RainbowColor(color: Colors.orange, code:'O'),
    RainbowColor(color: Colors.red, code:'R'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 16),
          child: Stack(
            children: <Widget>[
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: colors.length,
                  itemBuilder: (context, index){

                    var rainbowItem = colors[index];
                    int textPosition = getTextPosition(rainbowItem, index);

                    return Center(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: 200,
                            color: rainbowItem.color,
                          ),
                          Container(
                            height: 30,
                            width: 200,
                            child: AnimatedAlign(
                              duration: Duration(milliseconds: 200),
                              alignment: textPosition == 0 ? Alignment.centerLeft : Alignment.centerRight,
                              curve: Curves.easeOut,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.grey
                                ),
                                child: Center(
                                  child: Text(
                                    rainbowItem.code,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Center(
                child: Container(
                  height: 210,
                  width: 200,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.lightBlue.withOpacity(0.3),
                      highlightColor: Colors.transparent,
                      onTap: EnvironmentConfig.BUNDLE_ID_SUFFIX == Const.PROD
                          ? (){if(!didWin){
                        _shuffle();
                      }}
                          : null
                      ,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),

//        if(didWin)
//        RaisedButton(
//          onPressed: (){
//            _shuffle();
//            setState(() {
//              didWin = false;
//            });
//          },
//          child: Text('Reset and Start again'),
//        )
      ],
    );
  }

  int getTextPosition(RainbowColor rainbowItem, int index) {
    // 0 = left, 1 = right
    if(EnvironmentConfig.BUNDLE_ID_SUFFIX == Const.PROD){
      return rainbowItem.position ?? _getRandomPosition();
    }
    else{
      return index % 2;
    }
  }

  int _getRandomPosition() => Random().nextInt(2);

  void _shuffle() {

    if (shuffleButtonState == ButtonState.Inactive) {
      shuffleButtonState = ButtonState.Active;

      List<RainbowColor> tempList = [];
      bool isSamePosition;


      int i = 0;
      for (var color in colors) {
        color.position = _getRandomPosition();

        if(i > 0) {
          isSamePosition = (color.position == tempList[i-1].position) && (isSamePosition ?? true);
        }

        tempList.add(color);
        i++;
      }

      setState(() {
        colors = tempList;
      });

      if(isSamePosition ?? false){
//        setState(() {
//          didWin = true;
//        });

        var alignment = 'Right';
        if(colors[0].position == 0) alignment = 'Left';

//        UIUtils.displayDialog(context: context, title: 'Success', message: 'Hurray!, you have aligned all the text to $alignment side');
        Navigator.push(context, MaterialPageRoute(builder: (_)=>QRDisplayPage(value: 'Success-$alignment Aligned',)));
      }
      shuffleButtonState = ButtonState.Inactive;
    }

  }

}