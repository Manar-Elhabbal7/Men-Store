import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:men_store/l10n/app_localizations.dart';
import 'package:men_store/features/auth/login/login_screen.dart';
import '../../core/localization/locale_cubit.dart';
import '../../core/theme/app_colors.dart';
import 'address_screen.dart';

class AccountScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  const AccountScreen({super.key, this.onBackToHome});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            if (widget.onBackToHome != null) {
              widget.onBackToHome!();
            } else if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.account,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildMenuOption(
              icon: Icons.shopping_bag_outlined,
              title: l10n.myOrders,
              onTap: () {
                AnimatedSnackBar.material(
                  l10n.ordersComingSoon,
                  type: AnimatedSnackBarType.info,
                  mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                ).show(context);
              },
            ),
            _buildMenuOption(
              icon: Icons.person_outline_rounded,
              title: l10n.myDetails,
              onTap: () {
                AnimatedSnackBar.material(
                  l10n.detailsComingSoon,
                  type: AnimatedSnackBarType.info,
                  mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                ).show(context);
              },
            ),
            _buildMenuOption(
              icon: Icons.location_on_outlined,
              title: l10n.addressBook,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddressScreen(),
                  ),
                );
              },
            ),
            _buildLanguageOption(context),
            _buildMenuOption(
              icon: Icons.help_outline_rounded,
              title: l10n.faqs,
              onTap: () {
                AnimatedSnackBar.material(
                  l10n.faqsComingSoon,
                  type: AnimatedSnackBarType.info,
                  mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                ).show(context);
              },
            ),
            _buildMenuOption(
              icon: Icons.support_agent_rounded,
              title: l10n.helpCenter,
              onTap: () {
                AnimatedSnackBar.material(
                  l10n.helpComingSoon,
                  type: AnimatedSnackBarType.info,
                  mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                ).show(context);
              },
            ),
            const SizedBox(height: 30),
            // Log Out Button
            _buildLogoutButton(l10n),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black87, size: 24),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey[400],
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            const Icon(Icons.language_rounded, color: Colors.black87, size: 24),
            const SizedBox(width: 20),
            Text(
              l10n.language,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: locale.languageCode,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                alignment: Alignment.centerRight,
                onChanged: (String? newLanguage) {
                  if (newLanguage != null) {
                    context.read<LocaleCubit>().changeLocale(newLanguage);
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: 'ar',
                    child: Text('العربية'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: OutlinedButton.icon(
          onPressed: () {
            // Simulated logout
            AnimatedSnackBar.material(
              l10n.logoutSuccess,
              type: AnimatedSnackBarType.success,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
            ).show(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
          label: Text(
            l10n.logOut,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.redAccent, width: 1.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
