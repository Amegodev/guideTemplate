import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guideTemplate/utils/strings.dart';
import 'package:guideTemplate/utils/theme.dart';
import 'package:guideTemplate/utils/tools.dart';

class CustomAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;
  final Widget ads;
  final VoidCallback onClicked;

  const CustomAppBar(
      {Key key, this.scaffoldKey, this.ads, this.title, this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            this.ads != null
                ? SizedBox(height: 60.0, child: this.ads)
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SvgPicture.asset(
                        'assets/icons/burger_menu.svg',
                        color: MyColors.black,
                      ),
                    ),
                    onPressed: () => scaffoldKey.currentState.openDrawer(),
                  ),
                  Expanded(
                    child: Text(
                      this.title,
                      style: MyTextStyles.title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SvgPicture.asset(
                        'assets/icons/about.svg',
                        color: MyColors.black,
                      ),
                    ),
                    onPressed: () async {
                      int count = await showDialog(
                          context: context, builder: (_) => RatingDialog());
                      String text = '';
                      if (count != null) {
                        if (count <= 2)
                          text = 'Your rating was $count ☹ alright, thank you.';
                        if (count == 3) text = 'Thanks for your rating 🙂';
                        if (count >= 4) text = 'Thanks for your rating 😀';
                        scaffoldKey.currentState.showSnackBar(
                          new SnackBar(
                            content: Text(text),
                          ),
                        );
                      }
                      if (count != null && count <= 3) this.onClicked();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  final Text title;
  final String svgIcon;
  final Color bgColor;
  final Color textColor;
  final Function() onClicked;

  const MainButton(
      {Key key,
      this.title,
      this.svgIcon,
      this.onClicked,
      this.bgColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: this.bgColor == null ? MyColors.grey2 : this.bgColor,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: MyColors.grey3),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: EdgeInsets.all(20.0),
        onPressed: this.onClicked,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: this.title,
            ),
            SvgPicture.asset(
              this.svgIcon,
              width: 30.0,
              color: this.textColor == null ? Colors.black : this.textColor,
            )
          ],
        ),
      ),
    );
  }
}

class BlueButton extends StatelessWidget {
  final String title;
  final String svgIcon;

  const BlueButton({Key key, this.title, this.svgIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      decoration: BoxDecoration(
        color: MyColors.black,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: SvgPicture.asset(
              this.svgIcon,
              height: 16.0,
              color: Colors.white,
            ),
          ),
          Text(
            this.title,
            style: MyTextStyles.fbSubTitleBold
                .apply(color: Colors.white, fontSizeFactor: 0.8),
          ),
        ],
      ),
    );
  }
}

class GreyButton extends StatelessWidget {
  final String svgIcon;

  const GreyButton({Key key, this.svgIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      width: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: MyColors.black,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: SvgPicture.asset(
        this.svgIcon,
        color: Colors.black,
      ),
    );
  }
}

class RatingDialog extends StatefulWidget {
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _stars = 0;

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        _stars >= starCount ? Icons.star : Icons.star_border,
        size: 30.0,
        color: _stars >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: () {
        print(starCount);
        if (starCount >= 4) {
          Navigator.pop(context);
          Tools.launchURLRate();
        }
        setState(() {
          _stars = starCount;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 80,
                  width: 80,
                  child: Image.asset('assets/icon.png'),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    child: Text(
                  Tools.packageInfo.appName,
                  style: MyTextStyles.bigTitle,
                ))
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              Strings.aboutText,
              textAlign: TextAlign.center,
              style: MyTextStyles.subTitle,
            ),
            Text(
              '👇 Please Rate Us 👇',
              textAlign: TextAlign.center,
              style: MyTextStyles.subTitle,
            ),
          ],
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildStar(1),
          _buildStar(2),
          _buildStar(3),
          _buildStar(4),
          _buildStar(5),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop(0);
          },
        ),
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(_stars);
          },
        )
      ],
    );
  }
}
