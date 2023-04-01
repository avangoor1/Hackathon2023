//
//  ViewController.swift
//  PlantWatering
//
//  Created by Ananya Vangoor on 3/31/23.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var addTree: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var lastWateringDayPicker: UIPickerView!
    @IBOutlet weak var lastWateringDay: UILabel!
    @IBOutlet weak var SelectedPlant: UILabel!
    @IBOutlet weak var PlantPicket: UIPickerView!
    var weatherManager = WeatherManager()
    let plants = ["Cactus", "Apple Tree", "Roses"]
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var temperature = "Hello"
    var conditionID = 0
    var updateDay = 0
    var updatePlant = 0
    //var image = UIImage(named: "hello.png")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lastWateringDayPicker.delegate = self
        lastWateringDayPicker.dataSource = self
        PlantPicket.delegate = self
        PlantPicket.dataSource = self
        searchTextField.delegate = self
        weatherManager.delegate = self
        lastWateringDayPicker.tag = 1 //day
        PlantPicket.tag = 2 //plant
    }
    
//    @IBAction func continueSegway(_ sender: Any) {
//        self.performSegue(withIdentifier: "goToSecond", sender: self)
//    }
    
    
    @IBAction func continueSegway(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSecond", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "goToSecond" {
            let destinationVC = segue.destination as! PlantViewController
            destinationVC.text = temperature
            print("update Day is \(updateDay)")
            print("update Plant Day is \(updatePlant)")
            destinationVC.wateringDay = days[(updateDay + updatePlant) % 7]
            destinationVC.condition = conditionID
            updateDay = 0
            updatePlant = 0
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(pickerView.tag){
        case 1:
            return days.count
        case 2:
            return plants.count
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch(pickerView.tag){
        case 1:
            print("row \(row)")
            print(days[row])
            return days[row]
        case 2:
            print("row \(row)")
            print(plants[row])
            return plants[row]
        default:
            return "Data not found"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if((pickerView.tag == 2)){
            switch (row)  {
            case 1:
                SelectedPlant.text = "\(plants[row]) need to be watered every 2 days."
                updatePlant = 2
                break
            case 2:
                // statements
                SelectedPlant.text = "\(plants[row]) need to be watered every 4 days."
                updatePlant = 4
                break
            case 0:
                SelectedPlant.text = "\(plants[row]) need to be watered every 1 days."
                updatePlant = 1
                break
            default:
                // statements
                break
            }
        }
        if((pickerView.tag == 1)){
            updateDay = row
        }
        //SelectedPlant.text = plants[row]
    }
}


extension ViewController : UITextFieldDelegate {
    
    @IBAction func searchButton(_ sender: Any) {
        searchTextField.endEditing(true)
        //print(searchTextField.text)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" { // applies to any textfield
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            //print(city + "is the city")
            weatherManager.fetchWeather(cityName: city)
        }
        //Use searchTextField.text to get the weather for that city
        searchTextField.text = ""
    }
}

extension ViewController : WeatherManagerDelegate {
    func didUpdateWeather(weather : WeatherModel) {
        DispatchQueue.main.async {
            //print(weather.temperatureString)
            self.temperature = weather.temperatureString
            self.conditionID = weather.conditionId
            print("the condition id in view is \(self.conditionID)")
            //self.cityLabel.text = weather.cityName
            //self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
}


