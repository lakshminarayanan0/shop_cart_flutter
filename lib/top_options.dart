import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  final List options;
  const Options({super.key, required this.options});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 9,
            child: Container(
              // color: Colors.amberAccent,
              padding: EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width * 0.73,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.options.length,
                    itemBuilder: ((context, index) {
                      final option = widget.options[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            option.toString().toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    })),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search Products",
                    hintStyle: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(158, 158, 158, 0.6)),
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
