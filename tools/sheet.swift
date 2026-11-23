import Foundation
import PDFKit
import AppKit
let doc = PDFDocument(url: URL(fileURLWithPath: CommandLine.arguments[1]))!
let cols = 6, tw = 400, th = 566
let n = doc.pageCount, rows = (n+cols-1)/cols
let W = cols*tw, H = rows*(th+30)
let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: W, pixelsHigh: H, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
NSGraphicsContext.saveGraphicsState()
let ctx = NSGraphicsContext(bitmapImageRep: rep)!; NSGraphicsContext.current = ctx
let cg = ctx.cgContext
cg.setFillColor(NSColor.white.cgColor); cg.fill(CGRect(x:0,y:0,width:W,height:H))
for i in 0..<n {
  let page = doc.page(at:i)!
  let img = page.thumbnail(of: CGSize(width: tw-10, height: th-10), for: .mediaBox)
  let c = i % cols, r = i / cols
  let x = c*tw+5, y = H - (r+1)*(th+30) + 5
  img.draw(in: CGRect(x: x, y: y, width: tw-10, height: th-10))
  ("p\(i+1)" as NSString).draw(at: CGPoint(x: x+5, y: y+th-5), withAttributes: [.font: NSFont.boldSystemFont(ofSize: 22), .foregroundColor: NSColor.red])
}
NSGraphicsContext.restoreGraphicsState()
try! rep.representation(using: .jpeg, properties: [.compressionFactor: 0.8])!.write(to: URL(fileURLWithPath: CommandLine.arguments[2]))
