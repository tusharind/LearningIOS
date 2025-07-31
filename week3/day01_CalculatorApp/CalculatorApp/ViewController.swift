import UIKit

class ViewController: UIViewController {
    // MARK: - UI Elements

    @IBOutlet var buttonsContainerView: UIView!

    private var displayLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 40, weight: .light)
        return label
    }()

    // MARK: - properties

    private var inputExpression: String = ""
    private var isNewInputStarted = false

    // MARK: - lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupNumberPad()
    }

    // MARK: - setup

    private func setupNumberPad() {
        let keyButtonSize: CGFloat = view.frame.size.width / 4
        let containerHeight = buttonsContainerView.frame.size.height

        setupDigitButtons(buttonSize: keyButtonSize, containerHeight: containerHeight)
        setupOperatorButtons(buttonSize: keyButtonSize, containerHeight: containerHeight)
        setupFunctionButtons(buttonSize: keyButtonSize, containerHeight: containerHeight)

        displayLabel.frame = CGRect(x: 20,
                                    y: containerHeight - (keyButtonSize * 5) - 100.0,
                                    width: view.frame.size.width - 40,
                                    height: 100)

        buttonsContainerView.addSubview(displayLabel)
    }

    private func setupDigitButtons(buttonSize: CGFloat, containerHeight: CGFloat) {
        let zeroButton = createButton(title: "0", backgroundColor: .white, titleColor: .black)
        zeroButton.frame = CGRect(x: 0,
                                  y: containerHeight - buttonSize,
                                  width: buttonSize * 2,
                                  height: buttonSize)
        zeroButton.tag = 0
        zeroButton.addTarget(self, action: #selector(digitButtonPressed(_:)), for: .touchUpInside)
        buttonsContainerView.addSubview(zeroButton)

        let dotButton = createButton(title: ".", backgroundColor: .white, titleColor: .black)
        dotButton.frame = CGRect(x: buttonSize * 2,
                                 y: containerHeight - buttonSize,
                                 width: buttonSize,
                                 height: buttonSize)
        dotButton.addTarget(self, action: #selector(digitButtonPressed(_:)), for: .touchUpInside)
        buttonsContainerView.addSubview(dotButton)

        let numbers = Array(1 ... 9).reversed()
        for (index, number) in numbers.enumerated() {
            let row = index / 3
            let col = index % 3
            let button = createButton(title: "\(number)", backgroundColor: .white, titleColor: .black)
            button.frame = CGRect(x: buttonSize * CGFloat(col),
                                  y: containerHeight - (buttonSize * CGFloat(row + 2)),
                                  width: buttonSize,
                                  height: buttonSize)
            button.tag = number
            button.addTarget(self, action: #selector(digitButtonPressed(_:)), for: .touchUpInside)
            buttonsContainerView.addSubview(button)
        }
    }

    private func setupOperatorButtons(buttonSize: CGFloat, containerHeight: CGFloat) {
        let operators = ["=", "+", "-", "×", "÷"]
        for (i, op) in operators.enumerated() {
            let opButton = createButton(title: op, backgroundColor: .orange, titleColor: .black)
            opButton.frame = CGRect(x: buttonSize * 3,
                                    y: containerHeight - (buttonSize * CGFloat(i + 1)),
                                    width: buttonSize,
                                    height: buttonSize)
            opButton.tag = 100 + i
            opButton.addTarget(self, action: #selector(operatorButtonPressed(_:)), for: .touchUpInside)
            buttonsContainerView.addSubview(opButton)
        }
    }

    private func setupFunctionButtons(buttonSize: CGFloat, containerHeight: CGFloat) {
        let clearButton = createButton(title: "C", backgroundColor: .lightGray, titleColor: .black)
        clearButton.frame = CGRect(x: 0,
                                   y: containerHeight - (buttonSize * 5),
                                   width: buttonSize,
                                   height: buttonSize)
        clearButton.layer.masksToBounds = true
        clearButton.addTarget(self, action: #selector(clearDisplay), for: .touchUpInside)
        buttonsContainerView.addSubview(clearButton)

        let leftParenButton = createButton(title: "(", backgroundColor: .lightGray, titleColor: .black)
        leftParenButton.frame = CGRect(x: buttonSize,
                                       y: containerHeight - (buttonSize * 5),
                                       width: buttonSize,
                                       height: buttonSize)
        leftParenButton.layer.masksToBounds = true
        leftParenButton.addTarget(self, action: #selector(parenthesisButtonTapped(_:)), for: .touchUpInside)
        buttonsContainerView.addSubview(leftParenButton)

        let rightParenButton = createButton(title: ")", backgroundColor: .lightGray, titleColor: .black)
        rightParenButton.frame = CGRect(x: buttonSize * 2,
                                        y: containerHeight - (buttonSize * 5),
                                        width: buttonSize,
                                        height: buttonSize)
        rightParenButton.layer.masksToBounds = true
        rightParenButton.addTarget(self, action: #selector(parenthesisButtonTapped(_:)), for: .touchUpInside)
        buttonsContainerView.addSubview(rightParenButton)
    }

    private func createButton(title: String, backgroundColor: UIColor, titleColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        return button
    }

    // MARK: - actions

    @objc func clearDisplay() {
        displayLabel.text = "0"
        inputExpression = ""
        isNewInputStarted = false
    }

    @objc func digitButtonPressed(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }

        if displayLabel.text == "0" || isNewInputStarted {
            displayLabel.text = (title == ".") ? "0." : title
            inputExpression = displayLabel.text ?? ""
            isNewInputStarted = false
        } else {
            if title == ".", displayLabel.text!.contains(".") {
                return
            }
            displayLabel.text?.append(title)
            inputExpression.append(title)
        }
    }

    @objc func operatorButtonPressed(_ sender: UIButton) {
        guard let symbol = sender.currentTitle else { return }

        if symbol == "=" {
            if !isParenthesesBalanced(inputExpression) {
                displayLabel.text = "Error"
                inputExpression = ""
                isNewInputStarted = true
                return
            }

            var exp = inputExpression.replacingOccurrences(of: "×", with: "*")
                .replacingOccurrences(of: "÷", with: "/")
            exp = formatExpressionForEvaluation(exp)
            let expr = NSExpression(format: exp)

            if let result = expr.expressionValue(with: nil, context: nil) as? NSNumber {
                displayLabel.text = "\(result.doubleValue.clean)"
                inputExpression = "\(result.doubleValue.clean)"
            } else {
                displayLabel.text = "Error"
                inputExpression = ""
            }
            isNewInputStarted = true
        } else {
            if let lastChar = inputExpression.last,
               "+-×÷".contains(lastChar),
               "+-×÷".contains(symbol)
            {
                inputExpression.removeLast()
                inputExpression.append(symbol)
                if var text = displayLabel.text, !text.isEmpty {
                    text.removeLast()
                    text.append(symbol)
                    displayLabel.text = text
                }
            } else {
                displayLabel.text?.append(symbol)
                inputExpression.append(symbol)
            }
        }
    }

    @objc func parenthesisButtonTapped(_ sender: UIButton) {
        guard let symbol = sender.currentTitle else { return }

        if displayLabel.text == "0" || isNewInputStarted {
            displayLabel.text = symbol
            inputExpression = symbol
            isNewInputStarted = false
        } else {
            displayLabel.text?.append(symbol)
            inputExpression.append(symbol)
        }
    }

    // MARK: - utilities

    func formatExpressionForEvaluation(_ expression: String) -> String {
        var formattedExpression = ""
        var currentNumber = ""

        func flushCurrentNumber() {
            if !currentNumber.isEmpty {
                if currentNumber.contains(".") {
                    formattedExpression += currentNumber
                } else {
                    formattedExpression += currentNumber + ".0"
                }
                currentNumber = ""
            }
        }

        for char in expression {
            if char.isNumber || char == "." {
                currentNumber.append(char)
            } else {
                flushCurrentNumber()
                formattedExpression.append(char)
            }
        }
        flushCurrentNumber()
        return formattedExpression
    }

    private func isParenthesesBalanced(_ expr: String) -> Bool {
        var count = 0
        for char in expr {
            if char == "(" {
                count += 1
            } else if char == ")" {
                count -= 1
                if count < 0 { return false }
            }
        }
        return count == 0
    }
}

// MARK: - extension

extension Double {
    var clean: String {
        return truncatingRemainder(dividingBy: 1) == 0 ?
            String(format: "%.0f", self) : String(self)
    }
}
