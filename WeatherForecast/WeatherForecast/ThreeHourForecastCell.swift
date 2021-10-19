//
//  threeHourForecastCell.swift
//  WeatherForecast
//
//  Created by 이윤주 on 2021/10/15.
//

import UIKit

class ThreeHourForecastCell: UITableViewCell {
    static let cellIdentifier = "\(self)"
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .trailing
        stackView.spacing = 5
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
        configureStackView()
        backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ThreeHourForecastCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dateLabel.text = nil
        temperatureLabel.text = nil
        weatherImageView.image = nil
    }
    
    func setUp(with forecastInfo: List) {
        guard let iconName = forecastInfo.weather[0].icon else {
            return
        }
        let date = formatDate(of: forecastInfo.date)
        let temperature = forecastInfo.main.temp.convertToCelsius().description
        let iconURL = "https://openweathermap.org/img/w/\(iconName).png"
        guard let url = URL(string: iconURL) else {
            return
        }
        
        dateLabel.text = date
        temperatureLabel.text = temperature + "°"
        weatherImageView.loadImage(from: url)
    }
    
    private func configureContents() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: dateLabel.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor)
        ])
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureStackView() {
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(weatherImageView)
        
        weatherImageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    private func formatDate(of date: Int) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "MM/dd(E) HH시"
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let formattedDate = formatter.string(from: date)
        
        return formattedDate
    }
}
