//
//  HomeView.swift
//  Task
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import UIKit
import RxSwift
import RxSwiftExt
import RxCocoa

protocol HomeViewDelegate: class {
    func homeView(_ view: HomeView, didSelectUserWith users: [UsersType])
}
class HomeView: UIView {
    
    // MARK:- Properties
    @IBOutlet var orderStatusTextfield: UITextField!
    @IBOutlet weak var customerTYpeTextField: UITextField!
    @IBOutlet weak var listTableView: UITableView!
    private lazy var pickerView: UIPickerView = {
        return UIPickerView()
    }()
    
    private var state: HomeViewState?
    var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()
    private var pickerViewItems = [String]()
    weak var delegate: HomeViewDelegate?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        commoninit()
    }

    func commoninit() {
        styleTextField(txtField: orderStatusTextfield)
        styleTextField(txtField: customerTYpeTextField)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        listTableView.dataSource = self
        listTableView.delegate = self
    }
    
    func styleTextField(txtField: UITextField) {
        txtField.inputView = pickerView
        txtField.addToolBar()
        txtField.delegate = self
    }
    
    
    // MARK: - Render View
    func render(state: HomeViewState) {
        self.state = state
        listTableView.reloadData()
        pickerView.reloadAllComponents()
    }


    // Update Error view
    func renderError(with error: String) {
        //TODO:- Handle error here properly
        /*let label = UILabel()
        label.text = error
        self.addWithInBounds(view: label)*/
    }
}

// TODO: Create separate data souce file and move it to there

extension HomeView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if orderStatusTextfield.isEditing {
            orderStatusTextfield.text = pickerViewItems[row]
        }
        if customerTYpeTextField.isEditing {
            customerTYpeTextField.text = pickerViewItems[row]
        }
    }
}

extension HomeView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewItems[row]
    }
}

extension HomeView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let state = self.state else {
            return
        }
        if textField == orderStatusTextfield {
            pickerViewItems = state.status
        } else {
            pickerViewItems = state.customerTYype
        }
        pickerView.reloadAllComponents()
        pickerView.selectRow(0, inComponent: 0, animated: true)
        textField.text = pickerViewItems[0]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        true
    }
}

extension HomeView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state?.appointments.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listcell") as? AppointmentListTableViewCell else {
            return UITableViewCell()
        }
        cell.title = state?.appointments[indexPath.row].name
        cell.updateStyle()
        return cell
    }

}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let users = state?.appointments[indexPath.row].users else {
            return
        }
        delegate?.homeView(self, didSelectUserWith: users)
    }
}
