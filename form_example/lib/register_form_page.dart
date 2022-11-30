import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_example/user_info_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'model/user.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;
  bool _hidePass1 = true;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  List<String> _countries = ['Russia', 'Ukraine', 'Germany', 'France',];
  String? _selectedCounry;

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _countryFocus = FocusNode();
  final _storyFocus = FocusNode();
  final _passFocus = FocusNode();
  final _confPassFocus = FocusNode();

  User newUser = User();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _countryFocus.dispose();
    _storyFocus.dispose();
    _passFocus.dispose();
    _confPassFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus,
      FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Form'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name *',
                hintText: 'What do people call you?',
                prefixIcon: Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: (){
                    _nameController.clear();
                  },
                  child: Icon(
                    Icons.delete_outline,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              validator: _validateName,
              onSaved: (value) => newUser.name = value!,
            ),
            SizedBox(height: 10,),
            TextFormField(
              focusNode: _phoneFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _phoneFocus, _emailFocus);
              },
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number *',
                hintText: 'Where can we reach you?',
                helperText: 'Phone format : +x (xxx) xxx-xx-xx',
                prefixIcon: Icon(Icons.call),
                suffixIcon: GestureDetector(
                  onLongPress: (){
                    _phoneController.clear();
                  },
                  child: Icon(
                    Icons.delete_outline,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                // FilteringTextInputFormatter.digitsOnly,
                _maskFormatter

              ],
              validator: (value) =>
              _validatePhoneNumber(value!)
                  ? null
                  : 'Phone number must be entered as  +x (xxx) xxx-xx-xx',
              onSaved: (value) => newUser.phone = value!,
            ),
            TextFormField(
              focusNode: _emailFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _emailFocus, _storyFocus);
              },
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter a email address',
                prefixIcon: Icon(Icons.mail),
              ),
              validator: _validEmail,
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => newUser.email = value!,
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              focusNode: _countryFocus,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.map),
                  labelText: 'Country?'),
              items: _countries.map((country) {
                return DropdownMenuItem(
                  child: Text(country),
                  value: country,
                );
              }).toList(),
              onChanged: (country) {
                print(country);
                setState(() {
                  _selectedCounry = country;
                  newUser.country = country!;
                });
              },
              value: _selectedCounry,
              validator: (val) {
                return val == null ? 'Please select a country' : null;
              },
              onSaved: (value) => newUser.country = value!,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: _storyFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _storyFocus, _passFocus);
              },
              controller: _storyController,
              decoration: const InputDecoration(
                labelText: 'Life Story',
                hintText: 'Tell us about your self',
                helperText: 'Keep it short, this is just a demo',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              maxLines: 3,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              onSaved: (value) => newUser.story = value!,
            ),
            TextFormField(
              focusNode: _passFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _passFocus, _confPassFocus);
              },
              controller: _passController,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Password *',
                hintText: 'Enter the password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                  icon:
                  Icon(_hidePass ? Icons.visibility_off : Icons.visibility),
                ),
                prefixIcon: Icon(Icons.security),
              ),
              validator: _validatePassword,
            ),
            TextFormField(
              focusNode: _confPassFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _passFocus, _countryFocus);
              },
              controller: _confirmPassController,
              obscureText: _hidePass1,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Confirm Password *',
                hintText: 'Confirm the Text',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePass1 = !_hidePass1;
                    });
                  },
                  icon: Icon(
                      _hidePass1 ? Icons.visibility_off : Icons.visibility),
                ),
                prefixIcon: Icon(Icons.border_color),
              ),
              validator: _validatePassword,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              child: const Text('Submit Form'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      _showDialog(name: _nameController.text);
      print('form is valid');
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      print('Story: ${_storyController.text}');
      print('pass: ${_passController.text}');
      print('confirmPass: ${_confirmPassController.text}');
    } else {
      print('Form is not valid!');
    }
  }

  String? _validateName(String? value) {
    final _nameExp = RegExp(r'^[A-z]+$');
    if (value!.isEmpty) {
      return 'Name is reqired';
    } else if (!_nameExp.hasMatch(value)) {
      return 'please enter alphabetical characters';
    } else {
      return null;
    }
  }

  bool _validatePhoneNumber(String input) {
    final _phoneExp = RegExp(r'[0-9]');
    return _phoneExp.hasMatch(input);
  }

  var _maskFormatter = new MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  String? _validEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email cannot be empty';
    } else if (!_emailController.text.contains('@')) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (_passController.text.length != 8) {
      return '8 character required for password';
    } else if (_confirmPassController.text != _passController.text) {
      return 'Password does not match';
    } else {
      return null;
    }
  }

  void _showDialog({String? name}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Registration successful',
            style: TextStyle(color: Colors.green),
          ),
          content: Text(
            '$name is now a verified register form',
                style: TextStyle(
              fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoPage(
                      userInfo: newUser,
                    ),
                  )
                );
              },
              child: Text(
                'Verified',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                ),
              ),
            )
          ],
        );
      });
  }

}
