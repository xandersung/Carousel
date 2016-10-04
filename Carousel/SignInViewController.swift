//
//  SignInViewController.swift
//  Carousel
//
//  Created by Sung, Alexander on 9/27/16.
//  Copyright © 2016 Capital One. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textFieldParentView: UIView!
    @IBOutlet weak var buttonParentView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var initialY: CGFloat!
    var offset: CGFloat!
    var textFieldInitialY: CGFloat!
    var buttonsInitialY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        // Set the scroll view content size
        scrollView.contentSize = scrollView.frame.size
        // Set the content insets
        scrollView.contentInset.bottom = 100
        spinner.hidesWhenStopped = true
        
        textFieldInitialY = textFieldParentView.frame.origin.y
        buttonsInitialY = buttonParentView.frame.origin.y
        offset = -80
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            self.textFieldParentView.frame.origin.y = self.textFieldInitialY + self.offset
            self.buttonParentView.frame.origin.y = self.buttonsInitialY - 250
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            self.textFieldParentView.frame.origin.y = self.textFieldInitialY
            self.buttonParentView.frame.origin.y = self.buttonsInitialY
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButtonTapped(_ sender: AnyObject) {
        if ((emailTextField.text?.isEmpty)!) {
            let alertController = UIAlertController(title: "Email Required", message: "Please enter an email address", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in}
            alertController.addAction(OKAction)
            present(alertController, animated: true) {}
        } else if ((passwordTextField.text?.isEmpty)!) {
            let alertController = UIAlertController(title: "Password Required", message: "Please enter your password", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in}
            alertController.addAction(OKAction)
            present(alertController, animated: true) {}
        } else {
            spinner.startAnimating()
            let secondsToDelay = 2.0
            run(after: secondsToDelay) {
                self.spinner.stopAnimating()
                if (self.emailTextField.text == "alexander@gmail.com" && self.passwordTextField.text == "password") {
                    self.performSegue(withIdentifier: "successfulLoginSegue", sender: nil)
                } else {
                    let alertController = UIAlertController(title: "Oops", message: "Your email or password is incorrect", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in}
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true) {}
                }
            }
        }

    }
    
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    @IBAction func backButtonTapped(_ sender: AnyObject) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= -20 {
            view.endEditing(true)
        }
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
