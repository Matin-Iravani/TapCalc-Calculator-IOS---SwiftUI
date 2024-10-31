//
//  MainModel.swift
//  Calculator
//
//  Created by Matin Iravani on 2024-10-29.
//

import Foundation
import SwiftUI
import AVFoundation

class MainModel: ObservableObject {
    
    // MARK: Variables
    
    /// Variables to hold the calculator expression and result
    @Published var runningExpression = ""
    @Published var result = "0"
    @Published var currentOperation: DialPad = .unknown
    @Published var runningNumber = ""
    
    /// Variables to hold soundID for different button circumstance sounds
    private let typingSoundID: SystemSoundID = 1306
    private let tockSoundID: SystemSoundID = 1155
    private let softTockSoundID: SystemSoundID = 1322
    
    /// Constants for testing user input on the calculator
    let operations = "+-x/"
    let maximumDigits = 14
    let invalidResults: Set<String> = ["nan", "inf", "-inf"]
    let generatorError_Success = UINotificationFeedbackGenerator()
    let generator1 = UIImpactFeedbackGenerator(style: .heavy)
    let generator2 = UIImpactFeedbackGenerator(style: .heavy)
    
    
    // MARK: Functions
    
    private func playTypingSound() {
        /// Plays a soft typing sound
        
        AudioServicesPlaySystemSound(typingSoundID)
    }
    
    
    private func playTockSound() {
        /// Plays a soft Tock sound
        
        AudioServicesPlaySystemSound(tockSoundID)
    }
    
    
    private func playSoftTockSound() {
        /// Plays a funny equal sound for plus/minus operation and equal operation when valid
        
        AudioServicesPlaySystemSound(softTockSoundID)
    }
    
    
    func clear() {
        /// Clears the current running expression, number, and result to zero. Used for AC and other instances.
        
        self.runningExpression = ""
        self.runningNumber = ""
        self.result = "0"
        self.currentOperation = .unknown
    }
    
    
    func removeTrailingZeros(from number: String) -> String {
        /// Removes trailing zeros and unnecessary decimal points from a numeric string.
        
        // Use regular expression to remove trailing zeros and possibly the decimal point if there are no decimals left
        let trimmedNumber = number.replacingOccurrences(of: "\\.?0+$", with: "", options: .regularExpression)
        return trimmedNumber
    }
    
    
    func validateExpression(_ expression: String) -> Bool {
        /// Validates a calculator expression to ensure it is correctly formatted for evaluation.
        /// - Parameter expression: The string representing a mathematical expression.
        /// - Returns: A Boolean indicating whether the expression is valid.
        
        // Pattern allows numbers (integer or decimal) with optional leading minus signs, operators, and whitespace
        let pattern = "^(\\s*-{0,}?(\\d*\\.\\d+|\\d+)\\s*([+\\-*/]\\s*-{0,}?(\\d*\\.\\d+|\\d+)\\s*)*)$"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: expression.utf16.count)
        
