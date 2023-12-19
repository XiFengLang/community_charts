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

/// Simple pie chart with outside labels example.
// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';

// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';

class PieOutsideLabelChart extends StatelessWidget {
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;

  PieOutsideLabelChart(this.seriesList, {this.animate = false});

  /// Creates a [PieChart] with sample data and no transition.
  factory PieOutsideLabelChart.withSampleData() {
    return new PieOutsideLabelChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory PieOutsideLabelChart.withRandomData() {
    return new PieOutsideLabelChart(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<LinearSales, int>> _createRandomData() {
    final random = new Random();

    final data = [
      new LinearSales(0, 1),
      new LinearSales(1, 20),
      new LinearSales(2, 30),
      new LinearSales(3, 66),
      new LinearSales(4, 1),
      new LinearSales(5, 1),
      new LinearSales(6, 1),
      new LinearSales(7, 1),
      new LinearSales(8, 1),
      // new LinearSales(0, random.nextInt(100)),
      // new LinearSales(1, random.nextInt(100)),
      // new LinearSales(2, random.nextInt(100)),
      // new LinearSales(3, random.nextInt(100)),
    ];

    final colors = [
      // 分类基础10色
      Color(0xFF0884F3),
      Color(0xFF36D18F),
      Color(0xFFF7DE5F),
      Color(0xFFF89E50),
      Color(0xFF898E94),
      Color(0xFF7262Fd),
      Color(0xFF78D3F8),
      Color(0xFF9661BC),
      Color(0xFF008685),
      Color(0xFFF08BB4),
      // 分类基础拓展10色
      Color(0xFFB1DAFD),
      Color(0xFFBDEFD9),
      Color(0xFFFBECA2),
      Color(0xFFFFD9B8),
      Color(0xFFC2CBD5),
      Color(0xFFD3CEFD),
      Color(0xFFB6E3F5),
      Color(0xFFD3C6EA),
      Color(0xFFAAD8D8),
      Color(0xFFFFD6E7),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        labelAccessorFn: (LinearSales row, _) {
          return '${row.year}\n${row.sales}';
        },
        // outsideLabelStyleAccessorFn: (LinearSales row, index) {
        //   return charts.TextStyleSpec(
        //     color: charts.Color.fromHex(code: "#141414"),
        //     fontSize: 12,
        //   );
        // },
        colorFn: (LinearSales datum, int? index) {
          return charts.ColorUtil.fromDartColor(colors[index!]);
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart<num>(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.ArcRendererConfig(
        // 镂空效果
        arcWidth: 40,
        // 分割线的宽度
        strokeWidthPx: 1,
        arcRendererDecorators: [
          new charts.ArcLabelDecorator(
            labelPosition: charts.ArcLabelPosition.outside,
            showLeaderLines: true,
            // labelPadding: 10,
            outsideLabelStyleSpec: charts.TextStyleSpec(
              color: charts.Color.fromHex(code: "#141414"),
              fontSize: 12,
            ),
            leaderLineStyleSpec: charts.ArcLabelLeaderLineStyleSpec(
              length: 10,
              // 线条宽度
              thickness: 1,
              color: charts.ColorUtil.fromDartColor(Colors.red),
            ),
            // leaderLineColor: charts.ColorUtil.fromDartColor(Colors.red),
          ),
        ],
      ),
      behaviors: [
        new charts.DatumLegend(
          position: charts.BehaviorPosition.bottom,
          outsideJustification: charts.OutsideJustification.middle,
        )
      ],
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
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

// extension ChartsColor on charts.Color {
//   static charts.Color fromDartColor(Color color) {
//     return charts.Color(
//       r: color.red,
//       g: color.green,
//       b: color.blue,
//       a: color.alpha,
//     );
//   }
// }
