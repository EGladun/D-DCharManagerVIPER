//
//  CharacterAddController.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 29.05.2021.
//

import UIKit

class CharacterAddController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var nameField: UITextField?
    @IBOutlet weak var racePicker: UIPickerView?
    @IBOutlet weak var classPicker: UIPickerView?
    //
    @IBOutlet weak var strValue: UILabel?
    @IBOutlet weak var aglValue: UILabel?
    @IBOutlet weak var wsdValue: UILabel?
    @IBOutlet weak var luckValue: UILabel?
    //
    @IBOutlet weak var strMinus: UIButton?
    @IBOutlet weak var strPlus: UIButton?
    @IBOutlet weak var aglMinus: UIButton?
    @IBOutlet weak var aglPlus: UIButton?
    @IBOutlet weak var wsdMinus: UIButton?
    @IBOutlet weak var wsdPlus: UIButton?
    @IBOutlet weak var luckMinus: UIButton?
    @IBOutlet weak var luckPlus: UIButton?
    
    //MARK: Variables
    private var interactor: CharacterAddInteractor?
    private var presenter: CharacterAddPresenter?
    
    var onBack: (()->Void)?

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupModule()
        setupPickers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.updateStatValues()
    }
    
    //MARK: Methods
    func setupModule() {
        presenter = CharacterAddPresenter()
        presenter?.controller = self
        guard presenter != nil else { return }
        interactor = CharacterAddInteractor(presenter: presenter!)
    }
    
    func setupPickers() {
        racePicker?.delegate = self
        racePicker?.dataSource = self
        
        classPicker?.delegate = self
        classPicker?.dataSource = self
    }
    
    func updateViewWith(model: CharacterAddModel) {
        strValue?.text = model.strenght
        aglValue?.text = model.agility
        wsdValue?.text = model.wisdom
        luckValue?.text = model.luck
        
        strPlus?.isHidden = model.strPlus
        strMinus?.isHidden = model.strMinus
        
        aglPlus?.isHidden = model.aglPlus
        aglMinus?.isHidden = model.aglMinus
        
        wsdPlus?.isHidden = model.wsdPlus
        wsdMinus?.isHidden = model.wsdMinus
        
        luckPlus?.isHidden = model.luckPlus
        luckMinus?.isHidden = model.luckMinus
    }
    
    func showAlert(_ alert: UIAlertController) {
        self.present(alert, animated: true, completion: {
            self.nameField?.becomeFirstResponder()
        })
    }
    
    //MARK: Actions
    @IBAction func strMinus(_ sender: Any) {
        interactor?.decrementStat(.strength)
    }
    
    @IBAction func strPlus(_ sender: Any) {
        interactor?.incrementStat(.strength)
    }
    
    @IBAction func aglMinus(_ sender: Any) {
        interactor?.decrementStat(.agility)
    }
    
    @IBAction func aglPlus(_ sender: Any) {
        interactor?.incrementStat(.agility)
    }
    
    @IBAction func wsdMinus(_ sender: Any) {
        interactor?.decrementStat(.wisdom)
    }
    
    @IBAction func wsdPlus(_ sender: Any) {
        interactor?.incrementStat(.wisdom)
    }
    
    @IBAction func luckMinus(_ sender: Any) {
        interactor?.decrementStat(.luck)
    }
    
    @IBAction func luckPlus(_ sender: Any) {
        interactor?.incrementStat(.luck)
    }
    
    @IBAction func backHandler(_ sender: Any) {
        onBack?()
    }
    
    @IBAction func generateHandler(_ sender: Any) {
        interactor?.generateHero(name: nameField?.text)
    }
    
}

//MARK: Extension
extension CharacterAddController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == racePicker {
            return presenter?.raceCount() ?? 0
        }
        if pickerView == classPicker {
            return presenter?.classCount() ?? 0
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == racePicker {
            return presenter?.allRaces[row].string
        }
        if pickerView == classPicker {
            return presenter?.allClasses[row].string
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == racePicker {
            interactor?.selectedRace = presenter?.allRaces[row] ?? .human
        }
        if pickerView == classPicker {
            interactor?.selectedClass = presenter?.allClasses[row] ?? .knight
        }
    }
}

