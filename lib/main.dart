import 'package:rollingsweets/animated_diamond.dart';
import 'package:rollingsweets/contact_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rollingsweets/products.dart';
import 'package:url_launcher/url_launcher.dart';

const Color maincolor = Color.fromRGBO(204, 182, 163, 1);
const Color secondaryColor = Color.fromARGB(255, 173, 143, 116);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rolling Sweets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: maincolor,
        textTheme: GoogleFonts.titilliumWebTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.black),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();

  static const double sectionHeight = 600;
  int currentSectionIndex = 0;

  void _scrollToSection(int index) {
    setState(() => currentSectionIndex = index);
    final extraHeight = index == 4 ? 0 : index * 300;
    scrollController.animateTo(
      index * sectionHeight + extraHeight,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    var facebook = GestureDetector(
      onTap: () => _launchInBrowser(Uri.parse(
          'https://www.facebook.com/people/Rolling-Sweets/61571098946086/#')),
      child: const Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Icon(
            Icons.facebook,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );

    var instagram = GestureDetector(
      onTap: () => _launchInBrowser(
          Uri.parse('https://www.instagram.com/rollingsweetsoland/')),
      child: const Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Icon(
            FontAwesomeIcons.instagram,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;
            return Container(
              color: maincolor,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/rs_logo_main.png',
                    color: Colors.black,
                  ),
                  if (!isMobile)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _menuButton('Hem', 0),
                        _menuButton('Produkter', 1),
                        _menuButton('Vagnen', 2),
                        _menuButton('Kontakt', 4),
                      ],
                    )
                  else
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black),
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: maincolor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: maincolor),
              child: Image.asset('assets/images/rs_logo_main.png',
                  color: Colors.black),
            ),
            ListTile(
              title: const Text('Hem'),
              onTap: () {
                Navigator.of(context).pop();
                _scrollToSection(0);
              },
            ),
            ListTile(
              title: const Text('Produkter'),
              onTap: () {
                Navigator.of(context).pop();
                _scrollToSection(1);
              },
            ),
            ListTile(
              title: const Text('Vagnen'),
              onTap: () {
                Navigator.of(context).pop();
                _scrollToSection(2);
              },
            ),
            ListTile(
              title: const Text('Kontakt'),
              onTap: () {
                Navigator.of(context).pop();
                _scrollToSection(4);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SizedBox.expand(
                  child: Image.asset(
                    'assets/images/cookies.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _section(
                        color: maincolor,
                        child: SizedBox.expand(
                          child: Stack(
                            children: [
                              const DiamondFadeInGrid(),
                              Center(
                                child: Image.asset(
                                  'assets/images/rs_logo_main.png',
                                  fit: BoxFit.cover,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  instagram,
                                  const SizedBox(width: 20),
                                  facebook,
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 300),
                      _section(
                        color: maincolor,
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              bool isMobile = constraints.maxWidth < 700;
                              return Column(
                                children: [
                                  const SizedBox(height: 70),
                                  Text(
                                    'PRODUKTER',
                                    style: GoogleFonts.titilliumWeb(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  const SizedBox(
                                    width: 50,
                                    child: Divider(),
                                  ),
                                  const SizedBox(height: 20),
                                  if (!isMobile)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: products,
                                    )
                                  else
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: products,
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 300),
                      _section(
                        color: maincolor,
                        child: Center(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              bool isMobile = constraints.maxWidth < 700;
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.all(isMobile ? 10 : 40),
                                padding: EdgeInsets.all(isMobile ? 8 : 20),
                                child: isMobile
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/truck.jpg',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 180,
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            'VAGNEN',
                                            style: GoogleFonts.titilliumWeb(
                                                fontSize: 26,
                                                fontWeight: FontWeight.w300),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 10),
                                          const SizedBox(
                                              width: 50, child: Divider()),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Det här är mitt omgjorda släp som jag står i när jag är ute på marknader – ett litet rullande popup-café och glassbar där all försäljning sker direkt över disk. Släpet har blivit en del av helhetsupplevelsen: personligt, hemtrevligt och fullt av doften från nybakade kakor och färsk glass. \n\nVid förfrågan går det även att hyra vagnen till event, kunddagar eller andra tillfällen där du vill bjuda på något gott med lite extra charm.',
                                            style: GoogleFonts.titilliumWeb(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: 400,
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 20),
                                                Text(
                                                  'VAGNEN',
                                                  style:
                                                      GoogleFonts.titilliumWeb(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(height: 20),
                                                const SizedBox(
                                                    width: 50,
                                                    child: Divider()),
                                                const SizedBox(height: 30),
                                                Text(
                                                  'Det här är mitt omgjorda släp som jag står i när jag är ute på marknader – ett litet rullande popup-café och glassbar där all försäljning sker direkt över disk. Släpet har blivit en del av helhetsupplevelsen: personligt, hemtrevligt och fullt av doften från nybakade kakor och färsk glass. \n\nVid förfrågan går det även att hyra vagnen till event, kunddagar eller andra tillfällen där du vill bjuda på något gott med lite extra charm.',
                                                  style:
                                                      GoogleFonts.titilliumWeb(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Image.asset(
                                            'assets/images/truck.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      _section(
                        height: 750,
                        color: Colors.transparent,
                        child: Center(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              bool isMobile = constraints.maxWidth < 700;
                              return Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(isMobile ? 10 : 24),
                                child: SizedBox(
                                  width: isMobile ? double.infinity : 500,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 20),
                                      Text(
                                        'KONTAKT',
                                        style: GoogleFonts.titilliumWeb(
                                            fontSize: isMobile ? 24 : 30,
                                            fontWeight: FontWeight.w300),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      const SizedBox(
                                          width: 50, child: Divider()),
                                      const SizedBox(height: 30),
                                      isMobile
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                        height:
                                                            isMobile ? 0 : 20),
                                                    Text(
                                                      'Rolling Sweets',
                                                      style: GoogleFonts
                                                          .titilliumWeb(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            isMobile ? 0 : 20),
                                                    GestureDetector(
                                                      onTap: _launchEmail,
                                                      child: Text(
                                                        'emelie@rollingsweets.se',
                                                        style: GoogleFonts
                                                            .titilliumWeb(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                      ),
                                                    ),
                                                    Text(
                                                      '076 - 227 09 73',
                                                      style: GoogleFonts
                                                          .titilliumWeb(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            isMobile ? 0 : 20),
                                                    Text(
                                                      'Öland, Sweden',
                                                      style: GoogleFonts
                                                          .titilliumWeb(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 20),
                                                const ContactForm(),
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      'Rolling Sweets',
                                                      style: GoogleFonts
                                                          .titilliumWeb(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    GestureDetector(
                                                      onTap: _launchEmail,
                                                      child: Text(
                                                        'emelie@rollingsweets.se',
                                                        style: GoogleFonts
                                                            .titilliumWeb(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                      ),
                                                    ),
                                                    Text(
                                                      '076 - 227 09 73',
                                                      style: GoogleFonts
                                                          .titilliumWeb(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      'Öland, Sweden',
                                                      style: GoogleFonts
                                                          .titilliumWeb(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 20),
                                                const ContactForm(),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        color: maincolor,
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                instagram,
                                const SizedBox(width: 10),
                                facebook,
                              ],
                            ),
                            Text(
                              '© 2025 Hovmark',
                              style: GoogleFonts.titilliumWeb(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuButton(String title, int index) {
    return TextButton(
      onPressed: () => _scrollToSection(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          title.toUpperCase(),
          style: GoogleFonts.titilliumWeb(
            fontWeight: currentSectionIndex == index
                ? FontWeight.w500
                : FontWeight.w300,
            color: currentSectionIndex == index ? Colors.white : Colors.white60,
          ),
        ),
      ),
    );
  }

  Widget _section(
      {required Color? color,
      required Widget child,
      double height = sectionHeight}) {
    return Container(
      height: height,
      width: double.infinity,
      color: color,
      child: child,
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.platformDefault,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'emelie@rollingsweets.se',
      query: Uri.encodeFull(
          'subject=Hembakat-förfrågan&body=Hejsan, jag hittade din hemsida och...'),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch email app';
    }
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.header,
    required this.description,
    this.icon,
    this.customIcon,
  });
  final String header;
  final String description;
  final IconData? icon;
  final Widget? customIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: EdgeInsets.all(customIcon != null ? 16.0 : 27.0),
            child: customIcon ??
                Icon(
                  icon,
                  size: 60,
                  color: Colors.white,
                ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          header,
          style: GoogleFonts.titilliumWeb(
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 200,
          child: Text(
            description,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class ImageWithBorder extends StatelessWidget {
  const ImageWithBorder({
    super.key,
    required this.imagePath,
  });
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class DiamondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0) // Top point
      ..lineTo(size.width, size.height / 2) // Right point
      ..lineTo(size.width / 2, size.height) // Bottom point
      ..lineTo(0, size.height / 2) // Left point
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
