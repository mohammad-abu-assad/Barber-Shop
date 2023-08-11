import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const urlImage = 'assets/shop_image.jpg';
    const urlLogo = 'assets/logo.jpg';
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            SizedBox(
              width: 400,
              height: 450,
              child: Stack(
                // Use a Stack to position the CircleAvatar
                children: [
                  Image.asset(
                    width: 400,
                    height: 300,
                    urlImage,
                    fit: BoxFit.cover,
                  ),
                  const Positioned(
                    top: 250,
                    left: 100,
                    child: CircleAvatar(
                        radius: 100, // Adjust the radius as needed
                        backgroundColor: Colors.blue,
                        backgroundImage:
                            AssetImage(urlLogo) // Change the background color
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Welcome to our Barber Shop!',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Experience the best haircuts and grooming services at our shop. We provide a wide range of modern and traditional styles.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
