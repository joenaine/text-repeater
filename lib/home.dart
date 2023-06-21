import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:text_repeater/constants/app_assets.dart';
import 'package:text_repeater/constants/app_colors_const.dart';
import 'package:text_repeater/services/size_config.dart';
import 'package:text_repeater/widgets/app_hide_keyboard_widget.dart';
import 'package:text_repeater/widgets/discolored_button.dart';
import 'package:text_repeater/widgets/textfields.dart';

import 'widgets/toast.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _msgController = TextEditingController();
  final TextEditingController _numController = TextEditingController();
  String? countedMessage;
  late FToast fToast;
  SizeConfig sizeConfig = SizeConfig();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    super.dispose();
    _msgController.dispose();
    _numController.dispose();
  }

  void multiplyMessage() {
    var concatenate = StringBuffer();
    for (var i = 0; i < int.parse(_numController.text); i++) {
      concatenate.write('${i + 1}. ${_msgController.text}\n');
    }
    countedMessage = concatenate.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AppHideKeyBoardWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text Repeater'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          actionsAlignment: MainAxisAlignment.center,
                          alignment: Alignment.center,
                          title: Center(
                              child: Text(
                            'instagram : 2handaulet',
                            style: TextStyle(fontSize: 20),
                          )),
                          actions: [],
                        );
                      });
                },
                icon: const Icon(Icons.info_outline))
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    keyboardType: TextInputType.multiline,
                    controller: _msgController,
                    maxlines: null,
                    hintText: 'Type your message',
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    controller: _numController,
                    hintText: 'Count',
                  ),
                  DiscoloredButton(
                    text: 'Create',
                    onPressed: () {
                      multiplyMessage();
                    },
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.form,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(countedMessage ?? ''),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: countedMessage));

                            fToast.showToast(
                                child: const ToastContainer(text: "Copied"),
                                gravity: ToastGravity.BOTTOM,
                                toastDuration: const Duration(seconds: 2));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(AppAssets.svg.copy,
                                color: AppColors.primary, height: 24),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
