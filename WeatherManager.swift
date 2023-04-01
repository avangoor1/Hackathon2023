import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather : WeatherModel)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=imperial&appid=26bbb17e406e45e225b277ba082d8aa2"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName : String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        //print(cityName)
        performRequest(urlString: urlString)    }
    
    func fetchWeather(latitude : CLLocationDegrees, longitude : CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString : String) {
        // 1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a url session
            let session = URLSession(configuration: .default)
            //3. a tast
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return // means exit out of application
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weather : weather)
                    }
                }
            }
            //4/ Start the task
            task.resume()
        }
    }
    func parseJSON(weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            //conditionId: id
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            //print(weather)
            return weather
        } catch {
            print(error)
            return nil
        }
        
    }

}
