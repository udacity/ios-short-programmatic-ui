//
//  ViewController.swift
//  Weather
//
//  Created by Jarrod Parkes on 3/13/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

// MARK: - ViewController: UIViewController

class ViewController: UIViewController {
    
    // MARK: Controls UI
    
    var showControls = true
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "sunset"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var controlView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually        
        return stackView
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Madison"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "3:59 PM CST"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center        
        label.textColor = .white
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    // MARK: Weather UI
    
    lazy var weatherStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var conditionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        
        let conditionsImageView = UIImageView(image: #imageLiteral(resourceName: "cloudy"))
        conditionsImageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(conditionsImageView)
        
        let conditionsLabel = UILabel(frame: .zero)
        conditionsLabel.text = "Partly cloudy"
        conditionsLabel.font = UIFont.systemFont(ofSize: 24)
        conditionsLabel.textColor = .white
        stackView.addArrangedSubview(conditionsLabel)
        
        return stackView
    }()
    
    lazy var highLowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        let highTempImageView = UIImageView(image: #imageLiteral(resourceName: "up"))
        highTempImageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(highTempImageView)
        
        let highTempLabel = UILabel(frame: .zero)
        highTempLabel.text = "74°"
        highTempLabel.font = UIFont.systemFont(ofSize: 22)
        highTempLabel.textColor = .white
        highTempLabel.textAlignment = .center
        stackView.addArrangedSubview(highTempLabel)
        
        let lowTempImageView = UIImageView(image: #imageLiteral(resourceName: "down"))
        lowTempImageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(lowTempImageView)
        
        let lowTempLabel = UILabel(frame: .zero)
        lowTempLabel.text = "41°"
        lowTempLabel.font = UIFont.systemFont(ofSize: 22)
        lowTempLabel.textColor = .white
        lowTempLabel.textAlignment = .center
        stackView.addArrangedSubview(lowTempLabel)
        
        return stackView
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 120, weight: -1)
        label.textAlignment = .left
        label.textColor = .white
        label.text = "74°"
        return label
    }()
    
    // MARK: Copyright UI
    
    lazy var copyrightLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        label.textColor = .white
        label.text = "@ by Photographer on Source"
        return label
    }()
    
    // MARK: Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        
        addSubviews()
        setupConstraints()
        addGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: Setup
    
    func addSubviews() {
        backgroundImageView.frame = view.frame
        view.addSubview(backgroundImageView)
        
        controlView.addSubview(menuButton)
        locationStackView.addArrangedSubview(locationLabel)
        locationStackView.addArrangedSubview(timeLabel)
        controlView.addSubview(locationStackView)
        controlView.addSubview(addButton)
        view.addSubview(controlView)
        
        weatherStackView.addArrangedSubview(conditionsStackView)
        weatherStackView.addArrangedSubview(highLowStackView)
        weatherStackView.addArrangedSubview(temperatureLabel)
        view.addSubview(weatherStackView)
        
        view.addSubview(copyrightLabel)
    }
    
    func setupConstraints() {
        
        // NOTE: The autoresizing mask constraints fully specify the view’s size and position; therefore, you cannot add additional constraints to modify this size or position without introducing conflicts [which is why set it to `false`].
        let views: [String: AnyObject] = [
            "controlView": controlView,
            "menuButton": menuButton,
            "locationStackView": locationStackView,
            "addButton": addButton,
            "weatherStackView": weatherStackView,
            "temperatureLabel": temperatureLabel,
            "copyrightLabel": copyrightLabel,
            "topLayoutGuide": topLayoutGuide
        ]
        
        for value in views.values {
            if let view = value as? UIView {
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        
        let visualFormatConstraints = [
            "H:|-[controlView]-|",
            "H:|[menuButton(40)]-[locationStackView]-[addButton(40)]|",
            "V:[topLayoutGuide]-[controlView(40)]",
            "V:|[locationStackView(40)]",
            "V:|[menuButton(40)]",
            "V:|[addButton(40)]",
            "H:|-18-[weatherStackView]",
            "V:[weatherStackView(180)]-12-|",
            "V:[temperatureLabel(110)]|",
            "H:[copyrightLabel]-18-|",
            "V:[copyrightLabel]-18-|"
        ]
        
        // MARK: Add visual constraints
        
        for visualFormatConstraint in visualFormatConstraints {
            let constaints = NSLayoutConstraint.constraints(withVisualFormat: visualFormatConstraint, options: NSLayoutFormatOptions(), metrics: nil, views: views)
            view.addConstraints(constaints)
        }

        // MARK: Add additional constraints
        
        let horizontalWeatherStackView = NSLayoutConstraint(item: weatherStackView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.45, constant: 1)
        view.addConstraint(horizontalWeatherStackView)
    }
    
    func addGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateControls))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func animateControls() {
        showControls = !showControls
        UIView.animate(withDuration: 0.2) {
            self.controlView.frame = self.controlView.frame.applying(CGAffineTransform(translationX: 0, y: self.showControls ? 50 : -50))
            self.weatherStackView.frame = self.weatherStackView.frame.applying(CGAffineTransform(translationX: 0, y: self.showControls ? -180 : 180))
        }
    }
}
