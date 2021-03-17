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
    @IBOutlet var appleImageView: ApplemageView!
    @IBOutlet var cloudImageView: CloudImageView!
    
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
        animateLoadingDots()
        
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
        animateAppleImage()
        animateCloudImage()
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
        //let seconds: Int = 4
        let checkResult = checkUserData()
        if checkResult {
            //animateLoadingDots()
            //sleep(UInt32(seconds))
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
        dot1Animation.duration = 3
        dot1Animation.repeatCount = .infinity
        dot1Animation.beginTime = CACurrentMediaTime() + 1
        dot1Animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        dot1Animation.fillMode = CAMediaTimingFillMode.backwards
            
        self.dot1.layer.add(dot1Animation, forKey: nil)
        
        let dot2Animation = CABasicAnimation(keyPath: "opacity")
        dot2Animation.fromValue = 1
        dot2Animation.toValue = 0
        dot2Animation.duration = 3
        dot2Animation.repeatCount = .infinity
        dot2Animation.beginTime = CACurrentMediaTime() + 2
        dot2Animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        dot2Animation.fillMode = CAMediaTimingFillMode.backwards
            
        self.dot2.layer.add(dot2Animation, forKey: nil)
        
        let dot3Animation = CABasicAnimation(keyPath: "opacity")
        dot3Animation.fromValue = 1
        dot3Animation.toValue = 0
        dot3Animation.duration = 3
        dot3Animation.repeatCount = .infinity
        dot3Animation.beginTime = CACurrentMediaTime() + 3
        dot3Animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        dot3Animation.fillMode = CAMediaTimingFillMode.backwards
            
        self.dot3.layer.add(dot3Animation, forKey: nil)
    }
    
     func animateAppleImage () {
        let appleLayer = CAShapeLayer()
        appleLayer.path = appleImagePath.cgPath
        appleLayer.lineWidth = 3
        appleLayer.strokeColor = UIColor.black.cgColor
        
        let strokeEndAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1

        let strokeStartAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
        strokeStartAnimation.fromValue = -0.1
        strokeStartAnimation.toValue = 0.9

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [strokeEndAnimation, strokeStartAnimation]
        animationGroup.repeatCount = .infinity
        animationGroup.duration = 2
        animationGroup.beginTime = CACurrentMediaTime() + 2

        appleImageView.appleLayer.add(animationGroup, forKey: nil)
    }
    
    func animateCloudImage () {
       let cloudLayer = CAShapeLayer()
       cloudLayer.path = cloudImagePath.cgPath
       cloudLayer.lineWidth = 5
       cloudLayer.strokeColor = UIColor.blue.cgColor
       
       let strokeEndAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
       strokeEndAnimation.fromValue = 0
       strokeEndAnimation.toValue = 1

       let strokeStartAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
       strokeStartAnimation.fromValue = -0.1
       strokeStartAnimation.toValue = 0.6

       let animationGroup = CAAnimationGroup()
       animationGroup.animations = [strokeEndAnimation, strokeStartAnimation]
       animationGroup.repeatCount = .infinity
       animationGroup.duration = 5
       animationGroup.beginTime = CACurrentMediaTime() + 2

       cloudImageView.cloudLayer.add(animationGroup, forKey: nil)
   }

}

