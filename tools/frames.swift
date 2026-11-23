import Foundation
import AVFoundation
import AppKit
let args = CommandLine.arguments
let asset = AVURLAsset(url: URL(fileURLWithPath: args[1]))
let gen = AVAssetImageGenerator(asset: asset)
gen.appliesPreferredTrackTransform = true
gen.requestedTimeToleranceBefore = .zero; gen.requestedTimeToleranceAfter = .zero
gen.maximumSize = CGSize(width: 1280, height: 1280)
let step = Double(args[3])!
let dur = CMTimeGetSeconds(asset.duration)
var t = 0.0
while t < dur {
  let img = try! gen.copyCGImage(at: CMTime(seconds: t, preferredTimescale: 600), actualTime: nil)
  let rep = NSBitmapImageRep(cgImage: img)
  try! rep.representation(using: .jpeg, properties: [.compressionFactor: 0.7])!.write(to: URL(fileURLWithPath: String(format: "%@/f%03d.jpg", args[2], Int(t))))
  t += step
}
print("done", dur)