        // Check if the entire expression matches the pattern
        return regex.firstMatch(in: expression, options: [], range: range) != nil
    }
    
    
    func evaluateExpression() {
        /// Evaluates the current mathematical expression stored in `runningExpression` and updates the `result`.
        
        // Replace "x" with "*" for multiplication and ensure integers are treated as floating-point for division
        var formattedExpression = self.runningExpression
            .replacingOccurrences(of: "x", with: "*")
        
        // Enforce floating-point by appending ".0" to standalone integers
        formattedExpression = formattedExpression.replacingOccurrences(
            of: "(?<![0-9.])([0-9]+)(?![0-9.])",
            with: "$1.0",
            options: .regularExpression
        )

        // Validate the formatted expression; clear and show error if invalid
        let isValid = validateExpression(formattedExpression)
        
        // Return a result of error if wrong set of input was entered. For instance "5+/5.5.5-.0"
        guard isValid else {
            self.clear()
            self.result = "Error"
            print("Invalid expression format.")
            return
        }
        
        // Attempt to create and evaluate the expression
        let expression = NSExpression(format: formattedExpression)
        
        if let computedValue = expression.expressionValue(with: nil, context: nil) as? Double {
            
            // Format the result, remove trailing zeros, and update properties
            var resultString = String(format: "%.3f", computedValue)
            resultString = removeTrailingZeros(from: resultString)
            self.result = resultString
            self.runningExpression = self.result
            self.runningNumber = self.result
            
        } else {
            self.clear()
            print("Evaluation resulted in nil.")
        }
    }

    
    func calculateExpression() {
        /// Function that validates and calculates the current expression, triggering feedback on errors or success.
        
        // Returns if the runningExpression is empty
        guard !(self.runningExpression.isEmpty) else {
            playTockSound()
            generatorError_Success.notificationOccurred(.error)
            return
        }
        
        // Returns if the last entered input in the running expression is an operator or decimal point
        guard !((operations+".").contains(self.runningExpression.suffix(1))) else {
            playTockSound()
            generatorError_Success.notificationOccurred(.error)
            return
        }
        
        // Trigger success feedback and evaluate the expression
        playSoftTockSound()
        generatorError_Success.notificationOccurred(.success)
        evaluateExpression()
    }
    
    
    func appendDecimalOperation(operation: DialPad) {
        /// Appends a decimal operator to the current number in `runningExpression` if one isn't already present.
        
        /// Return if the current number already contains a decimal using `runningNumber` as a check value
        guard !(self.runningNumber.contains(operation.rawValue)) else { playTockSound(); generatorError_Success.notificationOccurred(.error); return }
        
        // Append decimal to `runningExpression` and `runningNumber`, update operation, and trigger feedback (typing sound)
        self.runningExpression += operation.rawValue
        self.runningNumber += operation.rawValue
        self.currentOperation = .unknown
        playTypingSound()
        generator2.impactOccurred()
    }
    
    
    func appendOperation(operation: DialPad) {
        /// Appends an arithmetic operator to `runningExpression` with appropriate checks and updates.
        
        // Check if there's already a known operation (except subtraction), replacing last operator if needed
        if (currentOperation != .unknown) && (self.currentOperation != DialPad.subtract) {
            
            /// Play typing sound impact
            playTypingSound()
            generator2.impactOccurred()
            
            // Replace last operator in expression if present
            if operations.contains(self.runningExpression.suffix(1)) {
                
                // Check if runningNumber is not empty than empty it since an operator is added
                if !(self.runningNumber.isEmpty) {
                    self.runningNumber = ""
                }
                
                // Remove last operator and add new one instead
                self.runningExpression.removeLast()
                self.runningExpression += operation.rawValue
                self.currentOperation = operation
                return
            }
        
        // If no prior operation and expression is non-empty, add the operation
        } else if (currentOperation == .unknown) && (!self.runningExpression.isEmpty) && (self.currentOperation != DialPad.subtract) {
            
            /// Play typing sound impact
            playTypingSound()
            generator2.impactOccurred()
            
            // Append zero if the current number ends with a decimal to ensure correct expression
            if self.runningNumber.suffix(1) == DialPad.decimal.rawValue {
                self.runningExpression += DialPad.zero.rawValue
            }
            
            // Check if runningNumber is not empty than empty it since an operator is added
            if !(self.runningNumber.isEmpty) {
                self.runningNumber = ""
            }
            
            self.runningExpression += operation.rawValue
            self.currentOperation = operation
        
        // Trigger error feedback if conditions aren't met to add an operator
        } else {
            playTockSound()
            generatorError_Success.notificationOccurred(.error)
        }
    }
    
    
    func removeLastEntry() {
        /// Removes the last entry (number or operator) from `runningExpression` and updates relevant properties.
        
        // Return if `runningExpression` is empty
        guard !self.runningExpression.isEmpty else { return }
        
        // Regex pattern to match the last number or operator in the expression
        let pattern = "(-+)?[0-9]*\\.?[0-9]+$|([+\\-x/()]$)"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        
        // Find and remove the last matched sequence
        if let match = regex.firstMatch(in: self.runningExpression, options: [], range: NSRange(location: 0, length: self.runningExpression.utf16.count)) {
            let matchRange = Range(match.range, in: self.runningExpression)!                    /// Get the range of the match
            self.runningExpression = String(self.runningExpression[..<matchRange.lowerBound])   /// Remove the last matched sequence
        }
        
        // Check the new ending sequence after update
        if !self.runningExpression.isEmpty {
            // Match the updated end of `runningExpression`
            if let nextMatch = regex.firstMatch(in: self.runningExpression, options: [], range: NSRange(location: 0, length: self.runningExpression.utf16.count)) {
                let nextMatchRange = Range(nextMatch.range, in: self.runningExpression)!
                let nextExpression = String(self.runningExpression[nextMatchRange])
                
                // Update `currentOperation` based on the type of next expression
                if nextExpression.range(of: "-?[0-9]+\\.?[0-9]*", options: .regularExpression) != nil {
                    print("Next expression is a number: \(nextExpression)")
                    self.currentOperation = .unknown
                    self.runningNumber = nextExpression
                    
                } else if nextExpression.range(of: "[+\\-x/()]", options: .regularExpression) != nil {
                    print("Next expression is an operator: \(nextExpression)")
                    switch nextExpression {
                    case "+":
                        self.currentOperation = .add
                    case "/":
                        self.currentOperation = .devide
                    case "x":
                        self.currentOperation = .multiply
                    default:
                        self.currentOperation = .unknown
                    }
                    
                } else {
                    print("Next expression is neither an operator nor a number.\(nextExpression)")
                }
                
            } else {
                print("No valid next expression found.")
            }
            
        } else {
            print("No next expression: running expression is empty.")
        }
    }


    func doNextOperation(button: DialPad) {
        /// Handles the next operation based on the button pressed, updating `runningExpression` and `runningNumber` as needed. (Main Logic)
        
        switch button {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            // Add digit if within the maximum digit limit
            guard self.runningExpression.count <= maximumDigits else {
                playTockSound()
                generatorError_Success.notificationOccurred(.error)
                return
            }
            
            playTypingSound()
            generator2.impactOccurred()
            
            self.runningExpression += button.rawValue
            self.runningNumber += button.rawValue
            self.currentOperation = .unknown
        
            
        case .devide, .multiply, .add:
            // Append operator if within digit limit
            guard self.runningExpression.count <= maximumDigits else {
                playTockSound()
                generatorError_Success.notificationOccurred(.error)
                return
            }
            
            appendOperation(operation: button)
            
            
        case .delete:
            // Handle deletion, appending zero if last character is decimal
            if self.runningNumber.suffix(1) == DialPad.decimal.rawValue {
                self.runningExpression += DialPad.zero.rawValue
            }
            
            if !(self.runningNumber.isEmpty) {
                self.runningNumber = ""
            }
            
            playTockSound()
            generator2.impactOccurred()
            
            removeLastEntry()
            
            
        case .subtract:
            // Append subtraction operator if within digit limit
            guard (self.runningExpression.count <= maximumDigits) else {
                playTockSound()
                generatorError_Success.notificationOccurred(.error)
                return
            }
            
            playTypingSound()
            generator2.impactOccurred()
            
            if self.runningNumber.suffix(1) == DialPad.decimal.rawValue {
                self.runningExpression += DialPad.zero.rawValue
            }
            
            if !(self.runningNumber.isEmpty) {
                self.runningNumber = ""
            }
            
            self.runningExpression += button.rawValue
            self.currentOperation = button
        
            
        case .decimal:
            // Append decimal if within digit limit
            guard (self.runningExpression.count <= maximumDigits) else {
                playTockSound()
                generatorError_Success.notificationOccurred(.error)
                return
            }
            
            appendDecimalOperation(operation: button)
        
            
        case .plusMinus:
            // Toggle sign if expression is valid and results are finite
            guard !(self.runningExpression.isEmpty) && !((operations+".").contains(self.runningExpression.suffix(1))) else {
                playTockSound()
                generatorError_Success.notificationOccurred(.error)
                return
            }
            
            guard !(self.result == "nan") && !(self.result == "inf") && !(self.result == "-inf") else {
                self.clear()
                playSoftTockSound()
                generatorError_Success.notificationOccurred(.success)
                return
            }
            
            calculateExpression()
            
            self.result = String(format: "%.3f" ,Double(self.result)! * -1)
            self.result = removeTrailingZeros(from: self.result)
            self.runningExpression = self.result
            self.runningNumber = self.result
        
            
        case .clear:
            // Clear expression and trigger feedback
            playTockSound()
            generator1.impactOccurred()
            clear()
            
            
        case .equal:
            // Evaluate the expression
            calculateExpression()
            
            
        case .unknown:
            return
        }
    }
}
