import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/playground/hero_item.dart';
import 'hero_detail_page.dart';

const _heroItems = <HeroItem>[
  HeroItem(
    tag: '大谷 翔平',
    imageURL:
        'https://the-ans.jp/wp-content/uploads/2022/03/22163207/20220322_Shohei-Ohtani2_AP-650x433.jpg',
    description: '大谷 翔平（おおたに しょうへい、1994年7月5日 - ）は、'
        '岩手県奥州市出身のプロ野球選手。右投左打。MLBのロサンゼルス・エンゼルス所属。',
  ),
  HeroItem(
    tag: '鈴木 誠也',
    imageURL: 'https://portal.st-img.jp/detail/485e11cb02be9007e4d50bc54cc3e60b_1648723133_2.jpg',
    description: '鈴木 誠也（すずき せいや、1994年8月18日 - ）は、'
        '東京都荒川区出身のプロ野球選手（外野手）。右投右打。MLBのシカゴ・カブス所属。',
  ),
  HeroItem(
    tag: 'ダルビッシュ 有',
    imageURL:
        'https://static.chunichi.co.jp/image/article/size1/3/e/d/2/3ed287d5dcdd2c49e50f7eeffffe4833_1.jpg',
    description: 'ダルビッシュ 有（ダルビッシュ ゆう、英語: Yu Darvish、本名：ダルビッシュ・'
        'セファット・ファリード・有〈ダルビッシュ セファット ファリード ゆう、'
        '英語: Sefat Farid Yu Darvish[4]〉、1986年8月16日 - ）は、大阪府羽曳野市出身のプロ野球選手'
        '（投手・右投右打）。MLBのサンディエゴ・パドレス所属。',
  ),
];

/// タップしてヒーローアニメーションで画面遷移したい ListView のページ
class HeroImagesPage extends StatelessWidget {
  const HeroImagesPage({super.key});

  static const path = '/hero-images/';
  static const name = 'HeroImagesPage';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: _heroItems.length,
        itemBuilder: (context, index) {
          final heroItem = _heroItems[index];
          return TapToScaleDownAnimationWidget(
            child: Hero(
              tag: heroItem.tag,
              child: HeroCardWidget(
                heroItem: heroItem,
                onTap: () async {
                  await Navigator.pushNamed<void>(
                    context,
                    HeroImageDetailPage.location,
                    arguments: heroItem,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class GreenContainerPage extends StatelessWidget {
  const GreenContainerPage({super.key});

  static const path = '/green-container/';
  static const name = 'GreenContainerPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: 'boxHero',
            child: Container(
              width: 200,
              height: 200,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}

/// ヒーローカードのウィジェット
class HeroCardWidget extends HookConsumerWidget {
  const HeroCardWidget({
    super.key,
    required this.heroItem,
    this.onTap,
  });

  final HeroItem heroItem;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: heroItem.imageURL,
                imageBuilder: (context, imageProvider) => Image(
                  image: imageProvider,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                placeholder: (context, url) => const SizedBox(),
                errorWidget: (context, url, dynamic error) => const SizedBox(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Text(
                  heroItem.description,
                  style: const TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
        if (onTap != null)
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(onTap: onTap),
            ),
          ),
      ],
    );
  }
}

/// タップして押し込むとそのウィジェットサイズが縮小する
/// アニメーションを子に付加するウィジェット
class TapToScaleDownAnimationWidget extends StatefulWidget {
  const TapToScaleDownAnimationWidget({super.key, required this.child});
  final Widget child;

  @override
  State<StatefulWidget> createState() => TapToScaleDownAnimationWidgetState();
}

class TapToScaleDownAnimationWidgetState extends State<TapToScaleDownAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleDownAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _scaleDownAnimation = Tween<double>(begin: 1, end: 0.95)
        .animate(CurvedAnimation(parent: _controller.view, curve: Curves.ease))
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: (_) {
          _controller
            ..stop()
            ..forward(from: 0);
        },
        onTapUp: (_) {
          _controller
            ..stop()
            ..reverse(from: 1);
        },
        onTapCancel: () {
          _controller
            ..stop()
            ..reverse(from: 1);
        },
        child: ScaleTransition(scale: _scaleDownAnimation, child: widget.child),
      );
}
