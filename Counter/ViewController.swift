//
//  ViewController.swift
//  Counter
//
//  Created by Nastya on 19.08.2024.
//

import UIKit
import Foundation

//Значение счётчика
var currentValue: Int = 0

//Отдаёт текущую дату и время
func currentTime() -> String{
    var time = Date()
    var dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "[dd-MM-yyyy HH:mm:ss]"
    var currentTime = dateFormatter.string(from: time)
    return currentTime
}

//Возврат значения лога
enum loggingAction: String{
    case increase = ": значение изменено на +1"
    case decrease = ": значение изменено на -1"
    case reset = ": значение сброшено"
    case nagativeValue = ": попытка уменьшить значение счётчика ниже 0"
}

//Массив куда вписывается журнал действий
var historyArray: [String] = []

//Добвляем историю в журнал
func updateHistory (update: String) {
    historyArray.append(update)
}

class ViewController: UIViewController {
    @IBOutlet weak var currentValueLabel: UILabel!
    
    @IBOutlet weak var increaseValueButton: UIButton!
    
    @IBOutlet weak var decreaseValueButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var historyLog: UITextView!
    
    //Обновить значение счётчика
    func updateLabelText(){
        currentValueLabel.text = "Значение счётчика: " + String(currentValue)
    }
    
    //Обновить журнал действий
    func updateTextView(updating: String) -> Void{
        var log: String = currentTime() + updating
        updateHistory(update: log)
        //historyLog.text = historyArray
        var textForHistory: String = " "
        var index = historyArray.count
        while index > 0 {
            textForHistory =  textForHistory + "\n" + historyArray[index - 1]
            index -= 1
        }
        historyLog.text = "История изменений:\n" + textForHistory
    }
    
    //Увеличить значение счётчика
    @IBAction func increaseValue(_ sender: Any) {
        currentValue += 1
        updateLabelText()
        updateTextView(updating: "\(loggingAction.increase.rawValue)")
        
    }
    //Уменьшить значение счётчика
    @IBAction func decreaseValue(_ sender: Any) {
        // Проверка на отрицательное значение
        if currentValue > 0 {
            currentValue -= 1
            updateLabelText()
            updateTextView(updating: "\(loggingAction.decrease.rawValue)")
        } else {
            updateTextView(updating: "\(loggingAction.nagativeValue.rawValue)")
        }
    }
    // Сбросить значение счётчика
    @IBAction func resetValue(_ sender: Any) {
        currentValue = 0
        updateLabelText()
        updateTextView(updating: "\(loggingAction.reset.rawValue)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        historyLog.text = "История изменений: \nПусто"
    }
}

