package io.github.mertguner.sound_generator.generators;

public abstract class baseGenerator {
    public void setFrequency(float frequency)
    {
        return;
    }
    public void setParams(double target, double enviroment, double modulation, double multi, double channel, double audio)
    {
        return;
    }
    public void getBuffer(short[] backgroundBuffer, int sampleRate, int position, int bufferSamplesSize)
    {
        return;
    }
    public short getValuePos(int xp, int sampleRate, int position, int bufferSamplesSize, int channel) {
        return 0;
    }
    public abstract short getValue(double phase, double period);

}
