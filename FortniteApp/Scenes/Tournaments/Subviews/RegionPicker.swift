//
//  RegionPicker.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import UIKit

class RegionPicker: UIView {
    
    private let regions: [Region] = Region.allCases
    var onRegionSelected: ((Region) -> ())?
    
    private let textField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.textColor = .systemBlue
        textField.tintColor = .clear
        
        let image = UIImage(systemName: "chevron.up.chevron.down")
        image?.withTintColor(.systemBlue)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemBlue
        textField.rightView = imageView
        textField.rightViewMode = .always
        
        return textField
    }()
    private let pickerView = UIPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setInitialValue()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setInitialValue()
    }
    
    
    private func setupView() {
        
        addSubview(textField)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        textField.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        toolBar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolBar
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setInitialValue() {
        textField.text = Region.NAC.rawValue
        if let initialIndex = regions.firstIndex(of: Region.NAC) {
            pickerView.selectRow(initialIndex, inComponent: 0, animated: false)
        }
    }
    
    @objc private func doneTapped() {
        endEditing(true)
        guard let selectedRegion = getSelectedRegion() else {return}
        onRegionSelected?(selectedRegion)
    }
    
    func getSelectedRegion() -> Region? {
        return regions.first { region in
            region.rawValue == textField.text
        }
    }
}

extension RegionPicker: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return regions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return regions[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = regions[row].rawValue
    }
}
