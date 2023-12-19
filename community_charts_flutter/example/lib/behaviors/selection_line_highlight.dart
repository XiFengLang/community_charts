// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';

// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';

// class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
//   final size;
//
//   CustomCircleSymbolRenderer({this.size});
//
//   @override
//   void paint(
//     charts.ChartCanvas canvas,
//     Rectangle<num> bounds, {
//     List<int>? dashPattern,
//     charts.Color? fillColor,
//     charts.FillPatternType? fillPattern,
//     charts.Color? strokeColor,
//     double? strokeWidthPx,
//   }) {
//     super.paint(
//       canvas,
//       bounds,
//       dashPattern: dashPattern,
//       fillColor: fillColor,
//       strokeColor: strokeColor,
//       strokeWidthPx: strokeWidthPx,
//     );
//
//     List tooltips = selectedDatum;
//     print("datum: $tooltips");
//     //_LineChartWidgetState.selectedDatum;
//     String unit = "% "; // _LineChartWidgetState.unit;
//     if (tooltips != null && tooltips.length > 0) {
//       num tipTextLen = (tooltips[0]['text'] + unit).length;
//       num chosen = (tooltips[1]['text'] != null)
//           ? (((tooltips[0]['text'] + unit).length >
//                   (tooltips[1]['text'] + unit).length)
//               ? (tooltips[0]['text'] + unit).length
//               : (tooltips[1]['text'] + unit).length)
//           : (tooltips[0]['text'] + unit).length;
//
//       tipTextLen = chosen;
//
//       num rectWidth = bounds.width + tipTextLen * 8.3;
//       // num rectHeight = bounds.height + 20 + (tooltips.length - 1) * 18;
//       num rectHeight = bounds.height + 14 + (tooltips.length - 1) * 18;
//       num left = bounds.left > (size?.width ?? 300) / 2
//           ? (bounds.left > size?.width / 4
//               ? bounds.left - rectWidth
//               : bounds.left - rectWidth / 2)
//           : bounds.left - 40;
//
//       canvas.drawRect(Rectangle(left, 0, rectWidth, rectHeight),
//           fill: charts.Color.fromHex(code: '#666666')
//           // fill: Color.transparent
//           );
//       // canvas.drawRect(
//       //     Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10,
//       //         bounds.height + 10),
//       //     fill: Color.transparent);
//
//       for (int i = 0; i < tooltips.length; i++) {
//         canvas.drawPoint(
//           point: Point(left.round() + 8, (i + 1) * 15),
//           radius: 3,
//           fill: tooltips[i]['color'],
//           stroke: charts.Color.white,
//           strokeWidthPx: 1,
//         );
//         ChartStyle.TextStyle textStyle = ChartStyle.TextStyle();
//         textStyle.color = charts.Color.white;
//         // textStyle.color = charts.Color.black;
//         textStyle.fontSize = 13;
//         canvas.drawText(
//             ChartText.TextElement(tooltips[i]['text'] + unit, style: textStyle),
//             left.round() + 15,
//             i * 15 + 8);
//       }
//     }
//   }
// }

class SelectionLineHighlight extends StatelessWidget {
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;

  SelectionLineHighlight(this.seriesList, {this.animate = false});

  /// Creates a [LineChart] with sample data and no transition.
  factory SelectionLineHighlight.withSampleData() {
    return new SelectionLineHighlight(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory SelectionLineHighlight.withRandomData() {
    return new SelectionLineHighlight(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<LinearSales, num>> _createRandomData() {
    final random = new Random();

    final data = [
      new LinearSales(0, random.nextInt(100)),
      new LinearSales(1, random.nextInt(100)),
      new LinearSales(2, random.nextInt(100)),
      new LinearSales(3, random.nextInt(100)),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    // This is just a simple line chart with a behavior that highlights the
    // selected points along the lines. A point will be drawn at the selected
    // datum's x,y coordinate, and a vertical follow line will be drawn through
    // it.
    //
    // A [Charts.LinePointHighlighter] behavior is added manually to enable the
    // highlighting effect.
    //
    // As an alternative, [defaultInteractions] can be set to true to include
    // the default chart interactions, including a LinePointHighlighter.
    return new charts.LineChart(seriesList, animate: animate, behaviors: [
      // Optional - Configures a [LinePointHighlighter] behavior with a
      // vertical follow line. A vertical follow line is included by
      // default, but is shown here as an example configuration.
      //
      // By default, the line has default dash pattern of [1,3]. This can be
      // set by providing a [dashPattern] or it can be turned off by passing in
      // an empty list. An empty list is necessary because passing in a null
      // value will be treated the same as not passing in a value at all.
      new charts.LinePointHighlighter(
        showHorizontalFollowLine:
            charts.LinePointHighlighterFollowLineType.nearest,
        showVerticalFollowLine:
            charts.LinePointHighlighterFollowLineType.nearest,
      ),
      // Optional - By default, select nearest is configured to trigger
      // with tap so that a user can have pan/zoom behavior and line point
      // highlighter. Changing the trigger to tap and drag allows the
      // highlighter to follow the dragging gesture but it is not
      // recommended to be used when pan/zoom behavior is enabled.
      new charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag)
    ]);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);

  @override
  String toString() {
    return 'LinearSales{year: $year, sales: $sales}';
  }
}
