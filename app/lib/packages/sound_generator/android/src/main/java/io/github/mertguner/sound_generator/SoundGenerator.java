package io.github.mertguner.sound_generator;

import android.annotation.TargetApi;
import android.media.AudioFormat;
import android.media.AudioManager;
import android.media.AudioTrack;
import android.os.Build;

import io.github.mertguner.sound_generator.generators.sawtoothGenerator;
import io.github.mertguner.sound_generator.generators.signalDataGenerator;
import io.github.mertguner.sound_generator.generators.sinusoidalGenerator;
import io.github.mertguner.sound_generator.generators.squareWaveGenerator;
import io.github.mertguner.sound_generator.generators.triangleGenerator;
import io.github.mertguner.sound_generator.handlers.isPlayingStreamHandler;
import io.github.mertguner.sound_generator.models.WaveTypes;

@TargetApi(Build.VERSION_CODES.CUPCAKE)
public class SoundGenerator {

    private Thread bufferThread;
    private AudioTrack audioTrack;
    private signalDataGenerator generator;
    private boolean isPlaying = false;
    private int minSamplesSize;
    private WaveTypes waveType = WaveTypes.SINUSOIDAL;
    private float rightVolume = 1, leftVolume = 1;

    public void setAutoUpdateOneCycleSample(boolean autoUpdateOneCycleSample) {
        if (generator != null)
            generator.setAutoUpdateOneCycleSample(autoUpdateOneCycleSample);
    }

    public int getSampleRate() {
        if (generator != null)
            return generator.getSampleRate();
        return 0;
    }

    public void setSampleRate(int sampleRate) {
        if (generator != null)
            generator.setSampleRate(sampleRate);
    }

    public void refreshOneCycleData() {
        if (generator != null)
            generator.createOneCycleData(true);
    }

    public void setFrequency(float v) {
        if (generator != null)
            generator.setFrequency(v);
    }

    public float getFrequency() {
        if (generator != null)
            return generator.getFrequency();
        return 0;
    }

    public void setBalance(float balance) {
        balance = Math.max(-1, Math.min(1, balance));

        rightVolume = (balance >= 0) ? 1 : (balance == -1) ? 0 : (1 + balance);
        leftVolume = (balance <= 0) ? 1 : (balance == 1) ? 0 : (1 - balance);
        if (audioTrack != null) {
            audioTrack.setStereoVolume(leftVolume, rightVolume);
        }
    }


    public void setVolume(float volume) {
        volume = Math.max(0, Math.min(1, volume));

        if (audioTrack != null) {
            audioTrack.setStereoVolume(leftVolume * volume, rightVolume * volume);
        }
    }

    public void setWaveform(WaveTypes waveType) {
        if (this.waveType.equals(waveType) || (generator == null))
            return;

        this.waveType = waveType;

        if (waveType.equals(WaveTypes.SINUSOIDAL))
            generator.setGenerator(new sinusoidalGenerator());
        else if (waveType.equals(WaveTypes.TRIANGLE))
            generator.setGenerator(new triangleGenerator());
        else if (waveType.equals(WaveTypes.SQUAREWAVE))
            generator.setGenerator(new squareWaveGenerator());
        else if (waveType.equals(WaveTypes.SAWTOOTH))
            generator.setGenerator(new sawtoothGenerator());
    }

