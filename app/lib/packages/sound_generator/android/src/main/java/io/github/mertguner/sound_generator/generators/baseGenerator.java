package io.github.mertguner.sound_generator.generators;

public abstract class baseGenerator {
    public void setFrequency(float frequency)
    {
        return;
    }
    public void getBuffer(short[] backgroundBuffer, int sampleRate, int position, int bufferSamplesSize)
    {
        return;
    }
    public abstract short getValue(double phase, double period);

}
