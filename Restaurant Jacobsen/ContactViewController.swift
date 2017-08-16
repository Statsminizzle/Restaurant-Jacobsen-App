//
//  ContactViewController.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 14/08/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit
import MessageUI


class ContactViewController: UIViewController {

    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var sendEmailButton: UIButton!
    
    // TODO: Real number eventually
    var number = "12345678"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sendEmailButton.addTarget(self, action: #selector(sendEmail(sender:)), for: .touchUpInside)
        callButton.addTarget(self, action: #selector(callPhone(sender:)), for: .touchUpInside)
    }
    
    func callPhone(sender: UIButton) {
        let url = URL(string: "telprompt://\(number)")
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.openURL(url!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

// MARK: - MailComposeViewController
extension ContactViewController: MFMailComposeViewControllerDelegate {
    
    func sendEmail(sender: UIButton) {
        let mailComposeViewController = initialiseMailComposeViewController()
        presentMailComposeViewController(mailComposeViewController: mailComposeViewController)
    }
    
    func initialiseMailComposeViewController() -> MFMailComposeViewController {
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.setToRecipients(["test"])
        mailComposeViewController.setSubject("")
        mailComposeViewController.setMessageBody("", isHTML: false)

        return mailComposeViewController
    }
    
    func presentMailComposeViewController(mailComposeViewController: MFMailComposeViewController) {
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            let error = UIAlertController.init(title: "Fejl", message: "Der er sket en fejl. Check dine email-indstillinger og prøv igen", preferredStyle: .alert)
            error.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
            self.present(error, animated: true, completion: nil)
        }
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if result == .failed {
            self.dismiss(animated: true, completion: {
            let error = UIAlertController.init(title: "Fejl", message: "Din mail blev ikke sendt. Check dine email-indstillinger og prøv igen", preferredStyle: .alert)
            error.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
