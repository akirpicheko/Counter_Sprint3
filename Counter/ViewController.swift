//
//  ViewController.swift
//  Counter
//
//  Created by Nastya on 19.08.2024.
//

import UIKit
import Foundation

//Возврат значения лога
enum LoggingAction: String {
    case increase = ": значение изменено на +1"
    case decrease = ": значение изменено на -1"
    case reset = ": значение сброшено"
    case nagativeValue = ": попытка уменьшить значение счётчика ниже 0"
}

class ViewController: UIViewController {
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var historyLog: UITextView!
    
    //Значение счётчика
    private var currentValue: Int = 0
    //Массив куда вписывается журнал действий
    private var historyArray: [String] = []
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        historyLog.text = "История изменений: \nПусто"
    }
    
    //Отдаёт текущую дату и время
    private func currentTime() -> String {
        let time = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "[dd-MM-yyyy HH:mm:ss]"
        let currentTime = dateFormatter.string(from: time)
        return currentTime
    }

    //Добавляем историю в журнал
    private func updateHistory (update: String) {
        historyArray.append(update)
    }

    //Обновить значение счётчика
    private func updateLabelText() {
        currentValueLabel.text = "Значение счётчика: " + String(currentValue)
    }
    
    //Обновить журнал действий
    private func updateTextView(updating: String) -> Void {
        let log: String = currentTime() + updating
        updateHistory(update: log)
        var textForHistory: String = ""
        for item in historyArray.reversed() {
            textForHistory = textForHistory + "\n" + item
        }
        historyLog.text = "История изменений:\n" + textForHistory
    }
    
    //Увеличить значение счётчика
    @IBAction func increaseValue(_ sender: Any) {
        currentValue += 1
        updateLabelText()
        updateTextView(updating: "\(LoggingAction.increase.rawValue)")
    }
    
    //Уменьшить значение счётчика
    @IBAction func decreaseValue(_ sender: Any) {
        // Проверка на отрицательное значение
        if currentValue > 0 {
            currentValue -= 1
            updateLabelText()
            updateTextView(updating: "\(LoggingAction.decrease.rawValue)")
        } else {
            updateTextView(updating: "\(LoggingAction.nagativeValue.rawValue)")
        }
    }
    
    // Сбросить значение счётчика
    @IBAction func resetValue(_ sender: Any) {
        currentValue = 0
        updateLabelText()
        updateTextView(updating: "\(LoggingAction.reset.rawValue)")
    }
    
}
