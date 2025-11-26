import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/app/topbar.dart';
import 'package:imdb_app/data/model/user/user_model.dart';
import 'package:imdb_app/features/profile/utils/auth_provider.dart';
import 'package:provider/provider.dart';

enum GenreEnum { male, female }

class UserEditPage extends StatefulWidget {
  const UserEditPage({super.key});

  @override
  State<UserEditPage> createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  UserModel? user;
  AuthProvider authProvider = AuthProvider();

  final TextEditingController _userFullNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPhoneNumberController =
      TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  GenreEnum? selectedGender;
  @override
  void initState() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    user = authProvider.user!;
    _userFullNameController.text = user!.fullName;
    _userEmailController.text = user!.email;
    _userPhoneNumberController.text = user!.phone ?? '';
    selectedGender = GenreEnum.male;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(
                title: "Edit Profile",
                callback: () => context.push(AppRoutes.profile),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    userVerifiedContent(),
                    Text(
                      "Personal",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.headlineLarge!.color,
                      ),
                    ),
                    TextField(
                      controller: _userFullNameController,
                      decoration: buildInputDecoration(hintText: "Full Name"),
                      style: TextStyle(fontSize: 14),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 1,
                            child: _genderCard(selectedGender!, Icons.male),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: _birthDateController,
                              readOnly: true,
                              onTap: () => _selectDate(context),
                              decoration:
                                  buildInputDecoration(
                                    hintText: "Birth Date",
                                  ).copyWith(
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5),
                    Text(
                      "Contact",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.headlineLarge!.color,
                      ),
                    ),
                    TextField(
                      controller: _userEmailController,
                      decoration: buildInputDecoration(hintText: "Email"),
                      style: TextStyle(fontSize: 14),
                    ),
                    TextField(
                      controller: _userPhoneNumberController,
                      decoration: buildInputDecoration(
                        hintText: "+90 *** *** ****",
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Save action
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48),
                        textStyle: TextStyle(fontSize: 14),
                      ),
                      child: Text('Save Changes'),
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

  Container userVerifiedContent() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (user?.isVerified ?? false)
            ? Colors.green.withOpacity(0.1)
            : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (user?.isVerified ?? false) ? Colors.green : Colors.orange,
        ),
      ),
      child: Row(
        children: [
          Icon(
            (user?.isVerified ?? false) ? Icons.verified_user : Icons.gpp_maybe,
            color: (user?.isVerified ?? false) ? Colors.green : Colors.orange,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (user?.isVerified ?? false)
                      ? "Verified Account"
                      : "Unverified Account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: (user?.isVerified ?? false)
                        ? Colors.green[700]
                        : Colors.orange[800],
                  ),
                ),
                if (!(user?.isVerified ?? false)) ...[
                  const SizedBox(height: 4),
                  Text(
                    "Please verify your email address.",
                    style: TextStyle(fontSize: 13, color: Colors.orange[800]),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration buildInputDecoration({String hintText = ''}) {
    return InputDecoration(
      hintText: hintText,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.onSecondary.withAlpha(128),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              onSurface: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Widget _genderCard(GenreEnum gender, IconData icon) {
    bool isMale = selectedGender == GenreEnum.male;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = isMale ? GenreEnum.female : GenreEnum.male;
        });
      },

      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isMale
              ? Theme.of(context).colorScheme.primary.withAlpha(25)
              : Colors.pink.withAlpha(25),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isMale
                ? Theme.of(context).colorScheme.primary.withAlpha(25)
                : Colors.pink.withAlpha(25),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isMale ? Icons.male : Icons.female,
              color: isMale
                  ? Theme.of(context).colorScheme.primary
                  : Colors.pink,
              size: 24,
            ),
            SizedBox(width: 6),
            Text(
              selectedGender.toString().split('.').last.toUpperCase(),
              style: TextStyle(
                color: isMale
                    ? Theme.of(context).colorScheme.primary
                    : Colors.pink,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
