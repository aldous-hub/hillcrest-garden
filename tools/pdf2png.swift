import Foundation
import PDFKit
import AppKit
let args = CommandLine.arguments
let doc = PDFDocument(url: URL(fileURLWithPath: args[1]))!
let outPrefix = args[2]
let dpi = Double(args[3])!
let pages = args.count > 4 ? args[4].split(separator: ",").map{Int($0)!} : Array(1...doc.pageCount)
for p in pages {
  let page = doc.page(at: p-1)!
  let b = page.bounds(for: .mediaBox)
  let s = dpi/72.0
  let w = Int(b.width*s), h = Int(b.height*s)
  let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: w, pixelsHigh: h, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
  NSGraphicsContext.saveGraphicsState()
  let ctx = NSGraphicsContext(bitmapImageRep: rep)!
  NSGraphicsContext.current = ctx
  ctx.cgContext.setFillColor(NSColor.white.cgColor); ctx.cgContext.fill(CGRect(x:0,y:0,width:w,height:h))
  ctx.cgContext.scaleBy(x: s, y: s)
  page.draw(with: .mediaBox, to: ctx.cgContext)
  NSGraphicsContext.restoreGraphicsState()
  try! rep.representation(using: .png, properties: [:])!.write(to: URL(fileURLWithPath: "\(outPrefix)-p\(p).png"))
  print("page \(p): \(b.width)x\(b.height)pt -> \(w)x\(h)")
}
