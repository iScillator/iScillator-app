package io.github.mertguner.sound_generator.generators;

import java.util.ArrayList;
import java.util.List;

import io.github.mertguner.sound_generator.handlers.getOneCycleDataHandler;

public class signalDataGenerator {


    private final float _2Pi = 2.0f * (float) Math.PI;

    private int sampleRate = 48000;
    private float phCoefficient = _2Pi / (float) sampleRate;
    private float smoothStep = 1f / (float) sampleRate * 20f;

    private float frequency = 50;
    private baseGenerator generator = new sinusoidalGenerator();

    //private short[] backgroundBuffer;
    //private short[] buffer;

    //private int[] backgroundBuffer;
    //private int[] buffer;

    private float[] backgroundBuffer;
    private float[] buffer;


    private List<Integer> oneCycleBuffer = new ArrayList<>();
    private int bufferSamplesSize;
    private float ph = 0;
    private float oldFrequency = 50;
    private boolean creatingNewData = false;
    private boolean autoUpdateOneCycleSample = false;

    private boolean multi = false;
    //private int position = 0;

    public boolean isAutoUpdateOneCycleSample() { return autoUpdateOneCycleSample; }
    public void setAutoUpdateOneCycleSample(boolean autoUpdateOneCycleSample) { this.autoUpdateOneCycleSample = autoUpdateOneCycleSample; }

    public int getSampleRate() { return sampleRate; }
    public void setSampleRate(int sampleRate) {
        this.sampleRate = sampleRate;
        phCoefficient = _2Pi / (float) sampleRate;
        smoothStep = 1f / (float) sampleRate * 20f;
    }

    public baseGenerator getGenerator() {
        return generator;
    }
    public void setGenerator(baseGenerator generator,boolean multi) {
        this.generator = generator;
        this.multi = multi;
        createOneCycleData();
    }

    public float getFrequency() {
        return frequency;
    }
    
    public void setParams(double target, double enviroment, double modulation, double multi, double channel, double audio) {
    
        generator.setParams(target, enviroment, modulation, multi, channel, audio);
    }

    public void setFrequency(float frequency) {
        this.frequency = frequency;
 
        if (this.multi)
        {
            generator.setFrequency(frequency);
        }

        createOneCycleData();
    }

    public signalDataGenerator(int bufferSamplesSize, int sampleRate, int channelMask, int encoding) {
        this.bufferSamplesSize = bufferSamplesSize;        
        //backgroundBuffer = new short[bufferSamplesSize];
        //buffer = new short[bufferSamplesSize];

        //backgroundBuffer = new int[bufferSamplesSize];
        //buffer = new int[bufferSamplesSize];

        backgroundBuffer = new float[bufferSamplesSize];
        buffer = new float[bufferSamplesSize];


        setSampleRate(sampleRate);
        updateData(0);
        createOneCycleData();
    }

    private void updateData(int position) {
        //short y;
        short s;
        int y;
        double d;


        creatingNewData = true;
        if (this.multi) 
        {
            //generator.getBuffer(backgroundBuffer,sampleRate,position,bufferSamplesSize);         
            
            for (int i = 0; i < bufferSamplesSize/2; i++) {
                backgroundBuffer[i*2] = generator.getValuePosFloat( i, sampleRate, position, bufferSamplesSize/2,1);
                backgroundBuffer[i*2+1] = generator.getValuePosFloat( i, sampleRate, position, bufferSamplesSize/2,2);
            }

        } else {
            for (int i = 0; i < bufferSamplesSize/2; i++) {
                oldFrequency += ((frequency - oldFrequency) * smoothStep);
                s=generator.getValue(ph, _2Pi);
                d=1.0*s/Short.MAX_VALUE;
                y=(int)(d*Integer.MAX_VALUE);
                backgroundBuffer[i*2] = (float)d;
                backgroundBuffer[i*2+1] = (float)d;
                ph += (oldFrequency * phCoefficient);

                //performance of this block is higher than ph %= _2Pi;
                // ifBlock  Test score =  2,470ns
                // ModBlock Test score = 27,025ns
                if (ph > _2Pi) {
                    ph -= _2Pi;
                }
            }
        }
        creatingNewData = false;
    }

/*
    public short[] getData(int position1) {
        final int position2=position1;
        if (!creatingNewData) {
            System.arraycopy(backgroundBuffer, 0, buffer, 0, bufferSamplesSize);
            new Thread(new Runnable() {
                @Override
                public void run() {
                    updateData(position2);
                }
            }).start();
        } else {
            android.util.Log.d("SoundHealer", "creatingNewData, bad, send old buffer");
        }
        return this.buffer;
    }*/

/*
    public int[] getDataInt(int position1) {
        final int position2=position1;
        if (!creatingNewData) {
            System.arraycopy(backgroundBuffer, 0, buffer, 0, bufferSamplesSize);
            new Thread(new Runnable() {
                @Override
                public void run() {
                    updateData(position2);
                }
            }).start();
        } else {
            android.util.Log.d("SoundHealer", "creatingNewData, bad, send old buffer");
        }
        return this.buffer;
    }
*/

    public float[] getDataFloat(int position1) {
        final int position2=position1;
        if (!creatingNewData) {
            System.arraycopy(backgroundBuffer, 0, buffer, 0, bufferSamplesSize);
            new Thread(new Runnable() {
                @Override
                public void run() {
                    updateData(position2);
                }
            }).start();
        } else {
            android.util.Log.d("SoundHealer", "creatingNewData, bad, send old buffer");
        }
        return this.buffer;
    }

    public void createOneCycleData() {
        createOneCycleData(false);
    }

    public void createOneCycleData(boolean force) {
        if (this.multi) return;
        if (generator == null || (!autoUpdateOneCycleSample && !force))
            return;

        int size = Math.round(_2Pi / (frequency * phCoefficient));

        oneCycleBuffer.clear();
        for (int i = 0; i < size; i++) {
            oneCycleBuffer.add((int)generator.getValue((frequency * phCoefficient) * (float) i, _2Pi));
        }
        oneCycleBuffer.add((int)generator.getValue(0, _2Pi));
        getOneCycleDataHandler.setData(oneCycleBuffer);
    }
}
