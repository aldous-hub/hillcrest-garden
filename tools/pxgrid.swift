import Foundation
import AppKit
// pxgrid in out step x0 y0 x1 y1 : crop region (pixels) and draw labelled pixel grid every step px
let a = CommandLine.arguments
let rep0 = NSImage(contentsOfFile: a[1])!.representations[0] as! NSBitmapImageRep
let step = Double(a[3])!, x0 = Double(a[4])!, y0 = Double(a[5])!, x1 = Double(a[6])!, y1 = Double(a[7])!
let W = Int(x1-x0), H = Int(y1-y0)
let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: W, pixelsHigh: H, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
NSGraphicsContext.saveGraphicsState(); let ctx = NSGraphicsContext(bitmapImageRep: rep)!; NSGraphicsContext.current = ctx; let cg = ctx.cgContext
let ih = Double(rep0.pixelsHigh)
cg.draw(rep0.cgImage!, in: CGRect(x: -x0, y: Double(H) - (ih - y0), width: Double(rep0.pixelsWide), height: ih))
var v = ceil(x0/step)*step
while v <= x1 { let x = v-x0; let major = Int(v) % Int(step*5) == 0; cg.setStrokeColor(NSColor(red:1,green:0,blue:0,alpha: major ? 0.6 : 0.25).cgColor); cg.setLineWidth(major ? 2 : 1); cg.move(to: CGPoint(x:x,y:0)); cg.addLine(to: CGPoint(x:x,y:Double(H))); cg.strokePath(); if major { ("\(Int(v))" as NSString).draw(at: CGPoint(x:x+2,y:Double(H)-22), withAttributes:[.font:NSFont.boldSystemFont(ofSize:18),.foregroundColor:NSColor.red]) }; v += step }
v = ceil(y0/step)*step
while v <= y1 { let y = Double(H)-(v-y0); let major = Int(v) % Int(step*5) == 0; cg.setStrokeColor(NSColor(red:1,green:0,blue:0,alpha: major ? 0.6 : 0.25).cgColor); cg.setLineWidth(major ? 2 : 1); cg.move(to: CGPoint(x:0,y:y)); cg.addLine(to: CGPoint(x:Double(W),y:y)); cg.strokePath(); if major { ("\(Int(v))" as NSString).draw(at: CGPoint(x:3,y:y+2), withAttributes:[.font:NSFont.boldSystemFont(ofSize:18),.foregroundColor:NSColor.red]) }; v += step }
NSGraphicsContext.restoreGraphicsState()
try! rep.representation(using: .jpeg, properties: [.compressionFactor: 0.82])!.write(to: URL(fileURLWithPath: a[2]))
