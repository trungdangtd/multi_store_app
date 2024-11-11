import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_store_app/controller/auth_controller.dart';
import 'package:multi_store_app/provider/user_provider.dart';

class ShippingAddressScreen extends ConsumerStatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends ConsumerState<ShippingAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _localityController;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider);

    //initialize the controller with the cuurent data if available
    //if not, initialize with empty string
    _stateController = TextEditingController(text: user?.state ?? '');
    _cityController = TextEditingController(text: user?.city ?? '');
    _localityController = TextEditingController(text: user?.locality ?? '');
  }

  //show loading dialog
  _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Đang Tải...',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 18),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    final updateUser = ref.read(userProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.96),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        elevation: 0,
        title: Text(
          'Địa chỉ giao hàng',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'where will your order\nbe shipped?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                  controller: _stateController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập state';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'State',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _cityController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập city';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'City',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _localityController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập locality';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Locality',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              _showLoadingDialog();
              await _authController
                  .updateUserLocation(
                context: context,
                id: user!.id,
                state: _stateController.text,
                city: _cityController.text,
                locality: _localityController.text,
              )
                  .whenComplete(() {
                updateUser.recreateUserState(
                    state: _stateController.text, city: _cityController.text, locality: _localityController.text);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              });
            } else {
              // ignore: avoid_print
              print('invalid');
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(
                0xff3854ee,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text('Lưu địa chỉ',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
