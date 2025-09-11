Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blue.shade100,
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: const Text(
                      "Payment status retrieved from server",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: screenHeight / 4,
                  margin: const EdgeInsets.only(top: 100.0),
                  child: Lottie.asset(
                    statusImage,
                    repeat: false,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Center(
                    child: Text(
                      orderStatusText,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Order Id: $orderId",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Status: $orderStatus",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: Text("Return to Home"),
                    style: ElevatedButton.styleFrom(
                      padding:
                      EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                  ),
                ),
              ],
            )