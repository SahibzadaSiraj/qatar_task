import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/app_state_provider/app_state.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    final dataState = Provider.of<DataService>(context, listen: false);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent)
        dataState.getData(nextPage: dataState.page++);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final dataState = Provider.of<DataService>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return dataState.getData(nextPage: 1);
        },
        child: Container(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Response Data",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    child:
                    dataState.dataList.length==0?
                        Center(
                          child: CircularProgressIndicator(),
                        ):
                    ListView.builder(
                        controller: _scrollController,
                        itemCount: dataState.dataList.length,
                        itemBuilder: (context, index) {
                          if (dataState.dataList.length == 0) {
                            return Center(
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Column(
                                  children: [
                                    Text("loding...."),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 25,
                                      height: 25,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          return Card(
                            color: _selectedIndex == index
                                ? Colors.green
                                : Colors.white,
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  if (_selectedIndex == index) {
                                    _selectedIndex = null;
                                  } else {
                                    _selectedIndex = index;
                                  }
                                });
                              },
                              leading: CircleAvatar(
                                child: Text("${index + 1}"),
                              ),
                              title: Text("${dataState.dataList[index].name}"),
                              subtitle: Text(
                                  "${dataState.dataList[index].designation}"),
                              trailing: Text(
                                  "${dataState.dataList[index].classification}"),
                            ),
                          );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
