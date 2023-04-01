
import Foundation

struct WeatherData: Codable {
    let name : String
    let main : Main
    let weather : [Weather]
//    let wind : Wind
}

struct Main : Codable {
    let temp : Double
}
//
//struct Wind : Codable {
//    let speed : Int
//}

struct Weather : Codable {
    let description : String
    let id : Int
}

