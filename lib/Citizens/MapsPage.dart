import 'package:buzzoff/Citizens/SigInPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'complains.dart';
import 'analytics.dart';
import 'EditProfile.dart'; // ✅ make sure the path is correct

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  String _username = '';

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  void fetchUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        final data = doc.data();
        setState(() {
          _username = data?['username'] ?? 'User';
        });
      }
    }
  }

  void _handleMenuSelection(String value) {
    if (value == 'edit') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const EditAccountPage()),
      );
    } else if (value == 'SignOut') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SignInPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Good morning\n${_username.toUpperCase()}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFFDAA8F4),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('images/pfp.png'),
                        radius: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _username,
                        style: const TextStyle(color: Colors.white),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        color: Colors.grey[900],
                        onSelected: _handleMenuSelection,
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit Profile'),
                          ),
                          const PopupMenuItem(
                            value: 'SignOut',
                            child: Text('SignOut Of Profile'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Nav Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavIcon(
                    label: 'Map',
                    asset: 'map',
                    isSelected: true,
                    onTap: () {},
                  ),
                  _NavIcon(
                    label: 'Complains',
                    asset: 'complains',
                    isSelected: false,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ComplainsPage(),
                        ),
                      );
                    },
                  ),
                  _NavIcon(
                    label: 'Analytics',
                    asset: 'analytics',
                    isSelected: false,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AnalyticsPage(),
                        ),
                      );
                    },
                  ),
                  _NavIcon(
                    label: 'Fines',
                    asset: 'fines_and_payments',
                    isSelected: false,
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Center(
                child: Text(
                  'SEE DENGUE PATIENTS CLOSE TO YOU',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('images/map_map.png'),
              ),

              const SizedBox(height: 24),

              // Tips Section
              SizedBox(
                height: 170,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: 13,
                        onPageChanged: (index) {
                          setState(() => _currentPage = index);
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'images/tips${index + 1}.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        13,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final String label;
  final String asset;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavIcon({
    required this.label,
    required this.asset,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLightBox = !isSelected;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 90,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2D1237) : const Color(0xFFCA9CDB),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/$asset.png', width: 38, height: 38),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isLightBox ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
