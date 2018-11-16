import AudioKit
import UIKit

class ViewController: UIViewController, TunerDelegate
{
    let tuner       = Tuner()
    let displayView = DisplayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .blackColor()
        /* Start the tuner. */
        tuner.delegate = self
        tuner.startMonitoring()
    }
        /* Calculate the difference between the nearest pitch and the second
         * nearest pitch to express the distance in a percentage. */
        let previous   = pitch - 1
        let next       = pitch + 1
        let difference = distance < 0 ?
                         (pitch.frequency - previous.frequency) :
                         (next.frequency  - pitch.frequency)
    }

    override func didReceiveMemoryWarning() {super.didReceiveMemoryWarning()}
}

