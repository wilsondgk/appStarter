
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
                backgroundColor = colorProvider.mainColor
                commonInit()
            } else {
                backgroundColor = disabledColor
                layer.borderColor = UIColor.lightGray.cgColor
                layer.borderWidth = 0
                tintColor = UIColor.lightGray
            }
        }
    }
    
    private var disabledColor = UIColor.lightGray
    private var type: AppButtonType = .Filled
    private var colorProvider: AppColorsProtocol = AppColorsDefault()
    
    init(withTitle title: String,
         frame: CGRect,
         type: AppButtonType = .Filled,
         andColor colorProvider: AppColorsProtocol = AppColorsDefault()) {
        super.init(frame: frame)
        self.type = type
        self.colorProvider = colorProvider
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
            backgroundColor = colorProvider.mainColor
            tintColor = UIColor.white
            layer.borderWidth = 0
            break
        case .Bordered:
            layer.borderColor = colorProvider.mainColor.cgColor
            layer.borderWidth = 1
            backgroundColor = UIColor.white
            tintColor = colorProvider.mainColor
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
