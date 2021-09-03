import 'package:flutter/material.dart';
import 'package:supabase_app/supabasehandler.dart';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({
    @required this.title,
  });
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SupaBaseHandler supaBaseHandler = SupaBaseHandler();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String newValue;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData == null &&
              snapshot.connectionState == ConnectionState.none) {}

          return ListView.builder(
            itemCount: indice(snapshot.data.length),
            itemBuilder: (context, index) {
              return Container(
                height: 150,
                color:
                    snapshot.data[index]['status'] ? Colors.white : Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      child: Center(child: Text(snapshot.data[index]['task'])),
                    ),
                    IconButton(
                        icon: Icon(Icons.done),
                        onPressed: () {
                          supaBaseHandler.updateData(
                              snapshot.data[index]['id'], true);
                          setState(() {});
                        }),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        supaBaseHandler.delete(snapshot.data[index]['id']);
                        setState(() {});
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
        future: supaBaseHandler.readData(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: TextField(
                onChanged: (value) {
                  newValue = value;
                },
              )),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    supaBaseHandler.addData(newValue, false);
                  });
                },
                child: Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {});
                },
                child: Icon(Icons.refresh),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int indice(int tamanno) {
    if (tamanno == null) {
      return 0;
    }
    return tamanno;
  }
}
