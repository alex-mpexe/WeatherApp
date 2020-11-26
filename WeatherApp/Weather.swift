import Foundation
import Alamofire

// Model for "weather" key in openweathermap API
class Weather: Decodable {
    var description: String?
    var icon: String?
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case icon = "icon"
    }
}

// Model for "main" key in openweathermap API
class MainData: Decodable {
    var temp: Double?
    var humidity: Int?
    var pressure: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case humidity = "humidity"
        case pressure = "pressure"
    }
}

// Model for current day weather
class Current: Decodable {
    var weather: [Weather]?
    var main: MainData?
    var visibility: Int?
    
    enum CodingKeys: String, CodingKey {
        case weather = "weather"
        case main = "main"
        case visibility = "visibility"
    }
}
