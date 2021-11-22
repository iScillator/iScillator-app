package io.github.mertguner.sound_generator.generators;

public abstract class baseGenerator {
    public void setFrequency(float frequency)
    {
        return;
    }
    public void setParams(double tone_pow,double tone_shift)
    {
        return;
    }
    public void getBuffer(short[] backgroundBuffer, int sampleRate, int position, int bufferSamplesSize)
    {
        return;
    }
    public short getValuePos(int xp, int sampleRate, int position, int bufferSamplesSize) {
        return 0;
    }
    public abstract short getValue(double phase, double period);

}
