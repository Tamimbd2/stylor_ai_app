import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Header
              const Text(
                'Cart',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1C1C1E),
                  fontSize: 24,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w700,
                  height: 1.40,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Your choices shape your AI style feed.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF101C2C),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.56,
                ),
              ),
              const SizedBox(height: 24),

              // Cart Items
              _buildCartCard('assets/image/clothes.png'),
              _buildCartCard('assets/image/dreess1.png'),
              _buildCartCard('assets/image/shoe.png'),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartCard(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        height: 156,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF4F4F4)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F101828),
              blurRadius: 64,
              offset: Offset(0, 32),
              spreadRadius: -12,
            ),
          ],
        ),
        child: Row(
          children: [
            // Product Image Container
            Container(
              width: 134,
              height: 132,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFF4F4F4)),
              ),
              child: Center(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Product Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12, right: 12, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'ONLMADISON High waist Wide Leg Fit Jeans',
                      style: TextStyle(
                        color: Color(0xFF1C1C1E),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.56,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Text(
                      '\$20.50',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Helvetica Neue',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),
                    Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF060017),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Buy Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Helvetica Neue',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}