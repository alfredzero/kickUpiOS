import UIKit

class ViewController: UIViewController {
    
    let ballView = UIImageView()
    var yAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the ball view
        ballView.image = UIImage(named: "Image")
        ballView.layer.cornerRadius = 25 // Make sure this is half of width/height
        ballView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ballView)
        ballView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        ballView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        ballView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // Start position of the ball in the center
        yAnchor = ballView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        yAnchor.isActive = true
        
        // Add a tap gesture recognizer to the ball
        ballView.isUserInteractionEnabled = true
        ballView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(kickBall)))
    }
    
    func bounceBall() {
        // Set the bounce to move up then down and stop
        let upPosition = -300 // Move up
        let downPosition = 0 // Move back to center
        
        // Move the ball up
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.yAnchor.constant = CGFloat(upPosition)
            self.view.layoutIfNeeded()
        }) { (complete) in
            // Move the ball back down to the center and stop
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.curveEaseIn], animations: {
                self.yAnchor.constant = CGFloat(downPosition)
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc func kickBall() {
        // Ensure any previous animations are stopped
        ballView.layer.removeAllAnimations()

        // Reset the yAnchor to the initial position to handle multiple taps
        yAnchor.isActive = false
        yAnchor = ballView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
        yAnchor.isActive = true

        // Start the bounce animation
        bounceBall()
    }
}
