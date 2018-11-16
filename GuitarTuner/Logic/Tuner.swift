
import AudioKit
import Foundation

protocol TunerDelegate {
    /**
     * The tuner calls this delegate function when it detects a new pitch. The
     * Pitch object is the nearest note (A-G) in the nearest octave. The
     * distance is between the actual tracked frequency and the nearest note.
     * Finally, the amplitude is the volume (note: of all frequencies).
     */
    func tunerDidMeasurePitch(pitch: Pitch, withDistance distance: Double,
                              amplitude: Double)
}

class Tuner: NSObject {
    var delegate: TunerDelegate?


    private var timer:      NSTimer?
    private let microphone: AKMicrophone
    private let analyzer:   AKAudioAnalyzer

    override init() {
      
        AKManager.sharedManager().enableAudioInput()
        microphone = AKMicrophone()
        AKOrchestra.addInstrument(microphone)
        analyzer = AKAudioAnalyzer(input: microphone.output)
        AKOrchestra.addInstrument(analyzer)
    }

    func startMonitoring() {
       
        analyzer.play()
        microphone.play()

        /* Initialize and schedule a new run loop timer. */
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self,selector: "tick",userInfo: nil,repeats: true)
    }

    func stopMonitoring()
    {
        analyzer.stop()
        microphone.stop()
        timer?.invalidate()
    }

    func tick()
    {
        /* Read frequency and amplitude from the analyzer. */
        let frequency = Double(analyzer.trackedFrequency.floatValue)
        let amplitude = Double(analyzer.trackedAmplitude.floatValue)

        /* Find nearest pitch. */
        let pitch = Pitch.nearest(frequency)

        /* Calculate the distance. */
        let distance = frequency - pitch.frequency

        /* Call the delegate. */
        self.delegate?.tunerDidMeasurePitch(pitch, withDistance: distance,
                                            amplitude: amplitude)
    }
}
