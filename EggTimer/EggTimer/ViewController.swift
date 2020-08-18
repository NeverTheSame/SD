import UIKit
import AVFoundation

class ViewController: UIViewController
{

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes : [String : Int] =
                    ["Soft": 300,
                    "Medium": 420,
                    "Hard": 720]

    var timer = Timer()
    var player: AVAudioPlayer?

    var totalTime = 0
    var secondsPassed = 0
    

    @IBAction func hardnessSelected(_ sender: UIButton)
    {
        
        timer.invalidate()
        let hardness = sender.currentTitle! // Soft, Medium, Hard
        totalTime = eggTimes[hardness]!

        progressBar.setProgress(0.0, animated: true)
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateCounter()
    {
        if secondsPassed < totalTime
        {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            // print(Float(secondsPassed) / Float(totalTime))
        }
        else
        {

            timer.invalidate()
            titleLabel.text = "Done"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player?.play()
        }
    }
}