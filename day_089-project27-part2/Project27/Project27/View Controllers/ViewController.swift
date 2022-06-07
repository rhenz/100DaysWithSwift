//
//  ViewController.swift
//  Project27
//
//  Created by John Salvador on 6/6/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    
    var currentDrawType = 0
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawRectangle()
    }
    
    // MARK: - Helper Methods
    
    private func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let circle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: circle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = img
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawImagesAndText() {
        // 1
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            // 2
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            // 3
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            // 4
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            // 5
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            // 5
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }
        
        // 6
        imageView.image = img
    }
    
    // Challenge #1
    func drawEmojis() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { context in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 200),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "🤣🤩"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
        }
        
        imageView.image = img
    }
    
    // Challenge #2
    func drawTwinWordByLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { context in
            
            let letterSpacing = 10
            
            // T
            let tWidth = 80
            context.cgContext.move(to: CGPoint(x: 50, y: 50))
            context.cgContext.addLine(to: CGPoint(x: 50, y: 100))
            context.cgContext.move(to: CGPoint(x: 20, y: 50))
            context.cgContext.addLine(to: CGPoint(x: 80, y: 50))
            
            // W
            let wWidth = tWidth+letterSpacing+80
            context.cgContext.move(to: CGPoint(x: tWidth + letterSpacing, y: 50))
            context.cgContext.addLine(to: CGPoint(x: tWidth+letterSpacing+20, y: 100))
            context.cgContext.addLine(to: CGPoint(x: tWidth+letterSpacing+40, y: 50))
            context.cgContext.addLine(to: CGPoint(x: tWidth+letterSpacing+60, y: 100))
            context.cgContext.addLine(to: CGPoint(x: tWidth+letterSpacing+80, y: 50))
            
            // I
            let iWidth = wWidth+letterSpacing+1
            context.cgContext.move(to: CGPoint(x: wWidth+letterSpacing, y: 50))
            context.cgContext.addLine(to: CGPoint(x: wWidth+letterSpacing, y: 100))
            
            
            // N
            context.cgContext.move(to: CGPoint(x: iWidth+letterSpacing, y: 100))
            context.cgContext.addLine(to: CGPoint(x: iWidth+letterSpacing, y: 50))
            context.cgContext.addLine(to: CGPoint(x: iWidth+letterSpacing+50, y: 100))
            context.cgContext.addLine(to: CGPoint(x: iWidth+letterSpacing+50, y: 50))
            
            context.cgContext.setStrokeColor(UIColor.red.cgColor)
            context.cgContext.strokePath()
        }
        
        imageView.image = img
    }
}

// MARK: - Actions

extension ViewController {
    @IBAction private func redraw(_ sender: UIButton) {
        currentDrawType += 1
        
        if currentDrawType > 7 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0: drawRectangle()
        case 1: drawCircle()
        case 2: drawCheckerboard()
        case 3: drawRotatedSquares()
        case 4: drawLines()
        case 5: drawImagesAndText()
        case 6: drawEmojis()
        case 7: drawTwinWordByLines()
        default: break
        }
    }
}

