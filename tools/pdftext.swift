import Foundation
import PDFKit
let doc = PDFDocument(url: URL(fileURLWithPath: CommandLine.arguments[1]))!
for i in 0..<doc.pageCount { let t = (doc.page(at:i)?.string ?? "").replacingOccurrences(of: "\n", with: " | "); let b = doc.page(at:i)!.bounds(for:.mediaBox); print("=== PAGE \(i+1) \(Int(b.width))x\(Int(b.height)): \(t.prefix(700))") }
