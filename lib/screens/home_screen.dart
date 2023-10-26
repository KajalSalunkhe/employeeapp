import 'package:employeeapp/model/user_model.dart';
import 'package:employeeapp/repo/user_repo.dart';
import 'package:employeeapp/screens/edit_screen.dart';
import 'package:employeeapp/screens/helper/hive_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserRepo userRepo = UserRepo();
  List<UserModel> userList = [];
  final HiveHelper hiveHelper = HiveHelper();
  int selectedUserIndex = 0;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    try {
      List<UserModel> users = await userRepo.getUser();
      print('Users from API: $users');

      setState(() {
        userList = users;
      });
    } catch (error) {
      print("Error loading user data: $error");
    }
  }

  void selectUser(int index) {
    setState(() {
      selectedUserIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee App'),
        elevation: 1.0,
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              loadUsers();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: userList.asMap().entries.map((entry) {
                  print("Number of users: ${userList.length}");

                  final index = entry.key;
                  final user = entry.value;
                  return GestureDetector(
                    onTap: () {
                      selectUser(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedUserIndex == index
                              ? Colors.deepPurpleAccent
                              : Colors.white,
                          border: Border.all(
                            color: Colors.black, // Border color
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          '${user.firstName} ${user.lastName}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: selectedUserIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            // User list
            Expanded(
              child: userList.isEmpty
                  ? Center(child: Text("No users available"))
                  : ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (_, index) {
                        return selectedUserIndex == index
                            ? Container(
                                height: 300,
                                child: Card(
                                  color: Theme.of(context).primaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                              userList[index]
                                                  .avatar
                                                  .toString()),
                                        ),
                                        SizedBox(height: 30),
                                        Text(
                                          'First Name: ${userList[index].firstName}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          'Last Name: ${userList[index].lastName}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          'Email ID: ${userList[index].email}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.edit,
                                                  color: Colors.white),
                                              onPressed: () async {
                                                editUser(index);
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.delete,
                                                  color: Colors.white),
                                              onPressed: () {
                                                setState(() {
                                                  deleteUser(index);
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteUser(int index) {
    hiveHelper.deleteUser(index);
    setState(() {
      userList.removeAt(index);
      selectedUserIndex = -1;
    });
  }

  Future<void> editUser(int index) async {
    final updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(
          user: userList[index],
          onSave: (updatedUser) {
            setState(() {
              userList[index] = updatedUser;
            });
          },
        ),
      ),
    );

    if (updatedUser != null) {
      await hiveHelper.updateUser(index, updatedUser);
      setState(() {
        userList[index] = updatedUser;
      });
    }
  }
}
