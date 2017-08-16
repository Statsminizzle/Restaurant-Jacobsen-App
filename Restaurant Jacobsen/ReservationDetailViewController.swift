//
//  ReservationDetailViewController.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 15/08/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit

class ReservationDetailViewController: UIViewController {

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
    
    
    var reservation: Reservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reservationDetailLabel.text = reservation!.getReservationDetailText()
        confirmReservationButton.addTarget(self, action: #selector(confirmReservation(sender:)), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func confirmReservation(sender: UIButton) {
        let contact = Reservation.Contact(name: nameTextField.text!, email: emailTextField.text!, phone: phoneTextField.text!, comment: commentTextField.text!, birthday: birthdaySwitch.isOn)
        reservation?.contact = contact
        
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
