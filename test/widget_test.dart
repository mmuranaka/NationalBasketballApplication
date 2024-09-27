// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mp5/views/HomePage.dart';
// import 'package:mp5/views/UserDrawer.dart';

// void main() {
//   group('Home Page Testing', () {

// testWidgets('Open drawer and check contents', (tester) async {
//   // Wrap the HomePage widget with MaterialApp
//   await tester.pumpWidget(const MaterialApp(
//     home: HomePage(),
//   ));

//   //click drawer
//   await tester.tap(find.byWidget(HomePage(UserDrawer())));
//   await tester.pumpAndSettle();

//   // Find the ListView widget in the drawer
//   final listViewFinder = find.byType(ListView);

//   // Verify that the ListView is present
//   expect(listViewFinder, findsOneWidget);

//   // Define the expected text items in the ListView
//   final expectedTextItems = ['Home', 'Standings'];
//   final expectedIcons = [Icons.home, Icons.sports_basketball];

//   // Verify that each expected text item is present in the ListView
//   for (final textItem in expectedTextItems) {
//     expect(find.text(textItem), findsOneWidget);
//   }

//   // Verify that each expected icon is present in the ListView
//   for (final icon in expectedIcons) {
//     expect(find.byIcon(icon), findsOneWidget);
//   }
// });

//     // testWidgets('Scroll to bottom of Dropdown', (tester) async {
//     //   await tester.pumpWidget(const HomePage());

//     //   await tester.tap(find.byKey(const Key('dropdownKey')));
//     //   await tester.pumpAndSettle();

//     //   await tester.dragUntilVisible(
//     //     find.text('Washington Wizards'),
//     //     find.byType(ListView),
//     //     const Offset(0, -500)
//     //   );

//     //   expect(find.text('Washington Wizards'), findsOneWidget);
//     // });

//   });
// }