//Apple Logo
let appleImagePath: UIBezierPath = {
       let path = UIBezierPath()
       path.move(to: CGPoint(x: 110.89, y: 99.2))
       path.addCurve(to: CGPoint(x: 105.97, y: 108.09), controlPoint1: CGPoint(x: 109.5, y: 102.41), controlPoint2: CGPoint(x: 107.87, y: 105.37))
       path.addCurve(to: CGPoint(x: 99.64, y: 115.79), controlPoint1: CGPoint(x: 103.39, y: 111.8), controlPoint2: CGPoint(x: 101.27, y: 114.37))
       path.addCurve(to: CGPoint(x: 91.5, y: 119.4), controlPoint1: CGPoint(x: 97.11, y: 118.13), controlPoint2: CGPoint(x: 94.4, y: 119.33))
       path.addCurve(to: CGPoint(x: 83.99, y: 117.59), controlPoint1: CGPoint(x: 89.42, y: 119.4), controlPoint2: CGPoint(x: 86.91, y: 118.8))
       path.addCurve(to: CGPoint(x: 75.9, y: 115.79), controlPoint1: CGPoint(x: 81.06, y: 116.39), controlPoint2: CGPoint(x: 78.36, y: 115.79))
       path.addCurve(to: CGPoint(x: 67.58, y: 117.59), controlPoint1: CGPoint(x: 73.31, y: 115.79), controlPoint2: CGPoint(x: 70.54, y: 116.39))
       path.addCurve(to: CGPoint(x: 60.39, y: 119.49), controlPoint1: CGPoint(x: 64.61, y: 118.8), controlPoint2: CGPoint(x: 62.21, y: 119.43))
       path.addCurve(to: CGPoint(x: 52.07, y: 115.79), controlPoint1: CGPoint(x: 57.6, y: 119.61), controlPoint2: CGPoint(x: 54.83, y: 118.38))
       path.addCurve(to: CGPoint(x: 45.44, y: 107.82), controlPoint1: CGPoint(x: 50.3, y: 114.24), controlPoint2: CGPoint(x: 48.09, y: 111.58))
       path.addCurve(to: CGPoint(x: 38.44, y: 93.82), controlPoint1: CGPoint(x: 42.6, y: 103.8), controlPoint2: CGPoint(x: 40.27, y: 99.14))
       path.addCurve(to: CGPoint(x: 35.5, y: 77.15), controlPoint1: CGPoint(x: 36.48, y: 88.09), controlPoint2: CGPoint(x: 35.5, y: 82.53))
       path.addCurve(to: CGPoint(x: 39.48, y: 61.21), controlPoint1: CGPoint(x: 35.5, y: 70.98), controlPoint2: CGPoint(x: 36.82, y: 65.67))
       path.addCurve(to: CGPoint(x: 47.8, y: 52.74), controlPoint1: CGPoint(x: 41.56, y: 57.63), controlPoint2: CGPoint(x: 44.33, y: 54.81))
       path.addCurve(to: CGPoint(x: 59.06, y: 49.54), controlPoint1: CGPoint(x: 51.27, y: 50.67), controlPoint2: CGPoint(x: 55.02, y: 49.61))
       path.addCurve(to: CGPoint(x: 67.76, y: 51.58), controlPoint1: CGPoint(x: 61.27, y: 49.54), controlPoint2: CGPoint(x: 64.16, y: 50.23))
       path.addCurve(to: CGPoint(x: 74.67, y: 53.62), controlPoint1: CGPoint(x: 71.35, y: 52.94), controlPoint2: CGPoint(x: 73.66, y: 53.62))
       path.addCurve(to: CGPoint(x: 82.33, y: 51.22), controlPoint1: CGPoint(x: 75.42, y: 53.62), controlPoint2: CGPoint(x: 77.98, y: 52.82))
       path.addCurve(to: CGPoint(x: 92.73, y: 49.36), controlPoint1: CGPoint(x: 86.43, y: 49.73), controlPoint2: CGPoint(x: 89.9, y: 49.12))
       path.addCurve(to: CGPoint(x: 110.05, y: 58.53), controlPoint1: CGPoint(x: 100.43, y: 49.98), controlPoint2: CGPoint(x: 106.2, y: 53.03))
       path.addCurve(to: CGPoint(x: 99.83, y: 76.13), controlPoint1: CGPoint(x: 103.17, y: 62.72), controlPoint2: CGPoint(x: 99.77, y: 68.59))
       path.addCurve(to: CGPoint(x: 106.17, y: 90.76), controlPoint1: CGPoint(x: 99.89, y: 82), controlPoint2: CGPoint(x: 102.01, y: 86.88))
       path.addCurve(to: CGPoint(x: 112.5, y: 94.94), controlPoint1: CGPoint(x: 108.05, y: 92.56), controlPoint2: CGPoint(x: 110.16, y: 93.95))
       path.addCurve(to: CGPoint(x: 110.89, y: 99.2), controlPoint1: CGPoint(x: 111.99, y: 96.42), controlPoint2: CGPoint(x: 111.46, y: 97.84))
       
       // Leaf
       path.move(to: CGPoint(x: 93.25, y: 29.36))
       path.addCurve(to: CGPoint(x: 88.25, y: 42.23), controlPoint1: CGPoint(x: 93.25, y: 33.96), controlPoint2: CGPoint(x: 91.58, y: 38.26))
       path.addCurve(to: CGPoint(x: 74.1, y: 49.26), controlPoint1: CGPoint(x: 84.23, y: 46.96), controlPoint2: CGPoint(x: 79.37, y: 49.69))
       path.addCurve(to: CGPoint(x: 74, y: 47.52), controlPoint1: CGPoint(x: 74.03, y: 48.71), controlPoint2: CGPoint(x: 74, y: 48.13))
       path.addCurve(to: CGPoint(x: 79.3, y: 34.51), controlPoint1: CGPoint(x: 74, y: 43.1), controlPoint2: CGPoint(x: 75.91, y: 38.38))
       path.addCurve(to: CGPoint(x: 85.76, y: 29.63), controlPoint1: CGPoint(x: 80.99, y: 32.55), controlPoint2: CGPoint(x: 83.15, y: 30.93))
       path.addCurve(to: CGPoint(x: 93.15, y: 27.52), controlPoint1: CGPoint(x: 88.37, y: 28.35), controlPoint2: CGPoint(x: 90.83, y: 27.65))
       path.addCurve(to: CGPoint(x: 93.25, y: 29.36), controlPoint1: CGPoint(x: 93.22, y: 28.14), controlPoint2: CGPoint(x: 93.25, y: 28.75))
       path.addLine(to: CGPoint(x: 93.25, y: 29.36))
       
       path.close()
       return path
}()

