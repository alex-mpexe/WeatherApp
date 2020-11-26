import UIKit

class DailyViewController: UIViewController {
    
    // MARK: UI Outlets
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ForecastLoader.shared.fetchCurrentData { [weak self] data, status, message in
            if status {
                self?.updateViews(data: data!)
            } else { print(message) }
        }
    }
    
    // MARK: Updating view data
    func updateViews(data: Current) {
        let weather = data.weather?.first
        let mainData = data.main
        tempLabel.text = "\(Int(mainData?.temp ?? 0)) \u{2103}"
        if let icon = weather?.icon {
            if let url =  URL(string: "http://openweathermap.org/img/wn/\(icon)@4x.png") { weatherIcon.load(url: url)}
        }
        weatherLabel.text = weather?.description ?? ""
        humidityLabel.text = "\(mainData?.humidity ?? 0) %"
        let pressure = (mainData?.pressure ?? 0) / 133
        pressureLabel.text = "\(pressure) мм. рт. ст."
        visibilityLabel.text = "\(data.visibility ?? 0) м"
        
    }


}

