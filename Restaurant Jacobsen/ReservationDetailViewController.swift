//
//  ReservationDetailViewController.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 15/08/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit
import SwiftValidator

class ReservationDetailViewController: UIViewController, FirebaseDatabaseReference {

    @IBOutlet weak var reservationDetailLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var birthdaySwitch: UISwitch!
    @IBOutlet weak var confirmReservationButton: UIButton!
    
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var phoneErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    let validator = Validator()
    var reservation: Reservation?
    var redColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hiding storyboard labels
        nameErrorLabel.isHidden = true
        phoneErrorLabel.isHidden = true
        emailErrorLabel.isHidden = true
        
        redColor = nameErrorLabel.textColor
        reservationDetailLabel.text = reservation!.getReservationDetailText()
        confirmReservationButton.addTarget(self, action: #selector(validateFields(sender:)), for: .touchUpInside)
        
        setValidatorStyleTransformers(validator: validator)
        setValidatorFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func confirmReservation(sender: UIButton) {
        let contact = Reservation.Contact(name: nameTextField.text!, email: emailTextField.text!, phone: phoneTextField.text!, comment: commentTextField.text!, birthday: birthdaySwitch.isOn)
        reservation?.contact = contact
        saveReservation()
        let confirmation = UIAlertController.init(title: "Success", message: "Din reservation er modtaget", preferredStyle: .alert)
        confirmation.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        self.present(confirmation, animated: true, completion: nil)
    }
    
    func saveReservation() {
        ref.child("reservations").childByAutoId().setValue(reservation!.toDictionary())
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

    // MARK: - Validation
extension ReservationDetailViewController: ValidationDelegate{
    
    func validateFields(sender: UIButton) {
        validator.validate(self)
    }
    
    func setValidatorStyleTransformers(validator: Validator) {
        validator.styleTransformers(success: { (validationRule) -> Void in
            validationRule.errorLabel?.isHidden = true
            
            if let textField = validationRule.field as? UITextField {
                textField.layer.borderColor = UIColor.clear.cgColor
            }
            
        }, error: { (validationError) -> Void in
            validationError.errorLabel?.isHidden = false
            validationError.errorLabel?.text = validationError.errorMessage
            if let textField = validationError.field as? UITextField {
                textField.layer.cornerRadius = 5
                textField.layer.borderColor = self.redColor?.cgColor
                textField.layer.borderWidth = 1.0
            }
            
        })
    }
    
    func setValidatorFields() {
        validator.registerField(nameTextField, errorLabel: nameErrorLabel, rules: [RequiredRule(message: "Dette felt er påkrævet"), FullNameRule(message: "Fornavn og efternavn påkrævet")])
        validator.registerField(phoneTextField, errorLabel: phoneErrorLabel, rules: [RequiredRule(message: "Dette felt er påkrævet"), MinLengthRule(length: 8, message: "Skal være 8 karakterer")])
        validator.registerField(emailTextField, errorLabel: emailErrorLabel, rules: [RequiredRule(message: "Dette felt er påkrævet"), EmailRule(message: "Gyldig email-adresse påkrævet")])
    }
    
    // MARK: ValidationDelegate
    
    func validationSuccessful() {
        confirmReservation(sender: confirmReservationButton)
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        print("validation failed")
    }
    
}
