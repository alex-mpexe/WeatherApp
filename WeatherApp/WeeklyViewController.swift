import UIKit

class WeeklyViewController: UIViewController {
    
    // MARK: UI Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var weatherData: [Daily]?
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }
    
    // MARK: Update data method
    func updateData() {
        tableView.isHidden = true
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5)
        activityIndicator.startAnimating()
        ForecastLoader.shared.fetchDailyData { [weak self] data, status, message in
            if status {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                self?.tableView.isHidden = false
                self?.weatherData = data
                self?.tableView.reloadData()
            }
        }
    }

}

// MARK: TableView Extensions
extension WeeklyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ForecastTableViewCell
        if let forecastElement = weatherData?[indexPath.row] {
            let formattedDate = Date(timeIntervalSince1970: forecastElement.date ?? 0).formateDate(with: "dd MMMM yyyy г.")
            let formattedTemp = Int((forecastElement.temp.day ?? 0).rounded())
            cell.dateLabel.text = "\(formattedDate)"
            cell.tempLabel.text = "\(formattedTemp) \u{2103}"
            if let icon = forecastElement.weather?.first?.icon {
                if let url =  URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png") { cell.weatherIcon.load(url: url)}
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

}
