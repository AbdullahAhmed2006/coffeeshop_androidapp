import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _orderNotifications = true;
  bool _promoAlerts = true;
  bool _soundEffects = true;
  String _selectedGrind = 'Whole Bean';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        backgroundColor: AppColors.background(context),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textPrimary(context),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'App Settings',
          style: TextStyle(
            color: AppColors.textPrimary(context),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Appearance Section ──
            _sectionHeader('APPEARANCE & THEME'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card(context),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border(context)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Theme Preference',
                    style: TextStyle(
                      color: AppColors.textPrimary(context),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Choose how My Coffee Shop looks on your device.',
                    style: TextStyle(
                      color: AppColors.textSecondary(context),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _themeOptionCard(
                          title: 'Dark Mode',
                          icon: Icons.dark_mode_rounded,
                          isSelected: themeProvider.isDarkMode,
                          onTap: () => themeProvider.toggleTheme(true),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _themeOptionCard(
                          title: 'Light Mode',
                          icon: Icons.light_mode_rounded,
                          isSelected: !themeProvider.isDarkMode,
                          onTap: () => themeProvider.toggleTheme(false),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // ── Notifications Section ──
            _sectionHeader('NOTIFICATIONS'),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: AppColors.card(context),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border(context)),
              ),
              child: Column(
                children: [
                  _switchTile(
                    icon: Icons.local_shipping_outlined,
                    title: 'Order Status Alerts',
                    subtitle: 'Real-time updates on coffee brewing & pickup',
                    value: _orderNotifications,
                    onChanged: (v) => setState(() => _orderNotifications = v),
                  ),
                  Divider(height: 1, color: AppColors.border(context)),
                  _switchTile(
                    icon: Icons.discount_outlined,
                    title: 'Special Offers & Rewards',
                    subtitle: 'Exclusive discounts on beans & brews',
                    value: _promoAlerts,
                    onChanged: (v) => setState(() => _promoAlerts = v),
                  ),
                  Divider(height: 1, color: AppColors.border(context)),
                  _switchTile(
                    icon: Icons.volume_up_outlined,
                    title: 'In-App Sound Effects',
                    subtitle: 'Brew sounds and order completion chime',
                    value: _soundEffects,
                    onChanged: (v) => setState(() => _soundEffects = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // ── Coffee Brewing Preferences ──
            _sectionHeader('BREWING PREFERENCES'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card(context),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border(context)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.coffee_rounded,
                                color: AppColors.kPrimaryOrange, size: 22),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                'Default Bean Grind',
                                style: TextStyle(
                                  color: AppColors.textPrimary(context),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedGrind,
                          isDense: true,
                          dropdownColor: AppColors.card(context),
                          icon: const Icon(Icons.arrow_drop_down,
                              color: AppColors.kPrimaryOrange),
                          items: ['Whole Bean', 'Espresso Fine', 'French Press', 'Pour Over']
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        color: AppColors.textPrimary(context),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedGrind = val);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // ── System & Cache ──
            _sectionHeader('DATA & STORAGE'),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: AppColors.card(context),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border(context)),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.cardAlt(context),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.cleaning_services_outlined,
                      color: AppColors.kPrimaryOrange, size: 20),
                ),
                title: Text(
                  'Clear App Cache',
                  style: TextStyle(
                    color: AppColors.textPrimary(context),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Free up temporary image cache (14.2 MB)',
                  style: TextStyle(
                    color: AppColors.textSecondary(context),
                    fontSize: 12,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right, color: AppColors.kGreyText),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cache cleared successfully!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.kPrimaryOrange,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _themeOptionCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.kPrimaryOrange.withValues(alpha: 0.15)
              : AppColors.cardAlt(context),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.kPrimaryOrange
                : AppColors.border(context),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppColors.kPrimaryOrange
                  : AppColors.textSecondary(context),
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? AppColors.kPrimaryOrange
                    : AppColors.textPrimary(context),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.cardAlt(context),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.kPrimaryOrange, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textPrimary(context),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.textSecondary(context),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeTrackColor: AppColors.kPrimaryOrange,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
