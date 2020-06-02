
import UIKit

class AppButton: UIButton {
    
    enum AppButtonType {
        case Filled
        case Bordered
        case Delete
    }
    
    override var isEnabled: Bool {
        didSet {
            if (isEnabled) {
                backgroundColor = referenceColor
                commonInit()
            } else {
                backgroundColor = disabledColor
                layer.borderColor = Colors.lightGray.cgColor
                layer.borderWidth = 0
                tintColor = Colors.lightGray
            }
        }
    }
    
    var referenceColor = Colors .marineBlue {
        didSet {
            commonInit()
        }
    }
    var disabledColor = Colors.backgroundGray
    var type: AppButtonType = .Filled
    
    init(withTitle title: String, frame: CGRect, andType type: AppButtonType = .Filled) {
        super.init(frame: frame)
        self.type = type
        setTitle(title, for: .normal)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.layer.cornerRadius = self.frame.height / 2
        switch self.type {
        case .Filled:
            backgroundColor = Colors.marineBlue
            tintColor = UIColor.white
            layer.borderWidth = 0
            break
        case .Bordered:
            layer.borderColor = Colors .marineBlue.cgColor
            layer.borderWidth = 1
            backgroundColor = UIColor.white
            tintColor = Colors .marineBlue
            break
        case .Delete:
            layer.borderColor = UIColor.red.cgColor
            layer.borderWidth = 1
            backgroundColor = UIColor.white
            tintColor = UIColor.red
            break
        }
    }
}
