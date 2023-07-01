import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

import '../../../controller/messagecontroller.dart';
import '../../../model/userdata.dart';

messageView() {
  return Expanded(
    child: SingleChildScrollView(
      reverse: true,
      child: GetX<MessageController>(
          init: MessageController(),
          //initState:MessageController().messgaeget(),
          builder: (controller) => (controller.messagelist.isEmpty)
              ? const Center(
                  child: Text(
                    'Start Conversation',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.messagelist.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: (controller.messagelist[i].name ==
                                UserData.firstUserName)
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(controller.messagelist[i].name),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFF009688),
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 6.0,
                                  bottom: 6.0,
                                  left: 12.0,
                                  right: 12.0),
                              child: Text(controller.messagelist[i].text,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ),
                          ),
                          Text(controller.messagelist[i].time,
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    );
                  })),
    ),
  );
}
