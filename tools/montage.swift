import Foundation
import AppKit
// usage: montage out.jpg cols cellW cellH dir start count
let a = CommandLine.arguments
let out = a[1], cols = Int(a[2])!, cw = Int(a[3])!, ch = Int(a[4])!
let dir = a[5], start = Int(a[6])!, count = Int(a[7])!
let all = try! FileManager.default.contentsOfDirectory(atPath: dir).filter{$0.hasSuffix(".jpg")}.sorted()
let files = Array(all[start..<min(all.count, start+count)]).map{dir + "/" + $0}
let rows = (files.count+cols-1)/cols
let W = cols*cw, H = rows*ch
let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: W, pixelsHigh: H, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
NSGraphicsContext.saveGraphicsState()
let ctx = NSGraphicsContext(bitmapImageRep: rep)!; NSGraphicsContext.current = ctx
ctx.cgContext.setFillColor(NSColor.black.cgColor); ctx.cgContext.fill(CGRect(x:0,y:0,width:W,height:H))
for (i,f) in files.enumerated() {
  let img = NSImage(contentsOfFile: f)!
  let c = i % cols, r = i / cols
  let sz = img.size; let sc = min(Double(cw-6)/sz.width, Double(ch-6)/sz.height)
  let w = sz.width*sc, h = sz.height*sc
  let x = Double(c*cw) + (Double(cw)-w)/2, y = Double(H - (r+1)*ch) + (Double(ch)-h)/2
  img.draw(in: CGRect(x:x,y:y,width:w,height:h))
  let label = (f as NSString).lastPathComponent.replacingOccurrences(of: ".jpg", with: "")
  let attrs: [NSAttributedString.Key: Any] = [.font: NSFont.boldSystemFont(ofSize: 26), .foregroundColor: NSColor.yellow, .backgroundColor: NSColor.black]
  (label as NSString).draw(at: CGPoint(x: Double(c*cw)+8, y: Double(H-(r+1)*ch)+8), withAttributes: attrs)
}
NSGraphicsContext.restoreGraphicsState()
try! rep.representation(using: .jpeg, properties: [.compressionFactor: 0.75])!.write(to: URL(fileURLWithPath: out))
