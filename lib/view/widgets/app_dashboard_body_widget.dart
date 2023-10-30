import 'package:flutter/material.dart';

import 'app_dasboard_tab_bar_buttons.dart';

class AppDashBoardBodyWidget extends StatefulWidget {
  const AppDashBoardBodyWidget({
    super.key,
  });

  @override
  State<AppDashBoardBodyWidget> createState() => _AppDashBoardBodyWidgetState();
}

class _AppDashBoardBodyWidgetState extends State<AppDashBoardBodyWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            AppDashboardTabbarButtons(tabController: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    child: Text('1'),
                  ),
                  Container(
                    child: Text('2'),
                  ),
                  Container(
                    child: Text('3'),
                  ),
                  Container(
                    child: Text('4'),
                  ),
                  Container(
                    child: Text('5'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
