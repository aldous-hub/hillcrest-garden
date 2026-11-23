import Foundation
import AVFoundation
import AppKit
let a = CommandLine.arguments
let asset = AVURLAsset(url: URL(fileURLWithPath: a[1]))
let gen = AVAssetImageGenerator(asset: asset); gen.appliesPreferredTrackTransform = true
gen.requestedTimeToleranceBefore = .zero; gen.requestedTimeToleranceAfter = .zero
gen.maximumSize = CGSize(width: 1280, height: 1280)
var t = Double(a[3])!; let end = Double(a[4])!, step = Double(a[5])!
while t <= end { let img = try! gen.copyCGImage(at: CMTime(seconds: t, preferredTimescale: 600), actualTime: nil)
  try! NSBitmapImageRep(cgImage: img).representation(using: .jpeg, properties: [.compressionFactor: 0.75])!.write(to: URL(fileURLWithPath: String(format: "%@/g%05.1f.jpg", a[2], t)))
  t += step }
