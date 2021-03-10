//
//  ViewController.swift
//  VKApp
//
//  Created by Ksusha on 12.02.2021.
// 


import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var loginTitleLabel: UILabel!
    @IBOutlet var passwordTitleLabel: UILabel!
    @IBOutlet var vkappTitleLabel: UILabel!
    @IBOutlet var dot1: UIImageView!
    @IBOutlet var dot2: UIImageView!
    @IBOutlet var dot3: UIImageView!
    @IBOutlet var appMainImage: UIImageView!
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    func checkUserData() -> Bool {
        guard let login = loginTextField.text,
            let password = passwordTextField.text else { return false }
        
        if login == "" && password == "" {
            return true
        } else {
            return false
        }
    }
    
   func showLoginError() {
        // Создаем контроллер
        let alter = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // Добавляем кнопку на UIAlertController
        alter.addAction(action)
        // Показываем UIAlertController
        present(alter, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.placeholder = "Введите логин..."
        passwordTextField.placeholder = "Введите пароль..."
        print(#function)
        passwordTextField.isSecureTextEntry = true
        loginButton.layer.cornerRadius = 10//loginButton.bounds.width/10
        
        self.dot1.isHidden = true
        self.dot2.isHidden = true
        self.dot3.isHidden = true
        
        animateAuthButton()
        animateTitleAppearing()
        animateTitlesAppearing()
        animateFieldsAppearing()
        animateMainImage()
        
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
//    func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
//       let dispatchTime = DispatchTime.now() + seconds
//       dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
//   }
//
//    enum DispatchLevel {
//       case main, userInteractive, userInitiated, utility, background
//       var dispatchQueue: DispatchQueue {
//           switch self {
//           case .main:                 return DispatchQueue.main
//           case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
//           case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
//           case .utility:              return DispatchQueue.global(qos: .utility)
//           case .background:           return DispatchQueue.global(qos: .background)
//           }
//       }
//   }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        //print("Login: \(loginTextField.text ?? "")")
        //print("Password: \(passwordTextField.text ?? "")")
        let seconds: Int = 4
        let checkResult = checkUserData()
        if checkResult {
            animateLoadingDots()
            sleep(UInt32(seconds))
//            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//                performSegue(withIdentifier: "MainScreenPresentationSegue", sender: self)
//                print("Time \(CACurrentMediaTime())")
//            }
                performSegue(withIdentifier: "MainScreenPresentationSegue", sender: self)
              //self.perform(#selector(self.performSegue), with: nil, afterDelay: 7.0)
            } else {
            showLoginError()
        }
    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//            // Проверяем данные
//            let checkResult = checkUserData()
//            // Если данные не верны, покажем ошибку
//            if !checkResult {
//                showLoginError()
//            }
//            // Вернем результат
//            return checkResult
//        }
    
    // Когда клавиатура появляется
        @objc func keyboardWasShown(notification: Notification) {
            
            // Получаем размер клавиатуры
            let info = notification.userInfo! as NSDictionary
            let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
            
            // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
        
        //Когда клавиатура исчезает
        @objc func keyboardWillBeHidden(notification: Notification) {
            // Устанавливаем отступ внизу UIScrollView, равный 0
            let contentInsets = UIEdgeInsets.zero
            scrollView.contentInset = contentInsets
        }
    

    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        //view.resignFirstResponder()
        scrollView.endEditing(true)
    }

    func animateTitlesAppearing() {
        let offset = view.bounds.width
        loginTitleLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        passwordTitleLabel.transform = CGAffineTransform(translationX: offset, y: 0)
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       options: .curveEaseOut,
                       animations: {
                           self.loginTitleLabel.transform = .identity
                           self.passwordTitleLabel.transform = .identity
                       },
                       completion: nil)
    }

    
    func animateTitleAppearing() {
        self.vkappTitleLabel.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height/2)
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                           self.vkappTitleLabel.transform = .identity
                       },
                       completion: nil)
    }

    func animateFieldsAppearing() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 1
        fadeInAnimation.beginTime = CACurrentMediaTime() + 1
        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
        
        self.loginTextField.layer.add(fadeInAnimation, forKey: nil)
        self.passwordTextField.layer.add(fadeInAnimation, forKey: nil)
    }

    func animateAuthButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.loginButton.layer.add(animation, forKey: nil)
    }

    func animateMainImage() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.appMainImage.layer.add(animation, forKey: nil)
    }
    
    func animateLoadingDots() {
        self.dot1.isHidden = false
        self.dot2.isHidden = false
        self.dot3.isHidden = false

        let dot1Animation = CABasicAnimation(keyPath: "opacity")
        dot1Animation.fromValue = 1
        dot1Animation.toValue = 0
        dot1Animation.duration = 1
        dot1Animation.beginTime = CACurrentMediaTime() + 1
        dot1Animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        dot1Animation.fillMode = CAMediaTimingFillMode.backwards
            
        self.dot1.layer.add(dot1Animation, forKey: nil)
        
        let dot2Animation = CABasicAnimation(keyPath: "opacity")
        dot2Animation.fromValue = 1
        dot2Animation.toValue = 0
        dot2Animation.duration = 1
        dot2Animation.beginTime = CACurrentMediaTime() + 2
        dot2Animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        dot2Animation.fillMode = CAMediaTimingFillMode.backwards
            
        self.dot2.layer.add(dot2Animation, forKey: nil)
        
        let dot3Animation = CABasicAnimation(keyPath: "opacity")
        dot3Animation.fromValue = 1
        dot3Animation.toValue = 0
        dot3Animation.duration = 1
        dot3Animation.beginTime = CACurrentMediaTime() + 3
        dot3Animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        dot3Animation.fillMode = CAMediaTimingFillMode.backwards
            
        self.dot3.layer.add(dot3Animation, forKey: nil)
    }

}
