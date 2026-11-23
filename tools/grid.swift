import Foundation
import AppKit
// grid in.png out.jpg pxPerM x0m y0m x1m y1m  (crop region in metres; origin = image top-left)
let a = CommandLine.arguments
let src = NSImage(contentsOfFile: a[1])!
let rep0 = src.representations[0] as! NSBitmapImageRep
let ppm = Double(a[3])!, x0 = Double(a[4])!, y0 = Double(a[5])!, x1 = Double(a[6])!, y1 = Double(a[7])!
let W = Int((x1-x0)*ppm), H = Int((y1-y0)*ppm)
let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: W, pixelsHigh: H, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
NSGraphicsContext.saveGraphicsState()
let ctx = NSGraphicsContext(bitmapImageRep: rep)!; NSGraphicsContext.current = ctx
let cg = ctx.cgContext
let ih = Double(rep0.pixelsHigh)
// draw source so that pixel (x0*ppm, y0*ppm) top-left maps to (0,0) top-left
let cgimg = rep0.cgImage!
cg.draw(cgimg, in: CGRect(x: -x0*ppm, y: Double(H) - (ih - y0*ppm), width: Double(rep0.pixelsWide), height: ih))
func ly(_ ym: Double) -> Double { return Double(H) - (ym - y0)*ppm }
var m = ceil(x0)
while m <= x1 { let x = (m-x0)*ppm; let major = Int(m) % 5 == 0
  cg.setStrokeColor(major ? NSColor(red:1,green:0,blue:0,alpha:0.55).cgColor : NSColor(red:1,green:0.4,blue:0.4,alpha:0.22).cgColor); cg.setLineWidth(major ? 2 : 1)
  cg.move(to: CGPoint(x:x,y:0)); cg.addLine(to: CGPoint(x:x,y:Double(H))); cg.strokePath()
  if major { ("\(Int(m))" as NSString).draw(at: CGPoint(x:x+3,y:Double(H)-28), withAttributes:[.font:NSFont.boldSystemFont(ofSize:22),.foregroundColor:NSColor.red]) }
  m += 1 }
m = ceil(y0)
while m <= y1 { let y = ly(m); let major = Int(m) % 5 == 0
  cg.setStrokeColor(major ? NSColor(red:1,green:0,blue:0,alpha:0.55).cgColor : NSColor(red:1,green:0.4,blue:0.4,alpha:0.22).cgColor); cg.setLineWidth(major ? 2 : 1)
  cg.move(to: CGPoint(x:0,y:y)); cg.addLine(to: CGPoint(x:Double(W),y:y)); cg.strokePath()
  if major { ("\(Int(m))" as NSString).draw(at: CGPoint(x:4,y:y+2), withAttributes:[.font:NSFont.boldSystemFont(ofSize:22),.foregroundColor:NSColor.red]) }
  m += 1 }
NSGraphicsContext.restoreGraphicsState()
try! rep.representation(using: .jpeg, properties: [.compressionFactor: 0.8])!.write(to: URL(fileURLWithPath: a[2]))
print(W,H)
