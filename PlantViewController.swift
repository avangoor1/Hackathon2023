//
//  PlantViewController.swift
//  PlantWatering
//
//  Created by Ananya Vangoor on 3/31/23.
//

import UIKit

class PlantViewController: UIViewController {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var WateringDay: UILabel!
    @IBOutlet weak var Precipitation: UITextField!
    //    @IBOutlet weak var Precipitation: UILabel!
//    @IBOutlet weak var plant_image: UIImageView!
    var text = "Precipitation"
    var wateringDay = "Monday"
    var condition = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        Precipitation.text = "The precipitation chance is \(text)"
        WateringDay.text = "Next watering day is \(wateringDay)"
        switch condition {
        case 200...232:
            weatherImage.image = UIImage(systemName: "cloud.bolt")
            break
        case 300...321:
            weatherImage.image = UIImage(systemName: "cloud.drizzle")
            break
        case 500...531:
            weatherImage.image = UIImage(systemName: "cloud.rain")
            break
        case 600...622:
            weatherImage.image = UIImage(systemName: "cloud.snow")
            break
        case 701...781:
            weatherImage.image = UIImage(systemName: "cloud.fog")
            break
        case 800:
            weatherImage.image = UIImage(systemName: "sun.max")
            break
        default:
            weatherImage.image = UIImage(systemName: "cloud")
            break
        }
        
    }

}
