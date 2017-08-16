//
//  ReservationViewController.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 09/08/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController {
    
    @IBOutlet weak var selectPersonsTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var selectTimeTextField: UITextField!
    @IBOutlet weak var acceptButton: UIButton!
    
    var numberOfPersonsSelected: Int?
    var numberOfPersonsTextSelected: String?
    
    var hoursSelected: String?
    var minutesSelected: String?
    
    var personPicker: UIPickerView?
    var timePicker: UIPickerView?
    
    var hours: [String] = ["11","12","13","14","15","16","17","18","19","20","21","22"]
    var minutes: [String] = ["00","15", "30", "45"]
    
    var reservation: Reservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ReservationViewController.removePicker))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        // MARK: personPicker
        personPicker = UIPickerView()
        personPicker!.delegate = self
        personPicker!.dataSource = self
        selectPersonsTextField.inputView = personPicker
        selectPersonsTextField.inputAccessoryView = toolbar
        personPicker!.selectRow(1, inComponent: 0, animated: false)
        pickerView(personPicker!, didSelectRow: 1, inComponent: 0)
        
        
        // MARK: timePicker
        timePicker = UIPickerView()
        timePicker!.delegate = self
        timePicker!.dataSource = self
        
        // TODO: add logic to set this to after current time
        timePicker!.selectRow(0, inComponent: 0, animated: false)
        timePicker!.selectRow(0, inComponent: 1, animated: false)
        pickerView(timePicker!, didSelectRow: 0, inComponent: 0)
        
        selectTimeTextField.inputView = timePicker
        selectTimeTextField.inputAccessoryView = toolbar
        
        // MARK: datePicker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbar
        datePickerValueChanged(sender: datePicker)
        
        // MARK: acceptButtton
        acceptButton.addTarget(self, action: #selector(acceptReservation), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    func removePicker(){
        view.endEditing(true)
    }
    
    func acceptReservation() {
        reservation = Reservation(numberOfPersons: numberOfPersonsTextSelected!, date: dateTextField.text!, time: selectTimeTextField.text!, contact: nil)
        
        self.performSegue(withIdentifier: "ReservationDetail", sender: self)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReservationDetail" {
            let reservationDetailViewController = segue.destination as! ReservationDetailViewController
            reservationDetailViewController.reservation = reservation!
        }
    }
    

}

// MARK: - UIPickerViewSource & Delegate
extension ReservationViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == personPicker {
            return 1
        }
        
        if pickerView == timePicker {
            return 2
        }
        
        assert(false, "Only expecting two different pickerViews")
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == personPicker {
            return 20
        }
        
        if pickerView == timePicker {
            if component == 0 {
                return hours.count
            }
            
            if component == 1 {
                return minutes.count
            }
            
            return 1
        }
        
        assert(false, "Only expecting two different pickerViews")
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == personPicker {
            return rowToPersonSelectedText(row: row)
        }
        
        if pickerView == timePicker {
            return component == 0 ? hours[row] : minutes[row]
        }
        
        assert(false, "Only expecting two different pickerViews")
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == personPicker {
            numberOfPersonsSelected = row+1
            numberOfPersonsTextSelected = rowToPersonSelectedText(row: row)
            selectPersonsTextField.text = numberOfPersonsTextSelected
        }
        
        if pickerView == timePicker {
            if component == 0 {
                hoursSelected = hours[row]
                if minutesSelected == nil {
                    let index = pickerView.selectedRow(inComponent: 1)
                    minutesSelected = minutes[index]
                }
            } else if component == 1 {
                minutesSelected = minutes[row]
                if hoursSelected == nil {
                    let index = pickerView.selectedRow(inComponent: 0)
                    hoursSelected = hours[index]
                }
            }
            
            selectTimeTextField.text = "kl. " + hoursSelected! + ":" + minutesSelected!
        }
    }
    
    func rowToPersonSelectedText(row: Int) -> String {
        if row == 0 {
            return "\(row+1) person"
        }
        
        return "\(row+1) personer"
    }
    
    
}
