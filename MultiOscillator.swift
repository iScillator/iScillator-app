import AVFoundation
import CoreAudio

let twoPi = 2 * Float.pi

/// Multi Swift oscillator
@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)
public class MultiOscillator: Node {
    fileprivate lazy var sourceNode = AVAudioSourceNode { [self] _, _, frameCount, audioBufferList in
        let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
        
        if self.isStarted {
            //let phaseIncrement = (twoPi / Float(Settings.sampleRate)) * self.frequency
            for frame in 0..<Int(frameCount) {
                // Get signal value for this frame at time.
                //let index = Int(self.currentPhase / twoPi * Float(self.waveform!.count))
                //let value = self.waveform![index] * self.amplitude
                let value=

                // Advance the phase for the next frame.
                self.currentPos += 1
                //if self.currentPhase >= twoPi { self.currentPhase -= twoPi }
                //if self.currentPhase < 0.0 { self.currentPhase += twoPi }
                // Set the same value on all channels (due to the inputFormat we have only 1 channel though).
                for buffer in ablPointer {
                    let buf: UnsafeMutableBufferPointer<Float> = UnsafeMutableBufferPointer(buffer)
                    buf[frame] = value
                }
            }
        }
        return noErr
    }
    
    /// Connected nodes
    public var connections: [Node] { [] }
    
    /// Underlying AVAudioNode
    public var avAudioNode: AVAudioNode { sourceNode }
    
    private var currentPhase: Float = 0
    private var currentPos: Int = 0

    //fileprivate var waveform: Table?
    
    /// Pitch in Hz
    public var frequency: Float = 440
    
    /// Volume usually 0-1
    public var amplitude: AUValue = 1
    

    public var target: Double = 528
    public var enviroment: Double = 0
    public var modulation: Double = 0
    public var multi: Double = 0
    public var channel: Double = 0
    public var audio: Double = 0


    public double getValuePosDouble(int xp, int sampleRate, int position, int bufferSamplesSize, int channel) {

        double y,y_step,t1,t2,mod_amplitude;
        int x;

        x=(position*bufferSamplesSize)+xp;
        return Math.sin(x/100*twoPi);
    }

    public init(target: Double = 528, enviroment: Double = 0, modulation: Double = 0, multi: Double = 0, channel: Double = 0, audio: Double = 0) {
        self.target = target
        self.enviroment = enviroment
        self.modulation = modulation
        self.multi = multi
        self.channel = channel
        self.audio = audio
        
        stop()
    }
}