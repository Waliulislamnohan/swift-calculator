import UIKit
import SwiftUI
class CalculatorViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!

    var currentNumber: Double = 0
    var previousNumber: Double = 0
    var selectedOperator = ""
    var isPerformingCalculation = false

    @IBAction func digitButtonTapped(_ sender: UIButton) {
        guard let digit = sender.titleLabel?.text else { return }
        if isPerformingCalculation {
            resultLabel.text = digit
            isPerformingCalculation = false
        } else {
            resultLabel.text = (resultLabel.text ?? "") + digit
        }
    }

    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        if let operatorSymbol = sender.titleLabel?.text {
            if isPerformingCalculation {
                selectedOperator = operatorSymbol
            } else {
                if currentNumber != 0 {
                    performCalculation()
                }
                selectedOperator = operatorSymbol
                previousNumber = currentNumber
                isPerformingCalculation = true
            }
        }
    }

    @IBAction func equalsButtonTapped(_ sender: UIButton) {
        performCalculation()
        isPerformingCalculation = true
    }

    @IBAction func clearButtonTapped(_ sender: UIButton) {
        resultLabel.text = "0"
        currentNumber = 0
        previousNumber = 0
        selectedOperator = ""
        isPerformingCalculation = false
    }

    func performCalculation() {
        if let operatorFunction = operatorFunctions[selectedOperator] {
            if let currentText = resultLabel.text, let currentValue = Double(currentText) {
                currentNumber = operatorFunction(previousNumber, currentValue)
                resultLabel.text = String(currentNumber)
            }
        }
    }

    let operatorFunctions: [String: (Double, Double) -> Double] = [
        "+": { $0 + $1 },
        "-": { $0 - $1 },
        "×": { $0 * $1 },
        "÷": { $0 / $1 }
    ]
}
