import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var systemMessage: UILabel!
    @IBOutlet weak var newGameBtn: UIButton!
    @IBOutlet weak var remindMessage: UILabel!
    @IBOutlet weak var resultFace: UIImageView!
    
    var answer: Int?
    var guessCount: Int?
    
    func newGameStarts() {
        answer = Int.random(in: 1...100)
        guessCount = 0
        print(answer!)
        input.text = ""
        input.isUserInteractionEnabled = true
        confirm.isHidden = false
        remindMessage.isHidden = false
        remindMessage.text = "5 tries left!"
        resultFace.isHidden = true
        systemMessage.text = ""
        newGameBtn.isHidden = true
    }
    
    func gameEnds_WIN() {
        input.text = "You win!"
        input.isUserInteractionEnabled = false
        confirm.isHidden = true
        remindMessage.isHidden = true
        resultFace.isHidden = false
        resultFace.image = UIImage(named: "smile-1.jpg")
        systemMessage.text = "Correct! The answer is \(String(answer!))."
        newGameBtn.isHidden = false
    }
    
    func gameEnds_LOSE() {
        input.text = "You lose!"
        input.isUserInteractionEnabled = false
        confirm.isHidden = true
        remindMessage.isHidden = true
        resultFace.isHidden = false
        resultFace.image = UIImage(named: "sad-1.jpg")
        systemMessage.text = "Fail the game! The answer is \(String(answer!))."
        newGameBtn.isHidden = false
    }
    
    @IBAction func clickConfirm(sender: UIButton) {
        if(input.text != "") {
            if let userInput = Int(input.text!) {
                if(userInput > 100 || userInput <= 0) {
                    let alertController = UIAlertController(title: "Wrong input!", message: "Please enter a number between 1 to 100", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    present(alertController, animated: true, completion: nil)
                }
                else if(userInput > answer!) {
                    systemMessage.text = "Less than \(userInput)"
                    guessCount! += 1
                    // refresh the remind message
                    let countsLeft: Int = 5 - guessCount!
                    if(countsLeft == 1) {
                        remindMessage.text = "1 try left"
                    }
                    else {
                        remindMessage.text = "\(countsLeft) tries left"
                    }
                }
                else if(userInput < answer!) {
                    systemMessage.text = "Greater than \(userInput)"
                    guessCount! += 1
                    // refresh the remind message
                    let countsLeft: Int = 5 - guessCount!
                    if(countsLeft == 1) {
                        remindMessage.text = "1 try left"
                    }
                    else {
                        remindMessage.text = "\(countsLeft) tries left"
                    }
                }
                else if(userInput == answer!) {
                    gameEnds_WIN()
                }
            }
            else {
                let alertController = UIAlertController(title: "Wrong input!", message: "This is an invalid number", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
            if(guessCount == 5) {
                gameEnds_LOSE()
            }
        }
        else {
            let alertController = UIAlertController(title: "Wrong input!", message: "Please input a number into the text field", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func clickNewGame() {
        newGameStarts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGameStarts()
    }
}
