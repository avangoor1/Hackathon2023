import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature : Double
    
    var temperatureString : String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName : Int {
        
        return conditionId
//        switch conditionId {
//        case 200...232:
//            print("Heavy Rains")
//            return "cloud.bolt"
//        case 300...321:
//            print("Light Drizzle")
//            return "cloud.drizzle"
//        case 500...531:
//            print("Rain")
//            return "cloud.rain"
//        case 600...622:
//            return "cloud.snow"
//        case 701...781:
//            return "cloud.fog"
//        case 800:
//            return "sun.max"
//        case 801...804:
//            return "cloud.bolt"
//        default:
//            return "cloud"
//        }
    }
    
}
