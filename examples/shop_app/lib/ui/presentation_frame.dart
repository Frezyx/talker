import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_shop_app_example/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class PresentationFrame extends StatelessWidget {
  const PresentationFrame({
    super.key,
    required this.child,
    required this.talkerTheme,
  });

  final Widget child;
  final TalkerScreenTheme talkerTheme;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb && MediaQuery.of(context).size.width > 600) {
      const MediaQueryData mq = MediaQueryData(
        size: Size(414, 896),
        padding: EdgeInsets.only(top: 44, bottom: 34),
        devicePixelRatio: 2,
      );
      return Material(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.red),
              child: const Text(
                'Interact with Application to see changes in Logs Preview',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 60, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _LogsPreview(talkerTheme: talkerTheme),
                  const SizedBox(width: 20),
                  _ApplicationPreview(mq: mq, child: child),
                  const SizedBox(width: 60),
                  const _TalkerAboutSection(mq: mq),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return child;
  }
}

class _TalkerAboutSection extends StatelessWidget {
  const _TalkerAboutSection({
    required this.mq,
  });

  final MediaQueryData mq;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          padding: const EdgeInsets.only(bottom: 40),
          width: mq.size.width,
          height: mq.size.height,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              GestureDetector(
                onTap: _openGitHub,
                child: Row(
                  children: [
                    const Text(
                      'Talker',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 70,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'v4.0.0',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'Now your app is not\na black box',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
                maxLines: 3,
                overflow: TextOverflow.clip,
              ),
              const Spacer(),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: _openPubDev,
                    child: Row(
                      children: [
                        Image.asset('assets/flutter.png', height: 70),
                        const SizedBox(width: 10),
                        const Text(
                          'Flutter',
                          style: TextStyle(
                            fontSize: 32,
                            color: Color(0xFF01579B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: _openGitHub,
                    child: Row(
                      children: [
                        Image.asset('assets/github.png', height: 70),
                        const SizedBox(width: 10),
                        const Text(
                          'GitHub',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _openGitHub() {
    launchUrl(Uri.parse('https://github.com/Frezyx/talker'));
  }

  void _openPubDev() {
    launchUrl(Uri.parse('https://pub.dev/packages/talker'));
  }
}

class _ApplicationPreview extends StatelessWidget {
  const _ApplicationPreview({
    required this.mq,
    required this.child,
  });

  final MediaQueryData mq;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Builder(builder: (context) {
          final device = MediaQuery(
            data: mq,
            child: Container(
              width: mq.size.width,
              height: mq.size.height,
              alignment: Alignment.center,
              child: child,
            ),
          );
          return Column(
            children: [
              const Text(
                'Application',
                style: TextStyle(fontSize: 50),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black, width: 12)),
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(38.5),
                  child: device,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _LogsPreview extends StatelessWidget {
  const _LogsPreview({
    required this.talkerTheme,
  });

  final TalkerScreenTheme talkerTheme;

  @override
  Widget build(BuildContext context) {
    const MediaQueryData mediaQuery = MediaQueryData(
      size: Size(800, 896),
      padding: EdgeInsets.only(top: 44, bottom: 34),
      devicePixelRatio: 2,
    );
    return Flexible(
      flex: 5,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Builder(builder: (context) {
          final device = MediaQuery(
            data: mediaQuery,
            child: Container(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height,
              alignment: Alignment.center,
              child: TalkerBuilder(
                  talker: DI<Talker>(),
                  builder: (context, data) {
                    final reversedLogs = data.reversed.toList();
                    return Container(
                      color: const Color(0xFF212121),
                      child: CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(child: SizedBox(height: 40)),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final data = reversedLogs[index];
                                return TalkerDataCard(
                                  data: data,
                                  color: data.getFlutterColor(talkerTheme),
                                );
                              },
                              childCount: reversedLogs.length,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          );
          return Column(
            children: [
              const Text(
                'Logs preview',
                style: TextStyle(fontSize: 50),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey[700]!, width: 6),
                ),
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(7),
                  child: device,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
