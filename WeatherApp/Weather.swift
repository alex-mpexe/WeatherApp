import Foundation
import Alamofire

// Model for "weather" key in openweathermap API
class Weather: Decodable {
    var description: String?
    var icon: String?
    
    enum CodingKeys: String, CodingKey {
        case description
        case icon
    }
}

// Model for "main" key in openweathermap API
class MainData: Decodable {
    var temp: Double?
    var humidity: Int?
    var pressure: Int?
    enum CodingKeys: String, CodingKey {
        case temp
        case humidity
        case pressure
    }
}

// Model for current day weather
class Current: Decodable {
    var weather: [Weather]?
    var main: MainData?
    var visibility: Int?
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case visibility
    }
}

// Model for temp data
class Temperature: Decodable {
    var day: Double?
    enum CodingKeys: String, CodingKey {
        case day
    }
}

// Model for daily data
class Daily: Decodable {
    var date: Double?
    var temp: Temperature
    var weather: [Weather]?
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temp
        case weather
    }
    
}

// Model for weekly forecast
class Weekly: Decodable {
    var daily: [Daily]?
    enum CodingKeys: String, CodingKey {
        case daily
    }
    
}
