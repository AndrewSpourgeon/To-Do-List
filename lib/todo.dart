import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoListApp extends StatefulWidget {
  const TodoListApp({Key? key}) : super(key: key);

  @override
  _TodoListAppState createState() => _TodoListAppState();
}

class _TodoListAppState extends State<TodoListApp> {
  Shader lg = const LinearGradient(
    colors: <Color>[
      Color(0xff0027FF),
      Color(0xffFF53BD),
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 120.0, 200.0));
  Shader lgg = const LinearGradient(
    colors: <Color>[
      Color(0xff0027FF),
      Color(0xffFF53BD),
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 250.0, 50.0));
  String todoTitle = "";
  String description = "";
  List todos = List.empty();
  createtodos() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyTodos").doc(todoTitle);

    Map<String, String> todos = {
      "todoTitle": todoTitle,
      "todoDesc": description,
    };
    documentReference.set(todos).whenComplete(() => {});
  }

  deletetodos(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyTodos").doc(item);

    documentReference.delete().whenComplete(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.grey[900],
        backgroundColor: Colors.cyanAccent,
        elevation: 0,
        tooltip: 'New Task',
        child: const Icon(
          Icons.loupe_rounded,
          size: 33,
          color: Colors.black,
        ),
        onPressed: () => {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: const EdgeInsets.all(30),
                  titlePadding: const EdgeInsets.all(30),
                  actionsAlignment: MainAxisAlignment.center,
                  actionsPadding: const EdgeInsets.all(30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27)),
                  title: Row(
                    children: [
                      Text(
                        "Add a new Task",
                        style: TextStyle(
                            fontFamily: 'Mon',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = lgg),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 27,
                      ),
                    ],
                  ),
                  content: SizedBox(
                    height: 200,
                    width: 400,
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            // contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                            prefixIcon: const Icon(
                              Icons.games_outlined,
                              size: 30,
                              color: Colors.purple,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.purple,
                                width: 3.0,
                              ),
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            hintText: 'Main heading !',
                          ),
                          style: const TextStyle(
                            fontFamily: 'Sf',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          onChanged: (String task) {
                            todoTitle = task;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            // contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                            prefixIcon: const Icon(
                              Icons.timeline,
                              size: 30,
                              color: Colors.blue,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            hintText: 'Deadline !',
                          ),
                          style: const TextStyle(
                            fontFamily: 'Mon',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          onChanged: (String value) {
                            description = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          shadowColor: Colors.cyanAccent,
                          padding: const EdgeInsets.only(
                            left: 50,
                            right: 50,
                            top: 10,
                            bottom: 10,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          primary: Colors.cyan,
                          elevation: 15,
                          textStyle: const TextStyle(
                            fontFamily: 'Sf',
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          )),
                      onPressed: () {
                        setState(() {
                          createtodos();
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("Add"),
                    )
                  ],
                );
              })
        },
      ),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => {},
          child: const Icon(
            Icons.code,
            size: 30,
            color: Colors.white,
          ),
        ),
        leadingWidth: 90,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [
          Icon(Icons.share_rounded),
          SizedBox(
            width: 25,
          )
        ],
        title: const Text(
          'My To Do List',
          style: TextStyle(
            fontFamily: 'Sf',
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: Colors.grey[700],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                width: 400,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: const DecorationImage(
                        image: AssetImage('assets/one.jpg'),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(.0),
                        Colors.black.withOpacity(.0),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Widget>[
                      Text(
                        "Let's be productive",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Mon'),
                      ),
                      SizedBox(
                        height: 115,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 110),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Center(
                child: Text(
                  "List of Tasks",
                  style: TextStyle(
                      foreground: Paint()..shader = lgg,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sf',
                      fontSize: 19),
                ),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("MyTodos")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          QueryDocumentSnapshot<Object?>? documentSnapshot =
                              snapshot.data?.docs[index];
                          return Card(
                            shadowColor: Colors.white,
                            color: Colors.white,
                            margin: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(0.1),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(
                                  10,
                                ),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      (documentSnapshot != null)
                                          ? (documentSnapshot["todoTitle"])
                                          : "",
                                      style: TextStyle(
                                        fontFamily: 'Pop',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        foreground: Paint()..shader = lg,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    Text(
                                      (documentSnapshot != null)
                                          ? ((documentSnapshot["todoDesc"] !=
                                                  null)
                                              ? documentSnapshot["todoDesc"]
                                              : "")
                                          : "",
                                      style: const TextStyle(
                                        fontFamily: 'Mon',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.timer,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 30,
                                  ),
                                  color: Colors.red,
                                  onPressed: () {
                                    setState(() {
                                      //todos.removeAt(index);
                                      deletetodos((documentSnapshot != null)
                                          ? (documentSnapshot["todoTitle"])
                                          : "");
                                    });
                                  },
                                ),
                              ),
                            ),
                          );
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
