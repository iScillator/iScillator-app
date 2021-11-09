package com.ToneAndroidPackage;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import android.media.AudioFormat;
import android.media.AudioManager;
import android.media.AudioTrack;
import android.os.SystemClock;


public class ToneAndroidModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;
    // originally from http://marblemice.blogspot.com/2010/04/generate-and-play-tone-in-android.html
  	// and modified by Steve Pomeroy <steve@staticfree.info>

    AudioTrack audioTrack;
    private int duration = 5000; // milliseconds seconds // maxduration
    private int sampleRate = 48000; // 48000-recomended // 192000 - special devices// from sample 8000; // As of API Build.VERSION_CODES.M, sample rates up to 192kHz are supported for AudioRecord and AudioTrack, with sample rate conversion performed as needed. To improve efficiency and avoid lossy conversions, it is recommended to match the sample rate for AudioRecord and AudioTrack to the endpoint device sample rate, and limit the sample rate to no more than 48kHz unless there are special device capabilities that warrant a higher rate.
    private int numSamples = duration * (sampleRate/1000);
    private double sample[] = new double[numSamples];

    //private double sample[] = new float[numSamples];

    private int freqOfTone = 880;
    private final byte generatedSnd[] = new byte[2 * 16000*6];

    //private final byte generatedSnd[] = new float[2 * numSamples];

    public ToneAndroidModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "ToneAndroid";
    }

    void playblocking(int freq, int durationms) {
      	freqOfTone = freq;
      	duration = durationms;
      	numSamples = duration * (sampleRate/1000);

        genTone();
        playSound();
    }

    void genTone(){
        // fill out the array
        for (int i = 0; i < numSamples; ++i) {
            sample[i] = Math.sin(2 * Math.PI * i / (sampleRate/freqOfTone));
        }

        // convert to 16 bit pcm sound array
        // assumes the sample buffer is normalised.
        int idx = 0;
        for (final double dVal : sample) {
            // scale to maximum amplitude
            final short val = (short) ((dVal * 32767));
            // in 16 bit wav PCM, first byte is the low order byte
            generatedSnd[idx++] = (byte) (val & 0x00ff);
            generatedSnd[idx++] = (byte) ((val & 0xff00) >>> 8);

        }
    }

    void playSound(){
    	try {
    	// WAS STREAM_NOTIFICATION
    	/*
        audioTrack = new AudioTrack(AudioManager.STREAM_SYSTEM,
                sampleRate, AudioFormat.CHANNEL_OUT_STEREO,
                AudioFormat.ENCODING_PCM_FLOAT, numSamples,
                AudioTrack.MODE_STATIC);
        */
        //CHANNEL_OUT_7POINT1_SURROUND

    	audioTrack = new AudioTrack(AudioManager.STREAM_SYSTEM,
                sampleRate, AudioFormat.CHANNEL_OUT_MONO,
                AudioFormat.ENCODING_PCM_16BIT, numSamples,
                AudioTrack.MODE_STATIC);
        
        /*
        https://developer.android.com/reference/android/media/AudioFormat#sampleRate
        ENCODING_PCM_FLOAT: Introduced in API Build.VERSION_CODES.LOLLIPOP, this encoding specifies that the audio sample is a 32 bit IEEE single precision float. The sample can be manipulated as a Java float in a float array, though within a ByteBuffer it is stored in native endian byte order. The nominal range of ENCODING_PCM_FLOAT audio data is [-1.0, 1.0]. It is implementation dependent whether the positive maximum of 1.0 is included in the interval. Values outside of the nominal range are clamped before sending to the endpoint device. Beware that the handling of NaN is undefined; subnormals may be treated as zero; and infinities are generally clamped just like other values for AudioTrack – try to avoid infinities because they can easily generate a NaN.
        To achieve higher audio bit depth than a signed 16 bit integer short, it is recommended to use ENCODING_PCM_FLOAT for audio capture, processing, and playback. Floats are efficiently manipulated by modern CPUs, have greater precision than 24 bit signed integers, and have greater dynamic range than 32 bit signed integers. AudioRecord as of API Build.VERSION_CODES.M and AudioTrack as of API Build.VERSION_CODES.LOLLIPOP support ENCODING_PCM_FLOAT.
         */

      audioTrack.write(generatedSnd, 0, numSamples * 2);
      audioTrack.play();
      while(audioTrack.getPlaybackHeadPosition() < (numSamples/2)) {
      	SystemClock.sleep(1);
      }
      audioTrack.release();
    	} catch (Exception e){
    		e.printStackTrace();
    	}
    }



    @ReactMethod
    public void play(int frequency, int durationms) {
      playblocking(frequency,durationms);
    }
}
