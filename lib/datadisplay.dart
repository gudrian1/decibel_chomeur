import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import './Enregistrement/noise_listen.dart';
import 'Orange/page_resultat_orange.dart';
import 'Vert/page_resultat_vert.dart';
import 'Rouge/page_rouge.dart';


class ThirdRoute extends StatelessWidget {
  const ThirdRoute({Key? key}) : super(key: key);
  @override

    Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF9EA2A6),
      body: PageOrg(),
      );
    

  }
}



SoundDescription (dB) {
  var comment = "comment";
  String dBstring = dB.toStringAsFixed(2);
  if (dB < 10) {
    comment = "hmmm, " + dBstring + " Décibels ?\nC'est à peine le bruit d'une respiration...";
  }
  else if (dB < 20) {
    comment = "ooooh, " + dBstring + " Décibels ?\nOn entendrait le bruissement des feuilles...";
  }
  else if (dB < 30) {
    comment = "Ah, " + dBstring + " Décibels ?\nC'est comme se ballader dans un voisinage rurale plutôt calme.";
  }
  else if (dB < 40) {
    comment = "C'est sympa " + dBstring + " Décibels ?\nC'est comme les chants des oiseaux !";
  }
  else if (dB < 50) {
    comment = "hmm, " + dBstring + " Décibels ?\nParler dans son appartement est aussi fort.";
  }
  else if (dB < 60) {
    comment = "Eeeh " + dBstring + " Décibels ?\nOn dirait des bureaux bruillants";
  }
  else if (dB < 70) {
    comment = "Ahrr, " + dBstring + " Décibels ?\nUn bruit d'aspirateur peut déranger certaines personnes.";
  }
  else if (dB < 80) {
    comment = "Ouah " + dBstring + " Décibels ?\nLe mixeur peut faire beaucoup de bruit.";
  }
  else if (dB < 90) {
    comment = "Ah, " + dBstring + " Décibels ?\nC'est comme une tondeuse électrique.";
  }
  else if (dB < 100) {
    comment = "Oh la, " + dBstring + " Décibels ?\nUne exposition prolongé d'un bruit de \nmarteau-piqueur peut endommager votre ouïe.";
  }
  else if (dB < 110) {
    comment = "Ouah " + dBstring + " Décibels ?\nOn dirait un concert de rock!";
  }
  else if (dB < 120) {
    comment = "Euh " + dBstring + " Décibels ?\nCa va ? C'était un coups de foudre ?";
  }
  else if (dB < 130) {
    comment = "... " + dBstring + " Décibels ?\nVous êtes à 20 mètre d'un avion militaire au décolage ?";
  }
  else if (dB < 140) {
    comment = "Hmmm, " + dBstring + " Décibels ?\nVous êtes sur un pont de porte avion ?\n J'espère que vous avez le droit d'y être. ";
  }
  else {
    comment = "..." + dBstring + " Décibels ?\nVos tympans sont toujours là ?";
  }
  return comment;
}

PageDirection () {
  var page;

  if (getValue! < 70) {
    page = PageVert();
  }
  else if (getValue!< 90) {
    page = PageOrange();
  }
  else {
    page = PageRouge();
  }
  return page;
}

class PageOrg extends StatelessWidget {
  const PageOrg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pointerColor;

    if (getValue! < 70) {
      pointerColor = Colors.green;
    }
    else if (getValue! <= 90) {
      pointerColor = Colors.orange;
    }
    else {
      pointerColor = Colors.red;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        LogoSmall(),
        SizedBox(
          height: 40,
        ),
        Center(
        child: Container(
        child: SfRadialGauge(
        axes: <RadialAxis>[
        RadialAxis(showFirstLabel: false, maximumLabels: 0, startAngle: 180, endAngle: 0,minimum: 0, maximum: 150,
            axisLineStyle: AxisLineStyle(cornerStyle: CornerStyle.bothCurve),
        ranges: <GaugeRange>[
        GaugeRange(startValue: 0, endValue: 150, color:(Colors.blueGrey))],
        pointers: <GaugePointer>[RangePointer(
            value: getValue!, width: 0.1, sizeUnit: GaugeSizeUnit.factor, color: pointerColor,
            animationType: AnimationType.ease,
            enableAnimation: true, animationDuration: 2000,
            cornerStyle: CornerStyle.bothCurve)],

        annotations: <GaugeAnnotation>[
        GaugeAnnotation(angle: 270, positionFactor: 0.4  ,
        widget: Text(getValue!.toStringAsFixed(2), style:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 60),))]
    )
    ],
    ))
        ),
        SoundDisplay(),
        ButtonApres(),
      ],
    );
  }
}

class SoundDisplay extends StatelessWidget {
  const SoundDisplay({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String getSoundLevel = SoundDescription(getValue!);
    var displaySound = Text(getSoundLevel);
    return Container(child: displaySound);
  }
}
//comment
class LogoSmall extends StatelessWidget {
  const LogoSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var assetImage = const AssetImage('assets/Icones/image 2.png');
    var image = Image(image: assetImage, width: 110, height: 69);
    return Container(child: image);
  }
}

class ButtonApres extends StatelessWidget {
  const ButtonApres({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), primary: Color(0xFFC2C4B9),padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0), shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8)));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(width: 110, height: 56),
          ElevatedButton(
            style: style,
            onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  PageDirection ()),
            );
            },
            child: const Text('Et après ?'),
          ),
        ],
      ),
    );
  }
}