//Cloud Image
let cloudImagePath: UIBezierPath = {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 79.02, y: 39.00))
    path.addCurve(to: CGPoint(x: 77.27, y: 39.61), controlPoint1: CGPoint(x: 79.76, y: 39.00), controlPoint2: CGPoint(x: 78.50, y: 39.21))
    path.addCurve(to: CGPoint(x: 69.09, y: 22.30), controlPoint1: CGPoint(x: 76.33, y: 32.13), controlPoint2: CGPoint(x: 73.32, y: 25.75))
    path.addCurve(to: CGPoint(x: 55.57, y: 21.90), controlPoint1: CGPoint(x: 64.86, y: 18.84), controlPoint2: CGPoint(x: 59.87, y: 18.70))
    path.addCurve(to: CGPoint(x: 29.07, y: 02.00), controlPoint1: CGPoint(x: 51.67, y: 04.65), controlPoint2: CGPoint(x: 39.81, y: 04.26))
    path.addCurve(to: CGPoint(x: 16.69, y: 44.59), controlPoint1: CGPoint(x: 18.34, y: 08.26), controlPoint2: CGPoint(x: 12.79, y: 27.33))
    path.addCurve(to: CGPoint(x: 00.00, y: 72.70), controlPoint1: CGPoint(x: 07.29, y: 45.07), controlPoint2: CGPoint(x: 00.13, y: 57.58))
    path.addCurve(to: CGPoint(x: 17.21, y: 100.00), controlPoint1: CGPoint(x: 00.14, y: 87.82), controlPoint2: CGPoint(x: 07.80, y: 99.97))
    path.addLine(to: CGPoint(x: 81.02, y: 100.00))
    path.addCurve(to: CGPoint(x: 100.00, y: 69.50), controlPoint1: CGPoint(x: 91.50, y: 100.00), controlPoint2: CGPoint(x: 100.00, y: 86.34))
    path.addCurve(to: CGPoint(x: 79.02, y: 39.00), controlPoint1: CGPoint(x: 100.00, y: 52.66), controlPoint2: CGPoint(x: 91.50, y: 39.00))
    //path.closeSubpath()
    path.close()
    return path
}()
