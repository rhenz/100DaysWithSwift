import UIKit
import PlaygroundSupport

class ViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var sampleView: UIView = {
        let sampleView = UIView(frame: CGRect(x: 50, y: 50, width: 300, height: 300))
        sampleView.backgroundColor = .red
        return sampleView
    }()
    
    // MARK: - View Lifecycle
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(sampleView)
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleView.bounceOut(duration: 5)
    }
}


PlaygroundPage.current.liveView = ViewController()

// Challenge #1
extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

// Challenge #2
extension Int {
    func times(_ completion: () -> Void) {
        for _ in 0..<self {
            completion()
        }
    }
}

5.times {
    print("Hello World!")
}


// Challenge #3
extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let index = self.firstIndex(of: item) {
            remove(at: index)
        }
    }
}

var sampleArray = ["lucas", "chabby", "oli", "oli", "nimbus"]
sampleArray.remove(item: "oli")


