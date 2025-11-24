import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/app/topbar.dart';
import 'package:imdb_app/data/model/user/user_model.dart';
import 'package:imdb_app/features/profile/utils/auth_provider.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    user = authProvider.user!;
    _userFullNameController.text = user!.fullName;
    _userEmailController.text = user!.email;
    _userPhoneNumberController.text = user!.phone ?? '';
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
                title: "Edit User",
                callback: () => context.push(AppRoutes.profile),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: (user?.isVerified ?? false)
                            ? Colors.green.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: (user?.isVerified ?? false)
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            (user?.isVerified ?? false)
                                ? Icons.verified_user
                                : Icons.gpp_maybe,
                            color: (user?.isVerified ?? false)
                                ? Colors.green
                                : Colors.orange,
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
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.orange[800],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _userFullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _userEmailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _userPhoneNumberController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Save action
                      },
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
}
