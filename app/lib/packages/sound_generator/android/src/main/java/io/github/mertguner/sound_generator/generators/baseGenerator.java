package io.github.mertguner.sound_generator.generators;

public abstract class baseGenerator {
    public void setFrequency(float frequency)
    {
        return;
    }
    public double getFrequency()
    {
        return 0;
    }
    public void setParams(String program, double target, double enviroment, double modulation, double multi, double channel, double audio)
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
    public int getValuePosInt(int xp, int sampleRate, int position, int bufferSamplesSize, int channel) {
        return 0;
    }
    public float getValuePosFloat(int xp, int sampleRate, int position, int bufferSamplesSize, int channel) {
        return 0;
    }

    public abstract short getValue(double phase, double period);

}
