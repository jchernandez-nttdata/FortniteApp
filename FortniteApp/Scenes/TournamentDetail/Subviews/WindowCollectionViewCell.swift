//
//  WindowCollectionViewCell.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 9/09/24.
//

import UIKit

class WindowCollectionViewCell: UICollectionViewCell {
    static let identifier = "WindowCollectionViewCell"
    
    private let sessionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForReuse() {
        sessionLabel.text = ""
        dateLabel.text = ""
        timeLabel.text = ""
        backgroundColor = .lightGray.withAlphaComponent(0.5)
        sessionLabel.textColor = .black
        dateLabel.textColor = .black
        timeLabel.textColor = .black
    }
    
    private func setup() {
        backgroundColor = .lightGray.withAlphaComponent(0.5)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(sessionLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(timeLabel)
        stackView.pin(to: contentView, constant: 5)
    }
    
    func setup(isActive: Bool, session: Int, startDate: Date, endDate: Date) {
        if isActive {
            backgroundColor = .gray
            sessionLabel.textColor = .white
            dateLabel.textColor = .white
            timeLabel.textColor = .white
        }
        
        sessionLabel.text = "Session \(session)"
        dateLabel.text = DateHelper.getFormattedDateString(from: startDate)
        timeLabel.text = "\(DateHelper.getFormattedTimeString(from: startDate)) - \(DateHelper.getFormattedTimeString(from: endDate))"
    }
}
