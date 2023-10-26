import 'package:employeeapp/model/user_model.dart';
import 'package:employeeapp/widgets/custom_Textfield.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final UserModel user;
  final Function(UserModel) onSave; 

  const EditScreen({Key? key, required this.user, required this.onSave})
      : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.firstName!;
    emailController.text = widget.user.email!;
    lastNameController.text = widget.user.lastName!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
        elevation: 1.0,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextfield(
              controller: nameController,
            ),
            SizedBox(height: 20),
           
            CustomTextfield(
              controller: lastNameController,
            ),
            SizedBox(height: 20),

            CustomTextfield(
              controller: emailController,
            ),
           
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    UserModel updatedUser = UserModel(
                      firstName: nameController.text,
                      email: emailController.text,
                      lastName: lastNameController.text,
                      avatar: widget.user.avatar,
                    );

                    widget.onSave(updatedUser);

                    Navigator.of(context).pop();
                  },
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
