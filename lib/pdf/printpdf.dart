import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:js' as js;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:wage_management/constants.dart';
import 'package:wage_management/pdf/pdfhelper.dart';

Future<void> createPDF() async {
  //Create a new PDF document
  PdfDocument document = PdfDocument();

  //Add a new page and draw text
  final PdfPage page = document.pages.add();

  final Size pageSize = page.getClientSize();

  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
      pen: PdfPen(PdfColor(142, 170, 219)));

  //  final PdfLayoutResult result = _drawHeader(page, pageSize, grid);

  final PdfGrid grid = getGrid();

  _drawGrid(
    page,
    grid,
  );

  // //Save the document
  // List<int> bytes = await document.save();

  // js.context['pdfData'] = base64.encode(bytes);
  // js.context['filename'] = 'Output.pdf';
  // Timer.run(() {
  //   js.context.callMethod('download');
  // });

  final List<int> bytes = await document.save();

  await FileSaveHelper.saveAndLaunchFile(bytes, 'Attendece.pdf');
}

//Draws the grid
void _drawGrid(
  PdfPage page,
  PdfGrid grid,
) {
  //  Rect? totalPriceCellBounds;
  //  Rect? quantityCellBounds;
  // // Invoke the beginCellLayout event.
  // grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
  //   final PdfGrid grid = sender as PdfGrid;
  //   if (args.cellIndex == grid.columns.count - 1) {
  //     totalPriceCellBounds = args.bounds;
  //   } else if (args.cellIndex == grid.columns.count - 2) {
  //     quantityCellBounds = args.bounds;
  //   }
  // };

  grid.beginCellLayout = (sender, args) {
    args.cellIndex == grid.columns.count - 1;
  };
  //Draw the PDF grid and get the result.
  grid.draw(page: page, bounds: Rect.fromLTWH(0, 40, 0, 0))!;
  //Draw grand total.
  // page.graphics.drawString('Grand Total',
  //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
  //     bounds: Rect.fromLTWH(
  //         quantityCellBounds!.left,
  //         result.bounds.bottom + 10,
  //         quantityCellBounds!.width,
  //         quantityCellBounds!.height));
  // page.graphics.drawString(_getTotalAmount(grid).toString(),
  //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
  //     bounds: Rect.fromLTWH(
  //         totalPriceCellBounds!.left,
  //         result.bounds.bottom + 10,
  //         totalPriceCellBounds!.width,
  //         totalPriceCellBounds!.height));
}

//  double _getTotalAmount(PdfGrid grid) {
//   double total = 0;
//   for (int i = 0; i < grid.rows.count; i++) {
//     final String value =
//         grid.rows[i].cells[grid.columns.count - 1].value as String;
//     total += double.parse(value);
//   }
//   return total;
// }

//Create PDF grid and return
PdfGrid getGrid() {
  final PdfGrid grid = PdfGrid();

  grid.columns.add(count: 6);

  final PdfGridRow headerRow = grid.headers.add(1)[0];

  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = 'Date';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = 'Day';
  headerRow.cells[2].value = 'Project';
  headerRow.cells[3].value = 'Time in';
  headerRow.cells[4].value = 'Time out';
  headerRow.cells[5].value = 'OT';


   for (var element in attendenceController.at) {
      for (var i = 0; i < element.allAttendents.length; i++) {
        addAttendenceToPdf(
          element.allAttendents[i].date,
          element.allAttendents[i].date,
          element.allAttendents[i].project,
          element.allAttendents[i].timeIn,
          element.allAttendents[i].timeOut,
          element.allAttendents[i].overTime.toString(),
          grid,
        );
      }
    }

  
  grid.columns[0].width = 60;
  grid.columns[1].width = 60;
  grid.columns[2].width = 100;

  for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[i].style.cellPadding =
        PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  }

  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      final PdfGridCell cell = row.cells[j];
      if (j == 0) {
        cell.stringFormat.alignment = PdfTextAlignment.center;
      }
      cell.style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
  }
  return grid;
}

void addAttendenceToPdf(String date, String day, String project, String timeIn,
    String timeOut, String overTime, PdfGrid grid) {
  final PdfGridRow row = grid.rows.add();
  row.cells[0].value = date;
  row.cells[1].value = day;
  row.cells[2].value = project;
  row.cells[3].value = timeIn;
  row.cells[4].value = timeOut;
  row.cells[5].value = overTime;
}