    //public boolean init(int sampleRate /* ,*/) {
    public boolean init(int sampleRate, int channelMask, int encoding) {
        try {

        /*

        # sample rate
        https://developer.android.com/reference/android/media/AudioFormat#sampleRate

        As of API Build.VERSION_CODES.M, sample rates up to 192kHz are supported for AudioRecord and AudioTrack, with sample rate conversion performed as needed. To improve efficiency and avoid lossy conversions, it is recommended to match the sample rate for AudioRecord and AudioTrack to the endpoint device sample rate, and limit the sample rate to no more than 48kHz unless there are special device capabilities that warrant a higher rate.
        default=48K
        up to 192k
        audigy 96K

        # encoding
        https://developer.android.com/reference/android/media/AudioFormat#encoding

        2 ENCODING_PCM_16BIT

        4 ENCODING_PCM_FLOAT: Introduced in API Build.VERSION_CODES.LOLLIPOP, this encoding specifies that the audio sample is a 32 bit IEEE single precision float. The sample can be manipulated as a Java float in a float array, though within a ByteBuffer it is stored in native endian byte order. The nominal range of ENCODING_PCM_FLOAT audio data is [-1.0, 1.0]. It is implementation dependent whether the positive maximum of 1.0 is included in the interval. Values outside of the nominal range are clamped before sending to the endpoint device. Beware that the handling of NaN is undefined; subnormals may be treated as zero; and infinities are generally clamped just like other values for AudioTrack – try to avoid infinities because they can easily generate a NaN.
        To achieve higher audio bit depth than a signed 16 bit integer short, it is recommended to use ENCODING_PCM_FLOAT for audio capture, processing, and playback. Floats are efficiently manipulated by modern CPUs, have greater precision than 24 bit signed integers, and have greater dynamic range than 32 bit signed integers. AudioRecord as of API Build.VERSION_CODES.M and AudioTrack as of API Build.VERSION_CODES.LOLLIPOP support ENCODING_PCM_FLOAT.
        
        22 ENCODING_PCM_32BIT: Introduced in API Build.VERSION_CODES.S, this encoding specifies the audio sample is an extended precision 32 bit signed integer stored as a 4 Java bytes in a ByteBuffer or byte array in native endian (see ByteOrder.nativeOrder()). Each sample has full range from [-2147483648, 2147483647], and can be interpreted as fixed point Q.31 data.
        
        ==== now using 32BIT, later may be FLOAT
        
        # Channel position masks
        https://developer.android.com/reference/android/media/AudioFormat#channelPositionMask
        
        1	CHANNEL_OUT_MONO
        2	CHANNEL_OUT_STEREO
        3	CHANNEL_OUT_STEREO | CHANNEL_OUT_FRONT_CENTER
        4	CHANNEL_OUT_QUAD
        5	CHANNEL_OUT_QUAD | CHANNEL_OUT_FRONT_CENTER
        6	CHANNEL_OUT_5POINT1
        7	CHANNEL_OUT_5POINT1 | CHANNEL_OUT_BACK_CENTER
        8	CHANNEL_OUT_7POINT1_SURROUND

        */
            minSamplesSize = AudioTrack.getMinBufferSize(
                    sampleRate,
                    channelMask, // was AudioFormat.CHANNEL_OUT_MONO,
                    encoding); // was AudioFormat.ENCODING_PCM_16BIT);

            generator = new signalDataGenerator(minSamplesSize, sampleRate);

            audioTrack = new AudioTrack(
                    AudioManager.STREAM_SYSTEM, //was AudioManager.STREAM_MUSIC,
                    sampleRate,
                    channelMask, //was AudioFormat.CHANNEL_OUT_MONO,
                    encoding, //was AudioFormat.ENCODING_PCM_16BIT,
                    minSamplesSize,
                    AudioTrack.MODE_STREAM);

            return true;
        }catch (Exception ex)
        {
            return false;
        }
    }

    public boolean isPlaying() {
        return isPlaying;
    }

    public void startPlayback() {
        if (bufferThread != null || audioTrack == null) return;

        isPlaying = true;

        bufferThread = new Thread(new Runnable() {
            @Override
            public void run() {
                audioTrack.flush();
                audioTrack.setPlaybackHeadPosition(0);
                audioTrack.play();
                while (isPlaying) {
                    audioTrack.write(generator.getData(), 0, minSamplesSize);
                }
            }
        }
        );

        isPlayingStreamHandler.change(true);

        bufferThread.start();
    }

    public void stopPlayback() {
        if (bufferThread == null) return;

        isPlaying = false;

        try {
            bufferThread.join(); //Waiting thread
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        isPlayingStreamHandler.change(false);
        bufferThread = null;

        if (audioTrack != null) {
            audioTrack.stop();
        }
    }

    public void release() {
        if (isPlaying())
            stopPlayback();
        audioTrack.release();
    }

}
